/*******************************************************************************
* Copyright 2017-2018 Intel Corporation
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

#include "mkldnn.h"

#include "mkldnn_common.hpp"
#include "mkldnn_memory.hpp"

#include "conv/conv.hpp"

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
const char *perf_template = "perf,%n,%d,%GO,%GF,%-t,%-Gp,%0t,%0Gp";

void reset_parameters() {
    cfg = conf_f32;
    pattern = NULL;
    dir = FWD_B;
    mb = 0;
    alg = DIRECT;
    merge = NONE;
    attr = attr_t();
    skip_impl = "";
    allow_unimpl = false;
}

void check_correctness(const desc_t *c) {
    const prb_t p(*c, dir, cfg, alg, merge, attr, mb);
    char pstr[max_prb_len];
    prb2str(&p, pstr);

    if (pattern && !match_regex(pstr, pattern))
        return;
    print(1, "run: %s\n", pstr);

    res_t res{};
    const int status = conv::doit(&p, &res);
    (void)status;

    bool want_perf_report = false;

    parse_result(res, want_perf_report, allow_unimpl, status, pstr);

    if (want_perf_report && bench_mode & PERF)
        perf_report(&p, &res, pstr);

    benchdnn_stat.tests++;
}

int bench(int argc, char **argv, bool main_bench) {
    for (int arg = 0; arg < argc; ++arg) {
        if (!strncmp("--batch=", argv[arg], 8))
            SAFE(batch(argv[arg] + 8, bench), CRIT);
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
            bool is_deconv = 0;
            if (str2desc(&c, argv[arg], is_deconv) == FAIL) {
                fprintf(stderr, "driver: unknown option: `%s`, exiting...\n",
                        argv[arg]);
                exit(2);
            }
            check_correctness(&c);
        }
    }

    if (main_bench && benchdnn_stat.tests == 0) {
        conv::desc_t default_list[] = {
    // Topology: alexnet
    { 1,  256,     3, 1,   227,   227,    96, 1,    55,    55, 1,   11,   11, 1,    4,    4, 0,    0,    0, 0,    0,    0,  "\"alexnet:conv1\"" },
    { 2,  256,    96, 1,    27,    27,   256, 1,    27,    27, 1,    5,    5, 1,    1,    1, 0,    2,    2, 0,    0,    0,  "\"alexnet:conv2\"" },
    { 1,  256,   256, 1,    13,    13,   384, 1,    13,    13, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"alexnet:conv3\"" },
    { 2,  256,   384, 1,    13,    13,   384, 1,    13,    13, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"alexnet:conv4\"" },
    { 2,  256,   384, 1,    13,    13,   256, 1,    13,    13, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"alexnet:conv5\"" },

    // Topology: vgg_19
    { 1,   64,     3, 1,   224,   224,    64, 1,   224,   224, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"vgg_19:conv1_1\"" },
    { 1,   64,    64, 1,   224,   224,    64, 1,   224,   224, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"vgg_19:conv1_2\"" },
    { 1,   64,    64, 1,   112,   112,   128, 1,   112,   112, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"vgg_19:conv2_1\"" },
    { 1,   64,   128, 1,   112,   112,   128, 1,   112,   112, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"vgg_19:conv2_2\"" },
    { 1,   64,   128, 1,    56,    56,   256, 1,    56,    56, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"vgg_19:conv3_1\"" },
    { 1,   64,   256, 1,    56,    56,   256, 1,    56,    56, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"vgg_19:conv3_2\"" },
    { 1,   64,   256, 1,    56,    56,   256, 1,    56,    56, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"vgg_19:conv3_3\"" },
    { 1,   64,   256, 1,    56,    56,   256, 1,    56,    56, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"vgg_19:conv3_4\"" },
    { 1,   64,   256, 1,    28,    28,   512, 1,    28,    28, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"vgg_19:conv4_1\"" },
    { 1,   64,   512, 1,    28,    28,   512, 1,    28,    28, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"vgg_19:conv4_2\"" },
    { 1,   64,   512, 1,    28,    28,   512, 1,    28,    28, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"vgg_19:conv4_3\"" },
    { 1,   64,   512, 1,    28,    28,   512, 1,    28,    28, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"vgg_19:conv4_4\"" },
    { 1,   64,   512, 1,    14,    14,   512, 1,    14,    14, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"vgg_19:conv5_1\"" },
    { 1,   64,   512, 1,    14,    14,   512, 1,    14,    14, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"vgg_19:conv5_2\"" },
    { 1,   64,   512, 1,    14,    14,   512, 1,    14,    14, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"vgg_19:conv5_3\"" },
    { 1,   64,   512, 1,    14,    14,   512, 1,    14,    14, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"vgg_19:conv5_4\"" },

    // Topology: resnet_50
    { 1,   50,     3, 1,   224,   224,    64, 1,   112,   112, 1,    7,    7, 1,    2,    2, 0,    3,    3, 0,    0,    0,  "\"resnet_50:conv1\"" },
    { 1,   50,    64, 1,    56,    56,   256, 1,    56,    56, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res2a_branch1\"" },
    { 1,   50,    64, 1,    56,    56,    64, 1,    56,    56, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res2a_branch2a\"" },
    { 1,   50,    64, 1,    56,    56,    64, 1,    56,    56, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"resnet_50:res2a_branch2b\"" },
    { 1,   50,    64, 1,    56,    56,   256, 1,    56,    56, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res2a_branch2c\"" },
    { 1,   50,   256, 1,    56,    56,    64, 1,    56,    56, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res2b_branch2a\"" },
    { 1,   50,    64, 1,    56,    56,    64, 1,    56,    56, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"resnet_50:res2b_branch2b\"" },
    { 1,   50,    64, 1,    56,    56,   256, 1,    56,    56, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res2b_branch2c\"" },
    { 1,   50,   256, 1,    56,    56,    64, 1,    56,    56, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res2c_branch2a\"" },
    { 1,   50,    64, 1,    56,    56,    64, 1,    56,    56, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"resnet_50:res2c_branch2b\"" },
    { 1,   50,    64, 1,    56,    56,   256, 1,    56,    56, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res2c_branch2c\"" },
    { 1,   50,   256, 1,    56,    56,   512, 1,    28,    28, 1,    1,    1, 1,    2,    2, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res3a_branch1\"" },
    { 1,   50,   256, 1,    56,    56,   128, 1,    28,    28, 1,    1,    1, 1,    2,    2, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res3a_branch2a\"" },
    { 1,   50,   128, 1,    28,    28,   128, 1,    28,    28, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"resnet_50:res3a_branch2b\"" },
    { 1,   50,   128, 1,    28,    28,   512, 1,    28,    28, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res3a_branch2c\"" },
    { 1,   50,   512, 1,    28,    28,   128, 1,    28,    28, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res3b_branch2a\"" },
    { 1,   50,   128, 1,    28,    28,   128, 1,    28,    28, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"resnet_50:res3b_branch2b\"" },
    { 1,   50,   128, 1,    28,    28,   512, 1,    28,    28, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res3b_branch2c\"" },
    { 1,   50,   512, 1,    28,    28,   128, 1,    28,    28, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res3c_branch2a\"" },
    { 1,   50,   128, 1,    28,    28,   128, 1,    28,    28, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"resnet_50:res3c_branch2b\"" },
    { 1,   50,   128, 1,    28,    28,   512, 1,    28,    28, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res3c_branch2c\"" },
    { 1,   50,   512, 1,    28,    28,   128, 1,    28,    28, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res3d_branch2a\"" },
    { 1,   50,   128, 1,    28,    28,   128, 1,    28,    28, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"resnet_50:res3d_branch2b\"" },
    { 1,   50,   128, 1,    28,    28,   512, 1,    28,    28, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res3d_branch2c\"" },
    { 1,   50,   512, 1,    28,    28,  1024, 1,    14,    14, 1,    1,    1, 1,    2,    2, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res4a_branch1\"" },
    { 1,   50,   512, 1,    28,    28,   256, 1,    14,    14, 1,    1,    1, 1,    2,    2, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res4a_branch2a\"" },
    { 1,   50,   256, 1,    14,    14,   256, 1,    14,    14, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"resnet_50:res4a_branch2b\"" },
    { 1,   50,   256, 1,    14,    14,  1024, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res4a_branch2c\"" },
    { 1,   50,  1024, 1,    14,    14,   256, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res4b_branch2a\"" },
    { 1,   50,   256, 1,    14,    14,   256, 1,    14,    14, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"resnet_50:res4b_branch2b\"" },
    { 1,   50,   256, 1,    14,    14,  1024, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res4b_branch2c\"" },
    { 1,   50,  1024, 1,    14,    14,   256, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res4c_branch2a\"" },
    { 1,   50,   256, 1,    14,    14,   256, 1,    14,    14, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"resnet_50:res4c_branch2b\"" },
    { 1,   50,   256, 1,    14,    14,  1024, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res4c_branch2c\"" },
    { 1,   50,  1024, 1,    14,    14,   256, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res4d_branch2a\"" },
    { 1,   50,   256, 1,    14,    14,   256, 1,    14,    14, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"resnet_50:res4d_branch2b\"" },
    { 1,   50,   256, 1,    14,    14,  1024, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res4d_branch2c\"" },
    { 1,   50,  1024, 1,    14,    14,   256, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res4e_branch2a\"" },
    { 1,   50,   256, 1,    14,    14,   256, 1,    14,    14, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"resnet_50:res4e_branch2b\"" },
    { 1,   50,   256, 1,    14,    14,  1024, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res4e_branch2c\"" },
    { 1,   50,  1024, 1,    14,    14,   256, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res4f_branch2a\"" },
    { 1,   50,   256, 1,    14,    14,   256, 1,    14,    14, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"resnet_50:res4f_branch2b\"" },
    { 1,   50,   256, 1,    14,    14,  1024, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res4f_branch2c\"" },
    { 1,   50,  1024, 1,    14,    14,  2048, 1,     7,     7, 1,    1,    1, 1,    2,    2, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res5a_branch1\"" },
    { 1,   50,  1024, 1,    14,    14,   512, 1,     7,     7, 1,    1,    1, 1,    2,    2, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res5a_branch2a\"" },
    { 1,   50,   512, 1,     7,     7,   512, 1,     7,     7, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"resnet_50:res5a_branch2b\"" },
    { 1,   50,   512, 1,     7,     7,  2048, 1,     7,     7, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res5a_branch2c\"" },
    { 1,   50,  2048, 1,     7,     7,   512, 1,     7,     7, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res5b_branch2a\"" },
    { 1,   50,   512, 1,     7,     7,   512, 1,     7,     7, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"resnet_50:res5b_branch2b\"" },
    { 1,   50,   512, 1,     7,     7,  2048, 1,     7,     7, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res5b_branch2c\"" },
    { 1,   50,  2048, 1,     7,     7,   512, 1,     7,     7, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res5c_branch2a\"" },
    { 1,   50,   512, 1,     7,     7,   512, 1,     7,     7, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"resnet_50:res5c_branch2b\"" },
    { 1,   50,   512, 1,     7,     7,  2048, 1,     7,     7, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"resnet_50:res5c_branch2c\"" },

    // Topology: googlenet_v1
    { 1,   96,     3, 1,   224,   224,    64, 1,   112,   112, 1,    7,    7, 1,    2,    2, 0,    3,    3, 0,    0,    0,  "\"googlenet_v1:conv1/7x7_s2\"" },
    { 1,   96,    64, 1,    56,    56,    64, 1,    56,    56, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:conv2/3x3_reduce\"" },
    { 1,   96,    64, 1,    56,    56,   192, 1,    56,    56, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v1:conv2/3x3\"" },
    { 1,   96,   192, 1,    28,    28,    64, 1,    28,    28, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_3a/1x1\"" },
    { 1,   96,   192, 1,    28,    28,    96, 1,    28,    28, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_3a/3x3_reduce\"" },
    { 1,   96,    96, 1,    28,    28,   128, 1,    28,    28, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v1:inception_3a/3x3\"" },
    { 1,   96,   192, 1,    28,    28,    16, 1,    28,    28, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_3a/5x5_reduce\"" },
    { 1,   96,    16, 1,    28,    28,    32, 1,    28,    28, 1,    5,    5, 1,    1,    1, 0,    2,    2, 0,    0,    0,  "\"googlenet_v1:inception_3a/5x5\"" },
    { 1,   96,   192, 1,    28,    28,    32, 1,    28,    28, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_3a/pool_proj\"" },
    { 1,   96,   256, 1,    28,    28,   128, 1,    28,    28, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_3b/1x1\"" },
    { 1,   96,   256, 1,    28,    28,   128, 1,    28,    28, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_3b/3x3_reduce\"" },
    { 1,   96,   128, 1,    28,    28,   192, 1,    28,    28, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v1:inception_3b/3x3\"" },
    { 1,   96,   256, 1,    28,    28,    32, 1,    28,    28, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_3b/5x5_reduce\"" },
    { 1,   96,    32, 1,    28,    28,    96, 1,    28,    28, 1,    5,    5, 1,    1,    1, 0,    2,    2, 0,    0,    0,  "\"googlenet_v1:inception_3b/5x5\"" },
    { 1,   96,   256, 1,    28,    28,    64, 1,    28,    28, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_3b/pool_proj\"" },
    { 1,   96,   480, 1,    14,    14,   192, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_4a/1x1\"" },
    { 1,   96,   480, 1,    14,    14,    96, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_4a/3x3_reduce\"" },
    { 1,   96,    96, 1,    14,    14,   208, 1,    14,    14, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v1:inception_4a/3x3\"" },
    { 1,   96,   480, 1,    14,    14,    16, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_4a/5x5_reduce\"" },
    { 1,   96,    16, 1,    14,    14,    48, 1,    14,    14, 1,    5,    5, 1,    1,    1, 0,    2,    2, 0,    0,    0,  "\"googlenet_v1:inception_4a/5x5\"" },
    { 1,   96,   480, 1,    14,    14,    64, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_4a/pool_proj\"" },
    { 1,   96,   512, 1,     4,     4,   128, 1,     4,     4, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:loss1/conv\"" },
    { 1,   96,   512, 1,    14,    14,   160, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_4b/1x1\"" },
    { 1,   96,   512, 1,    14,    14,   112, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_4b/3x3_reduce\"" },
    { 1,   96,   112, 1,    14,    14,   224, 1,    14,    14, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v1:inception_4b/3x3\"" },
    { 1,   96,   512, 1,    14,    14,    24, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_4b/5x5_reduce\"" },
    { 1,   96,    24, 1,    14,    14,    64, 1,    14,    14, 1,    5,    5, 1,    1,    1, 0,    2,    2, 0,    0,    0,  "\"googlenet_v1:inception_4b/5x5\"" },
    { 1,   96,   512, 1,    14,    14,    64, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_4b/pool_proj\"" },
    { 1,   96,   512, 1,    14,    14,   128, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_4c/1x1\"" },
    { 1,   96,   512, 1,    14,    14,   128, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_4c/3x3_reduce\"" },
    { 1,   96,   128, 1,    14,    14,   256, 1,    14,    14, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v1:inception_4c/3x3\"" },
    { 1,   96,   512, 1,    14,    14,    24, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_4c/5x5_reduce\"" },
    { 1,   96,    24, 1,    14,    14,    64, 1,    14,    14, 1,    5,    5, 1,    1,    1, 0,    2,    2, 0,    0,    0,  "\"googlenet_v1:inception_4c/5x5\"" },
    { 1,   96,   512, 1,    14,    14,    64, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_4c/pool_proj\"" },
    { 1,   96,   512, 1,    14,    14,   112, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_4d/1x1\"" },
    { 1,   96,   512, 1,    14,    14,   144, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_4d/3x3_reduce\"" },
    { 1,   96,   144, 1,    14,    14,   288, 1,    14,    14, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v1:inception_4d/3x3\"" },
    { 1,   96,   512, 1,    14,    14,    32, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_4d/5x5_reduce\"" },
    { 1,   96,    32, 1,    14,    14,    64, 1,    14,    14, 1,    5,    5, 1,    1,    1, 0,    2,    2, 0,    0,    0,  "\"googlenet_v1:inception_4d/5x5\"" },
    { 1,   96,   512, 1,    14,    14,    64, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_4d/pool_proj\"" },
    { 1,   96,   528, 1,     4,     4,   128, 1,     4,     4, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:loss2/conv\"" },
    { 1,   96,   528, 1,    14,    14,   256, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_4e/1x1\"" },
    { 1,   96,   528, 1,    14,    14,   160, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_4e/3x3_reduce\"" },
    { 1,   96,   160, 1,    14,    14,   320, 1,    14,    14, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v1:inception_4e/3x3\"" },
    { 1,   96,   528, 1,    14,    14,    32, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_4e/5x5_reduce\"" },
    { 1,   96,    32, 1,    14,    14,   128, 1,    14,    14, 1,    5,    5, 1,    1,    1, 0,    2,    2, 0,    0,    0,  "\"googlenet_v1:inception_4e/5x5\"" },
    { 1,   96,   528, 1,    14,    14,   128, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_4e/pool_proj\"" },
    { 1,   96,   832, 1,     7,     7,   256, 1,     7,     7, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_5a/1x1\"" },
    { 1,   96,   832, 1,     7,     7,   160, 1,     7,     7, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_5a/3x3_reduce\"" },
    { 1,   96,   160, 1,     7,     7,   320, 1,     7,     7, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v1:inception_5a/3x3\"" },
    { 1,   96,   832, 1,     7,     7,    32, 1,     7,     7, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_5a/5x5_reduce\"" },
    { 1,   96,    32, 1,     7,     7,   128, 1,     7,     7, 1,    5,    5, 1,    1,    1, 0,    2,    2, 0,    0,    0,  "\"googlenet_v1:inception_5a/5x5\"" },
    { 1,   96,   832, 1,     7,     7,   128, 1,     7,     7, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_5a/pool_proj\"" },
    { 1,   96,   832, 1,     7,     7,   384, 1,     7,     7, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_5b/1x1\"" },
    { 1,   96,   832, 1,     7,     7,   192, 1,     7,     7, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_5b/3x3_reduce\"" },
    { 1,   96,   192, 1,     7,     7,   384, 1,     7,     7, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v1:inception_5b/3x3\"" },
    { 1,   96,   832, 1,     7,     7,    48, 1,     7,     7, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_5b/5x5_reduce\"" },
    { 1,   96,    48, 1,     7,     7,   128, 1,     7,     7, 1,    5,    5, 1,    1,    1, 0,    2,    2, 0,    0,    0,  "\"googlenet_v1:inception_5b/5x5\"" },
    { 1,   96,   832, 1,     7,     7,   128, 1,     7,     7, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v1:inception_5b/pool_proj\"" },

    // Topology: googlenet_v2
    { 1,   96,     3, 1,   224,   224,    64, 1,   112,   112, 1,    7,    7, 1,    2,    2, 0,    3,    3, 0,    0,    0,  "\"googlenet_v2:conv1/7x7_s2\"" },
    { 1,   96,    64, 1,    56,    56,    64, 1,    56,    56, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:conv2/3x3_reduce\"" },
    { 1,   96,    64, 1,    56,    56,   192, 1,    56,    56, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v2:conv2/3x3\"" },
    { 1,   96,   192, 1,    28,    28,    64, 1,    28,    28, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_3a/1x1\"" },
    { 1,   96,   192, 1,    28,    28,    64, 1,    28,    28, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_3a/3x3_reduce\"" },
    { 1,   96,    64, 1,    28,    28,    64, 1,    28,    28, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v2:inception_3a/3x3\"" },
    { 1,   96,   192, 1,    28,    28,    64, 1,    28,    28, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_3a/double3x3_reduce\"" },
    { 1,   96,    64, 1,    28,    28,    96, 1,    28,    28, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v2:inception_3a/double3x3a\"" },
    { 1,   96,    96, 1,    28,    28,    96, 1,    28,    28, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v2:inception_3a/double3x3b\"" },
    { 1,   96,   192, 1,    28,    28,    32, 1,    28,    28, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_3a/pool_proj\"" },
    { 1,   96,   256, 1,    28,    28,    64, 1,    28,    28, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_3b/1x1\"" },
    { 1,   96,   256, 1,    28,    28,    64, 1,    28,    28, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_3b/3x3_reduce\"" },
    { 1,   96,    64, 1,    28,    28,    96, 1,    28,    28, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v2:inception_3b/3x3\"" },
    { 1,   96,   256, 1,    28,    28,    64, 1,    28,    28, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_3b/double3x3_reduce\"" },
    { 1,   96,    64, 1,    28,    28,    96, 1,    28,    28, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v2:inception_3b/double3x3a\"" },
    { 1,   96,    96, 1,    28,    28,    96, 1,    28,    28, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v2:inception_3b/double3x3b\"" },
    { 1,   96,   256, 1,    28,    28,    64, 1,    28,    28, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_3b/pool_proj\"" },
    { 1,   96,   320, 1,    28,    28,   128, 1,    28,    28, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_3c/3x3_reduce\"" },
    { 1,   96,   128, 1,    28,    28,   160, 1,    14,    14, 1,    3,    3, 1,    2,    2, 0,    1,    1, 0,    0,    0,  "\"googlenet_v2:inception_3c/3x3\"" },
    { 1,   96,   320, 1,    28,    28,    64, 1,    28,    28, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_3c/double3x3_reduce\"" },
    { 1,   96,    64, 1,    28,    28,    96, 1,    28,    28, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v2:inception_3c/double3x3a\"" },
    { 1,   96,    96, 1,    28,    28,    96, 1,    14,    14, 1,    3,    3, 1,    2,    2, 0,    1,    1, 0,    0,    0,  "\"googlenet_v2:inception_3c/double3x3b\"" },
    { 1,   96,   576, 1,     4,     4,   128, 1,     4,     4, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:loss1/conv\"" },
    { 1,   96,   576, 1,    14,    14,   224, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_4a/1x1\"" },
    { 1,   96,   576, 1,    14,    14,    64, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_4a/3x3_reduce\"" },
    { 1,   96,    64, 1,    14,    14,    96, 1,    14,    14, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v2:inception_4a/3x3\"" },
    { 1,   96,   576, 1,    14,    14,    96, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_4a/double3x3_reduce\"" },
    { 1,   96,    96, 1,    14,    14,   128, 1,    14,    14, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v2:inception_4a/double3x3a\"" },
    { 1,   96,   128, 1,    14,    14,   128, 1,    14,    14, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v2:inception_4a/double3x3b\"" },
    { 1,   96,   576, 1,    14,    14,   128, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_4a/pool_proj\"" },
    { 1,   96,   576, 1,    14,    14,   192, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_4b/1x1\"" },
    { 1,   96,   576, 1,    14,    14,    96, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_4b/3x3_reduce\"" },
    { 1,   96,    96, 1,    14,    14,   128, 1,    14,    14, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v2:inception_4b/3x3\"" },
    { 1,   96,   576, 1,    14,    14,    96, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_4b/double3x3_reduce\"" },
    { 1,   96,    96, 1,    14,    14,   128, 1,    14,    14, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v2:inception_4b/double3x3a\"" },
    { 1,   96,   128, 1,    14,    14,   128, 1,    14,    14, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v2:inception_4b/double3x3b\"" },
    { 1,   96,   576, 1,    14,    14,   128, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_4b/pool_proj\"" },
    { 1,   96,   576, 1,    14,    14,   160, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_4c/1x1\"" },
    { 1,   96,   576, 1,    14,    14,   128, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_4c/3x3_reduce\"" },
    { 1,   96,   128, 1,    14,    14,   160, 1,    14,    14, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v2:inception_4c/3x3\"" },
    { 1,   96,   576, 1,    14,    14,   128, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_4c/double3x3_reduce\"" },
    { 1,   96,   128, 1,    14,    14,   160, 1,    14,    14, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v2:inception_4c/double3x3a\"" },
    { 1,   96,   160, 1,    14,    14,   160, 1,    14,    14, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v2:inception_4c/double3x3b\"" },
    { 1,   96,   576, 1,    14,    14,    96, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_4c/pool_proj\"" },
    { 1,   96,   576, 1,    14,    14,    96, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_4d/1x1\"" },
    { 1,   96,   576, 1,    14,    14,   128, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_4d/3x3_reduce\"" },
    { 1,   96,   128, 1,    14,    14,   192, 1,    14,    14, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v2:inception_4d/3x3\"" },
    { 1,   96,   576, 1,    14,    14,   160, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_4d/double3x3_reduce\"" },
    { 1,   96,   160, 1,    14,    14,   192, 1,    14,    14, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v2:inception_4d/double3x3a\"" },
    { 1,   96,   192, 1,    14,    14,   192, 1,    14,    14, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v2:inception_4d/double3x3b\"" },
    { 1,   96,   576, 1,    14,    14,    96, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_4d/pool_proj\"" },
    { 1,   96,   576, 1,    14,    14,   128, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_4e/3x3_reduce\"" },
    { 1,   96,   128, 1,    14,    14,   192, 1,     7,     7, 1,    3,    3, 1,    2,    2, 0,    1,    1, 0,    0,    0,  "\"googlenet_v2:inception_4e/3x3\"" },
    { 1,   96,   576, 1,    14,    14,   192, 1,    14,    14, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_4e/double3x3_reduce\"" },
    { 1,   96,   192, 1,    14,    14,   256, 1,    14,    14, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v2:inception_4e/double3x3a\"" },
    { 1,   96,   256, 1,    14,    14,   256, 1,     7,     7, 1,    3,    3, 1,    2,    2, 0,    1,    1, 0,    0,    0,  "\"googlenet_v2:inception_4e/double3x3b\"" },
    { 1,   96,  1024, 1,     2,     2,   128, 1,     2,     2, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:loss2/conv\"" },
    { 1,   96,  1024, 1,     7,     7,   352, 1,     7,     7, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_5a/1x1\"" },
    { 1,   96,  1024, 1,     7,     7,   192, 1,     7,     7, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_5a/3x3_reduce\"" },
    { 1,   96,   192, 1,     7,     7,   320, 1,     7,     7, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v2:inception_5a/3x3\"" },
    { 1,   96,  1024, 1,     7,     7,   160, 1,     7,     7, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_5a/double3x3_reduce\"" },
    { 1,   96,   160, 1,     7,     7,   224, 1,     7,     7, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v2:inception_5a/double3x3a\"" },
    { 1,   96,   224, 1,     7,     7,   224, 1,     7,     7, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v2:inception_5a/double3x3b\"" },
    { 1,   96,  1024, 1,     7,     7,   128, 1,     7,     7, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_5a/pool_proj\"" },
    { 1,   96,  1024, 1,     7,     7,   352, 1,     7,     7, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_5b/1x1\"" },
    { 1,   96,  1024, 1,     7,     7,   192, 1,     7,     7, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_5b/3x3_reduce\"" },
    { 1,   96,   192, 1,     7,     7,   320, 1,     7,     7, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v2:inception_5b/3x3\"" },
    { 1,   96,  1024, 1,     7,     7,   192, 1,     7,     7, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_5b/double3x3_reduce\"" },
    { 1,   96,   192, 1,     7,     7,   224, 1,     7,     7, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v2:inception_5b/double3x3a\"" },
    { 1,   96,   224, 1,     7,     7,   224, 1,     7,     7, 1,    3,    3, 1,    1,    1, 0,    1,    1, 0,    0,    0,  "\"googlenet_v2:inception_5b/double3x3b\"" },
    { 1,   96,  1024, 1,     7,     7,   128, 1,     7,     7, 1,    1,    1, 1,    1,    1, 0,    0,    0, 0,    0,    0,  "\"googlenet_v2:inception_5b/pool_proj\"" },
};

        const int N = sizeof(default_list) / sizeof(default_list[0]);
        print(0,"/* using default list of %d problems */", N);
        for (int n = 0; n < N; ++n)
            check_correctness(&default_list[n]);
    }

    return OK;
}

}
