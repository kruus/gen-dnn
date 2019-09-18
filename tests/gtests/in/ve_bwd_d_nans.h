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

#if 0 // runs a long time on Aurora
INST_TEST_CASE(NCHW_Dilation_ve_nans,
    PARAMS(nchw, oihw, FMT_BIAS, nchw,
        2, 1, 3, 227, 227, 96, 111, 111, 5, 5, 1, 1, 2, 2, 1, 1)
);

#else
INST_TEST_CASE(NCHW_Dilation_ve_nans,
    PARAMS(nchw, oihw, FMT_BIAS, nchw,
        2, 1, 3, 127, 127, 96, 61, 61, 5, 5, 1, 1, 2, 2, 1, 1)
);
#endif
