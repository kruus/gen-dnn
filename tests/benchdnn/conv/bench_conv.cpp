/*******************************************************************************
* Copyright 2017 Intel Corporation
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*******************************************************************************/

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <float.h>
#include <math.h>
#if defined(_SX)
#include <libgen.h>	/* dirname and strnlen tucked away here! */
#endif

#include "mkldnn.h"

#include "mkldnn_common.hpp"
#include "mkldnn_memory.hpp"

#include "conv/conv.hpp"
#include "conv/conv_test_data.hpp"

#include "conv/input_conv.hpp"

namespace conv {

/* global driver parameters */
const dt_conf_t *cfg = conf_f32;
const char *pattern = NULL;
dir_t dir = FWD_B;
int mb = 0;
alg_t alg = DIRECT;
merge_t merge = NONE;
attr_t attr;
const char *skip_impl = "";
bool allow_unimpl = false;
// old: const char *perf_template = "perf,%n,%d,%GO,%GF,%-t,%-Gp,%0t,%0Gp";
const char *perf_template = "perf,%n,%d,%GO,%GF,%-t,%-Gp,%0t,%0Gp,%i";

void reset_parameters() {
    cfg = conf_f32;
    pattern = NULL;
    dir = FWD_B;
    mb = 0;
    alg = DIRECT;
    merge = NONE;
    attr = attr_t();
    skip_impl = "";
    attr = attr_t();
    allow_unimpl = false;
}

/** return true if we think mkldnn ought to support this problem. */
bool check_mkldnn_support( const prb_t *p, res_t *res ) {
    char const *errmsg = nullptr;
#if 0 // v0.11 mkl-dnn now allows dilates for backward convolutions
    if ((p->dir == BWD_D || p->dir == BWD_W || p->dir == BWD_WB)
            && (p->dh>0 || p->dw>0)) {
        printf(" dilation: p->dh=%d, p->dw=%d", p->dh, p->dw);
        errmsg="mkl-dnn BWD + dilation not possible (yet?)";
    }
#endif
    // others? ...
    if (errmsg != nullptr){
        printf("\nUNTESTABLE: mkl-dnn probably doesn't handle this case yet\n"
               "          %s\n", errmsg);
        auto &bs = benchdnn_stat;
        res->state = SKIPPED;
        ++bs.skipped;
    }
    return errmsg == nullptr;
}
void check_correctness(const desc_t *c) {
    const prb_t p(*c, dir, cfg, alg, merge, attr, mb);
    char pstr[max_prb_len];
    prb2str(&p, pstr);
    //RT_ASSERT( p.oh > 0 && p.ow > 0 );

    if (pattern && !match_regex(pstr, pattern))
        return;
    print(1, "run: %s", pstr);

    //res_t res{ .state=UNTESTED };
    res_t res{};
    auto &bs = benchdnn_stat;

#if 1
    // Nicely avoid unsupported things:
    const bool mkldnn_ok = check_mkldnn_support(&p, &res);
    int status = (mkldnn_ok? conv::doit(&p, &res): OK); // <-- run benchmark
#else
    const bool mkldnn_ok = true;
    int status = conv::doit(&p, &res);
#endif
    RT_ASSERT( status == OK || status == FAIL );

    // XXX TODO output messages based on bs directly
    const char *state = state2str(res.state);

    switch (res.state) {
    case UNTESTED:
        ++bs.skipped; // ???
#if 0 // MASTER, UNUSED
        if (!(bench_mode & CORR)) {
            want_perf_report = true;
            break;
        }
#endif
    case SKIPPED:
        assert(status == OK);
        print(0, "%d:%s __REPRO: %s\n", bs.tests, state, pstr);
        break;
    case FAILED:
        // XXX assert(status == FAIL);
        print(0, "%d:%s (errors:%lu total:%lu) __REPRO: %11g ops %s %s\n", bs.tests, state,
                (long unsigned)res.errors, (long unsigned)res.total, p.ops, dir2str(p.dir), pstr);
        break;
    case UNIMPLEMENTED:
        assert(status == FAIL);
        print(0, "%d:%s __REPRO: %11.2g ops %s %s\n", bs.tests, state, p.ops, dir2str(p.dir), pstr);
        break;
    case MISTRUSTED:
        assert(status == OK);
        print(0, "%d:%s __REPRO: %11.2g ops %s %s\n", bs.tests, state, p.ops, dir2str(p.dir), pstr);
        break;
    case PASSED:
        assert(status == OK);
        print(0, "%d:%s __REPRO: %11.2g ops %s %s\n", bs.tests, state, p.ops, dir2str(p.dir), pstr);
        break;
    default:
        RT_ASSERT(!"unknown state");
    }

    ++bs.tests;
    if(mkldnn_ok && (bench_mode & TEST)){
        bs.ts->prt();
    }

}

int batch(const char *fname);

int bench(int argc, char **argv, bool main_bench) {
    static bool own_ts = false;
    static unsigned recurse = 0U;

    int const dbg_alloc = 20;
    print(dbg_alloc, "%s recurse=%u\n", "***** conv/bench_conv.cpp *****", recurse);
    if (recurse == 0U){
        if ((benchdnn_stat.ts == nullptr)){
            print(dbg_alloc, "%s", "***** new test_stats\n");
            benchdnn_stat.ts = new test_stats();
            own_ts = true;
        }
    }
    ++recurse;

    for (int arg = 0; arg < argc; ++arg) {
        if (!strncmp("--batch=", argv[arg], 8))
            SAFE(batch(argv[arg] + 8), CRIT);
        else if (!strncmp("--cfg=", argv[arg], 6))
            cfg = str2cfg(argv[arg] + 6);
        else if (!strncmp("--match=", argv[arg], 8))
            pattern = argv[arg] + 8;
        else if (!strncmp("--mb=", argv[arg], 5))
            mb = atoi(argv[arg] + 5);
        else if (!strncmp("--dir=", argv[arg], 6))
            dir = str2dir(argv[arg] + 6);
        else if (!strncmp("--alg=", argv[arg], 6))
            alg = str2alg(argv[arg] + 6);
        else if (!strncmp("--merge=", argv[arg], 8))
            merge = str2merge(argv[arg] + 8);
        else if (!strncmp("--attr=", argv[arg], 7))
            SAFE(str2attr(&attr, argv[arg] + 7), CRIT);
        else if (!strncmp("--skip-impl=", argv[arg], 12))
            skip_impl = argv[arg] + 12;
        else if (!strncmp("--allow-unimpl=", argv[arg], 15))
            allow_unimpl = str2bool(argv[arg] + 15);
        else if (!strncmp("--perf-template=", argv[arg], 16))
            perf_template = argv[arg] + 16;
        else if (!strcmp("--reset", argv[arg]))
            reset_parameters();
        else if (!strncmp("--mode=", argv[0], 7))
            bench_mode = str2bench_mode(argv[0] + 7);
        else if (!strncmp("-v", argv[arg], 2))
            verbose = atoi(argv[arg] + 2);
        else if (!strncmp("--verbose=", argv[arg], 10))
            verbose = atoi(argv[arg] + 10);
        else {
            desc_t c;
            if (str2desc(&c, argv[arg]) == FAIL) {
                fprintf(stderr, "driver: unknown option: `%s`, exiting...\n",
                        argv[arg]);
                exit(2);
            }
            check_correctness(&c);
        }
    }

    if (main_bench && benchdnn_stat.tests == 0) {
        const int N = sizeof(default_list) / sizeof(default_list[0]);
        print(0,"/* using default list of %d problems */", N);
        for (int n = 0; n < N; ++n)
            check_correctness(&default_list[n]);
    }

    --recurse;
    print(dbg_alloc, "%s recurse=%u\n", "*END* conv/bench_conv.cpp *****", recurse);
    if (recurse == 0 && own_ts){
        RT_ASSERT(benchdnn_stat.ts != nullptr);
        print(dbg_alloc, "%s", "***** delete test_stats\n");
        delete benchdnn_stat.ts;
        benchdnn_stat.ts = nullptr;
    }

    return OK;
}

#ifdef _WIN32
#include <windows.h>
#define PATH_MAX MAX_PATH
static char *dirname(char *path) {
    char drive[_MAX_DRIVE];
    char dir[_MAX_DIR];
    _splitpath(path, drive, dir, NULL, NULL);
    path[0] = '\0';
    if (drive != NULL) strncat(path, drive, _MAX_DRIVE);
    if (dir != NULL) strncat(path, dir, MAX_PATH);
    if (path[0] == '\0') strcat(path, ".");
    return path;
}
#elif !defined(DOXYGEN_SHOULD_SKIP_THIS)
#include <libgen.h>
#endif /* WIN32 */

FILE *open_batch_file(const char *fname) {
    const int max_paths = 4;

    static int n_paths = 0;
    static char search_paths[max_paths][PATH_MAX] = {{0}};

    char *fdir = NULL;
    {
        char fname_copy[PATH_MAX];
        strncpy(fname_copy, fname, PATH_MAX);
        fdir = dirname(fname_copy);
    }

    bool dir_found = false;
    for (int n = 0; n_paths < max_paths && n < n_paths; ++n)
        if (!strcmp(fdir, search_paths[n])) {
            dir_found = true;
            break;
        }
    if (!dir_found)
        strcpy(search_paths[n_paths++], fdir);

    FILE *fp = fopen(fname, "r");
    if (fp) return fp;

    for (int n = 0; n < n_paths; ++n) {
        char fullname[PATH_MAX];
        snprintf(fullname, PATH_MAX, "%s/%s", search_paths[n], fname);
        fp = fopen(fullname, "r");
        print(50, "batch file used: %s\n", fullname);
        if (fp) break;
    }

    return fp;
}

int batch(const char *fname) {
    FILE *fp = open_batch_file(fname);
    print(0, "batch: %s ???", fname);
    SAFE(fp ? OK : FAIL, CRIT);
    print(0, "batch: %s OK\n", fname);

    const size_t maxlen = 1024;
    char *opts[8*1024] = {0}, buf[maxlen + 1];
    char line[1024];
    int n_opts = 0;
    while (fgets(line, sizeof(line), fp)) {
        int offset = 0;
        const char *l = line;
        while (sscanf(l, "%s%n", buf, &offset) == 1) {
            if (buf[0] == '#')
                break; /* stop reading till eol */

#if defined(SXAURORA)
            const size_t len = strnlen_s(buf, maxlen) + 1;
#else
            const size_t len = strnlen(buf, maxlen) + 1;
#endif
            opts[n_opts] = (char *)malloc(len);
            SAFE(opts[n_opts] ? OK : FAIL, CRIT);
            strncpy(opts[n_opts], buf, len);
            ++n_opts;

            l += offset;
        }
    }
    bench(n_opts, opts, false);

    for (int n = 0; n < n_opts; ++n)
        free(opts[n]);

    fclose(fp);

    return OK;
}

}
// vim: et ts=4 sw=4 cindent cino^=l0,\:0,N-s
