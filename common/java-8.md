# java-8.Dockerfile

Install Java 8 on a variety of platforms.

### Usage

To use this overlay in an image, just add it to the `OVERLAYS`:

```makefile
TAG = myrepo/myimage
FROM = $(OS_FAMILY):$(OS_VERSION)
OVERLAYS = java-8
CMD = java -version

-include ./docker.mk
```

If the `java-8.Dockerfile` is in a directory called `common/` or just in `.`, then it will be found automatically by `docker.mk`'s overlay search algorithm. You can build the image with `make install`.

#### Installing for different OSes

This overlay respects the `OS_FAMILY` environment variable which is set by `docker.mk` based on the value of the `OS` environment variable. To build an image for a specific OS, set the variable `OS` to one of:

* `alpine-3.4`
* `debian-8`
* `centos-7`
* `ubuntu-14.04`
