/*******************************************************************************
* Copyright 2019-2020 Intel Corporation
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

/// @example hello.cpp
/// > Annotated version: @ref hello_example_cpp
///
/// @page hello_example_cpp_short
///
/// This C++ API example demonstrates how to construct and
/// tear down an engine, a part of
/// [Getting started](@ref getting_started_cpp)
///
/// @page hello_example_cpp Engine Example
/// @copydetails hello_example_cpp_short
///
/// @include hello.cpp
///

#include "dnnl.hpp"
#include "dnnl_debug.h"

#include "example_utils.hpp"

using namespace dnnl;
using namespace std;

void hello_example(engine::kind engine_kind) {

    // Create execution dnnl::engine.
    dnnl::engine engine(engine_kind, 0);

    // Create dnnl::stream.
    dnnl::stream engine_stream(engine);

    // Wait the stream to complete the execution
    //   ... of zero primitives
    engine_stream.wait();

    std::cout << "Hello, we waited for zero primitives to execute!"
              << std::endl;
}

int main(int argc, char **argv) {
    int exit_code = 0;

    engine::kind engine_kind = parse_engine_kind(argc, argv);
    try {
        hello_example(engine_kind);
    } catch (dnnl::error &e) {
        std::cout << "DNNL error caught: " << std::endl
                  << "\tStatus: " << dnnl_status2str(e.status) << std::endl
                  << "\tMessage: " << e.what() << std::endl;
        exit_code = 1;
    } catch (std::string &e) {
        std::cout << "Error in the example: " << e << "." << std::endl;
        exit_code = 2;
    }

    std::cout << "Example " << (exit_code ? "failed" : "passed") << " on "
              << engine_kind2str_upper(engine_kind) << "." << std::endl;
    return exit_code;
}

