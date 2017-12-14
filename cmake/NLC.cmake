#===============================================================================
# Copyright 2017 NEC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#===============================================================================
# Locate Aurora blas lib 
#===============================================================================

if(NLC_cmake_included)
    return()
endif()
set(NLC_cmake_included true)

#
# No detection right now, just specify the base path to the NLC.
# TODO: detect if lib available in canonical location and use
#       env var alternatively.
#
set(NLCINC $ENV{NLC_BASE}/include)
set(NLCLIB $ENV{NLC_BASE}/lib/libcblas.a)
set(NLCLIBBLAS $ENV{NLC_BASE}/lib/libblas_pthread.a)
#set(NLCLIBBLAS /opt/nec/ve/nlc/0.9.0/lib/libblas_sequential.a)
add_definitions(-DUSE_CBLAS)
include_directories(AFTER ${NLCINC})
list(APPEND mkldnn_LINKER_LIBS ${NLCLIB} ${NLCLIBBLAS})

