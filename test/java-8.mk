TAG = java-8
FROM = $(OS_FAMILY):$(OS_VERSION)
OVERLAY_DIRS = ../common
OVERLAYS = java-8
CMD = java -version

.PHONY: test-java-install

test-java-install: install
	VERSION="$(shell docker run --rm -it $(TAG) 2>&1)"; \
	[[ "$$VERSION" =~ "openjdk version" ]]

-include ../docker.mk
