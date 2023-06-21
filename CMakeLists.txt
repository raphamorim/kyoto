#
# Copyright 2023 Raphael Amorim
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
#

cmake_minimum_required(VERSION 3.16)
project(KYOTO LANGUAGES C CXX VERSION 1.0.33)

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

find_package(LLVM 16.0 REQUIRED CONFIG)

set(KYOTO_LIBRARY_CC
  src/rio.cc
)

set(KYOTO_LIBRARY_H
  include/kyoto/JIT.h
)

set(KYOTO_LIBRARY_SRC ${KYOTO_LIBRARY_CC} ${KYOTO_LIBRARY_H})

include_directories(
  kyoto
  PUBLIC
  "$<BUILD_INTERFACE:${KYOTO_SOURCE_DIR}/include>"
  "$<BUILD_INTERFACE:${KYOTO_BINARY_DIR}/include>"
)

include_directories(${LLVM_INCLUDE_DIRS})
add_definitions(${LLVM_DEFINITIONS})

add_executable(simple-tool src/kyoto.cc)

llvm_map_components_to_libnames(llvm_libs support core irreader)

target_link_libraries(simple-tool LLVM)
