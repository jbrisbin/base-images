# Base Docker images

This repository contains a reusable set of overlays to build base images with `docker.mk`. Each overlay is essentially a [Go template](https://golang.org/pkg/text/template/) that defines templates for each "family" of OS supported. e.g. for the [`java-8` overlay](common/java-8.Dockerfile) there are 3 templates defined for installing Java that can support 4 different operating systems: `alpine`, `centos`, `ubuntu`, and `debian`.

### Overlays

* [java-8](common/java-8.md) - Installs OpenJDK 8. Supports `apk`, `apt`, or `yum` install depending on the `OS` and `OS_FAMILY` currently set.

### Building images

Images that use these overlays are built from branches. Each branch corresponds to an image and contains the necessary `Makefile` and `.travis.yml` needed to build and publish the image.

### Testing images

Before an image is pushed to Docker Hub, make sure the `test` target is run and that tests for the image exist in a `test/my-image.mk` file and that targets are defined that are prefixed with `test-`. An example test can be found in the [test/java-8.mk](test/java-8.mk) file.

### Contributing

To contribute to this repository, create a PR that includes an overlay in [common](common/) or targets a branch named for the image to create. Create the overlay by naming it `something.Dockerfile`, where `something` will be the name used to include your overlays in the `OVERLAYS` of the `Makefile`. Also include a test in a `test/something.mk` file and name any targets you want run `test-something`. You can include more than one `test-` target--in fact include as many as you need to test that the overlay is installing what's expected and that it functions properly. A good way to verify this is to use the `--help` or `--version` of the utility you're installing and verify the output matches your expectations with a `bash` regex.
