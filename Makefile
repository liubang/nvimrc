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
