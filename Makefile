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

.SUFFIXES:

MAKEFILE_NAME := $(lastword $(MAKEFILE_LIST))
ROOT_DIR := $(dir $(abspath $(MAKEFILE_NAME)))

COMPILERS := GCC CLANG
BUILD_TYPES := DEBUG RELEASE
SANITIZERS := ASAN MSAN LSAN UBSAN FUZZ
CONFIGS := NORMAL $(SANITIZERS) COV NO_TESTS

DEFAULT_SUFFIX = clang-debug

# directory names
GCC_DIR := gcc/
CLANG_DIR := clang/
DEBUG_DIR := Debug/
RELEASE_DIR := Release/
NORMAL_DIR :=
ASAN_DIR := asan/
MSAN_DIR := msan/
LSAN_DIR := lsan/
UBSAN_DIR := ubsan/
FUZZ_DIR := fuzz/
COV_DIR := cov/
NO_TESTS_DIR := no-tests/

# make target prefixes
GCC_PREFIX := gcc
CLANG_PREFIX := clang
DEBUG_PREFIX := -debug
RELEASE_PREFIX := -release
NORMAL_PREFIX :=
ASAN_PREFIX := -asan
MSAN_PREFIX := -msan
LSAN_PREFIX := -lsan
UBSAN_PREFIX := -ubsan
FUZZ_PREFIX := -fuzz
COV_PREFIX := -cov
NO_TESTS_PREFIX := -no-tests

CMAKE_CMD ?= cmake

ifeq ($(USE_NINJA),1)
BUILD_CMD := ninja
BUILD_FILE := build.ninja
GENERATOR := Ninja
else
BUILD_CMD := +$(MAKE) --no-print-directory
BUILD_FILE := Makefile
GENERATOR := "Unix Makefiles"
endif

CMAKE_DIR = out/$($(1)_DIR)$($(2)_DIR)$($(3)_DIR)
BUILD_TARGET = $($(1)_PREFIX)$($(2)_PREFIX)$($(3)_PREFIX)
INSTALL_TARGET = install-$($(1)_PREFIX)$($(2)_PREFIX)$($(3)_PREFIX)
TEST_TARGET = test-$($(1)_PREFIX)$($(2)_PREFIX)$($(3)_PREFIX)

define CMAKE
$(call CMAKE_DIR,$(1),$(2),$(3)):
	mkdir -p $(call CMAKE_DIR,$(1),$(2),$(3))

$(call CMAKE_DIR,$(1),$(2),$(3))$$(BUILD_FILE): | $(call CMAKE_DIR,$(1),$(2),$(3))
	cd $(call CMAKE_DIR,$(1),$(2),$(3)) && \
	$$(CMAKE_CMD) -G $$(GENERATOR) $$(ROOT_DIR) $$($(1)_FLAG) $$($(2)_FLAG) $$($(3)_FLAG)
endef

define BUILD
.PHONY: $(call BUILD_TARGET,$(1),$(2),$(3))
$(call BUILD_TARGET,$(1),$(2),$(3)): $(call CMAKE_DIR,$(1),$(2),$(3))$$(BUILD_FILE)
	$$(BUILD_CMD) -C $(call CMAKE_DIR,$(1),$(2),$(3)) all
endef

.PHONY: all install test docs
all: $(DEFAULT_SUFFIX)
install: install-$(DEFAULT_SUFFIX)
test: test-$(DEFAULT_SUFFIX)

.PHONY: clean
clean:
	rm -rf out

all: clang-debug

build-clang:
	clang kyoto.cc -lstdc++

build-dev:
	clang -lstdc++ -g -O3 src/kyoto.cc $(llvm-config --cxxflags --ldflags --libs) -Iinclude

lint-fix:
	clang-format ./src/*.cc -i

docs:
	cd docs && make run

# running CMake
$(foreach CONFIG,$(CONFIGS), \
	$(foreach COMPILER,$(COMPILERS), \
		$(foreach BUILD_TYPE,$(BUILD_TYPES), \
			$(eval $(call CMAKE,$(COMPILER),$(BUILD_TYPE),$(CONFIG))))))

# building
$(foreach CONFIG,$(CONFIGS), \
	$(foreach COMPILER,$(COMPILERS), \
		$(foreach BUILD_TYPE,$(BUILD_TYPES), \
			$(eval $(call BUILD,$(COMPILER),$(BUILD_TYPE),$(CONFIG))))))