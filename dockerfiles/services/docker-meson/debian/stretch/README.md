# docker-meson-cpp

![Travis CI status](https://travis-ci.org/bossjones/docker-meson.svg?branch=master)

## What is it ?

It is simple docker which enables you to compile **c++** code with **meson build**. It includes:
- [make](https://www.gnu.org/software/make/)
- [meson build](https://mesonbuild.com/index.html)
- [ninja-build](https://ninja-build.org/)
- [python3](https://www.python.org/)


Note: This docker only provide tools as they are, to check tool licenses go to their web page.

## Build commands

```bash
# Build meson project
meson <builddir> # Note in current working directory must be meson.build file
ninja -C <builddir>
```
For detailed documentation see [meson build docs](https://mesonbuild.com/index.html).
