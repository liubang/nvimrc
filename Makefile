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

HAVE_DOCKER := $(shell which docker 2>/dev/null)
HAVE_PODMAN := $(shell which podman 2>/dev/null)

build:
	ifdef HAVE_DOCKER
		docker buildx build --no-cache --platform linux/amd64,linux/arm64 -t liubang/nvim -f docker/Dockerfile --push .
	else
	ifdef HAVE_PODMAN
		podman build --no-cache --platform linux/amd64,linux/arm64 -t liubang/nvim -f docker/Dockerfile --push .
	else
		$(error "No docker or podman in $(PATH). Check if one was installed.")
	endif
	endif

neovim:
	ifdef HAVE_DOCKER
		docker buildx build --no-cache --platform linux/amd64,linux/arm64 -t liubang/neovim -f docker/build_neovim.Dockerfile --push .
	else
	ifdef HAVE_PODMAN
		podman build --no-cache --platform linux/amd64,linux/arm64 -t liubang/neovim -f docker/build_neovim.Dockerfile --push .
	else
		$(error "No docker or podman in $(PATH). Check if one was installed.")
	endif
	endif
