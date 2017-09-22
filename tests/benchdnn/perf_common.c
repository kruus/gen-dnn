#include "perf_common.h"
#include <stdio.h>

bool test_attr__enabled = false;

static int _eprintf(int level, int var, const char *fmt, va_list args)
{
        int ret = 0;

        if (var >= level) {
                //if (use_browser >= 1 && !redirect_to_stderr)
                //        ui_helpline__vshow(fmt, args);
                //else
                        ret = vfprintf(stderr, fmt, args);
        }

        return ret;
}

int veprintf(int level, int var, const char *fmt, va_list args)
{
        return _eprintf(level, var, fmt, args);
}

int eprintf(int level, int var, const char *fmt, ...)
{
        va_list args;
        int ret;

        va_start(args, fmt);
        ret = _eprintf(level, var, fmt, args);
        va_end(args);

        return ret;
}


