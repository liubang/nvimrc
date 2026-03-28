# Copyright (c) 2024 The Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Authors: liubang (it.liubang@gmail.com)

DEFAULT_GOAL := help

HAVE_DOCKER := $(shell command -v docker 2>/dev/null)
HAVE_PODMAN := $(shell command -v podman 2>/dev/null)
HAVE_DOCKER_BUILDX := $(shell docker buildx version >/dev/null 2>&1 && echo 1)

IMAGE_NAMESPACE ?= liubang
CONTEXT ?= .
PLATFORMS ?= linux/amd64,linux/arm64
LOCAL_PLATFORMS ?= linux/amd64
PROGRESS ?= auto
PUSH ?= 1
LOAD ?= 0
NO_CACHE ?= 1
NVIM_IMAGE ?= $(IMAGE_NAMESPACE)/nvim
NEOVIM_IMAGE ?= $(IMAGE_NAMESPACE)/neovim

ifeq ($(origin CONTAINER), undefined)
ifeq ($(HAVE_DOCKER),)
ifeq ($(HAVE_PODMAN),)
$(error No docker or podman in $(PATH). Check if one was installed.)
else
CONTAINER := podman
endif
else
CONTAINER := docker
endif
endif

ifeq ($(CONTAINER),docker)
ifeq ($(HAVE_DOCKER_BUILDX),)
$(error Docker buildx is required. Check if `docker buildx version` works.)
endif
BUILD_CMD := $(CONTAINER) buildx build
else ifeq ($(CONTAINER),podman)
BUILD_CMD := $(CONTAINER) build
else
$(error Unsupported CONTAINER '$(CONTAINER)'. Use docker or podman.)
endif

NO_CACHE_FLAG := $(if $(filter 1 true yes on,$(NO_CACHE)),--no-cache,)
PROGRESS_FLAG := $(if $(PROGRESS),--progress $(PROGRESS),)

ifeq ($(filter 1 true yes on,$(PUSH)),)
ifeq ($(CONTAINER),docker)
OUTPUT_FLAG := $(if $(filter 1 true yes on,$(LOAD)),--load,)
else
OUTPUT_FLAG :=
endif
else
OUTPUT_FLAG := --push
endif

ifneq ($(filter 1 true yes on,$(PUSH)),)
ifneq ($(filter 1 true yes on,$(LOAD)),)
$(error PUSH and LOAD cannot both be enabled at the same time.)
endif
endif

ifeq ($(CONTAINER),docker)
ifneq ($(filter 1 true yes on,$(LOAD)),)
ifneq ($(words $(subst ,, ,$(PLATFORMS))),1)
$(error LOAD with docker buildx requires a single platform. Use LOCAL_PLATFORMS or set PLATFORMS to one value.)
endif
endif
endif

.PHONY: help check build build-local neovim neovim-local print-%

define build_image
	$(BUILD_CMD) $(NO_CACHE_FLAG) $(OUTPUT_FLAG) $(PROGRESS_FLAG) --platform $(4) -t $(1) -f $(2) $(strip $(3)) $(CONTEXT)
endef

help: ## Show available targets and overridable variables
	@printf "Targets:\n"
	@awk 'BEGIN {FS = ":.*## "}; /^[a-zA-Z0-9_.%-]+:.*## / {printf "  %-12s %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@printf "\nVariables:\n"
	@printf "  CONTAINER=%s\n" "$(CONTAINER)"
	@printf "  CONTEXT=%s\n" "$(CONTEXT)"
	@printf "  PLATFORMS=%s\n" "$(PLATFORMS)"
	@printf "  LOCAL_PLATFORMS=%s\n" "$(LOCAL_PLATFORMS)"
	@printf "  PUSH=%s\n" "$(PUSH)"
	@printf "  LOAD=%s\n" "$(LOAD)"
	@printf "  NO_CACHE=%s\n" "$(NO_CACHE)"
	@printf "  PROGRESS=%s\n" "$(PROGRESS)"
	@printf "  NVIM_IMAGE=%s\n" "$(NVIM_IMAGE)"
	@printf "  NEOVIM_IMAGE=%s\n" "$(NEOVIM_IMAGE)"

check: ## Validate the selected container toolchain and key variables
	@printf "Using container engine: %s\n" "$(CONTAINER)"
	@printf "Build command: %s\n" "$(BUILD_CMD)"
	@printf "Output mode: %s\n" "$(if $(OUTPUT_FLAG),$(OUTPUT_FLAG),local cache only)"
	@printf "Platforms: %s\n" "$(PLATFORMS)"
	@printf "Runtime image: %s\n" "$(NVIM_IMAGE)"
	@printf "Base image: %s\n" "$(NEOVIM_IMAGE)"
	@if [ "$(CONTAINER)" = "docker" ]; then docker buildx version >/dev/null; fi

build: ## Build the runtime image using the configured output mode
	$(call build_image,$(NVIM_IMAGE),docker/Dockerfile,,$(PLATFORMS))

build-local: ## Build the runtime image for local use without pushing
	$(MAKE) build PUSH=0 LOAD=1 PLATFORMS="$(LOCAL_PLATFORMS)"

neovim: ## Build and push the base Neovim image (requires NVIM_TAG)
ifndef NVIM_TAG
	$(error NVIM_TAG is required, e.g. make neovim NVIM_TAG=0.11.6)
endif
	$(call build_image,$(NEOVIM_IMAGE),docker/build_neovim.Dockerfile,--build-arg NVIM_TAG=$(NVIM_TAG),$(PLATFORMS))

neovim-local: ## Build the base Neovim image locally without pushing
	$(MAKE) neovim PUSH=0 LOAD=1 PLATFORMS="$(LOCAL_PLATFORMS)" NVIM_TAG="$(NVIM_TAG)"

print-%: ## Print a Make variable, e.g. make print-PLATFORMS
	@printf "%s\n" "$($*)"
