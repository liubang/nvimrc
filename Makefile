HAVE_DOCKER := $(shell which docker 2>/dev/null)
HAVE_PODMAN := $(shell which podman 2>/dev/null)

build:
ifdef HAVE_DOCKER
	docker buildx build -t liubang/nvim -f Dockerfile .
else
ifdef HAVE_PODMAN
	podman build -t liubang/nvim -f Dockerfile .
else
	$(error "No docker or podman in $(PATH). Check if one was installed.")
endif
endif
