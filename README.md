MinetestMapperGUI-Bundle
========================


[![GitHub All Releases](https://img.shields.io/github/downloads/adrido/MinetestMapperGui-Bundle/total.svg)](https://github.com/adrido/MinetestMapperGUI-Bundle/releases)
[![Build status](https://ci.appveyor.com/api/projects/status/c7ms6hu91mirhyn1?svg=true)](https://ci.appveyor.com/project/adrido/minetestmappergui-bundle)![GitHub](https://img.shields.io/github/license/adrido/MinetestMapperGui-Bundle.svg)


Contains the Minetestmapper and the MinetestmapperGui as bundle.

Download
--------
You can find the files on the [Releases](https://github.com/adrido/MinetestMapperGUI-Bundle/releases) page

Cloning this repository
-----------------------
As this repository contains submodule its not enough to just download the sourcecode. Instead use `git clone --recurse-submodules -j8 https://github.com/adrido/MinetestMapperGUI-Bundle`

Building on Windows
-------------------
Requirements:

- vcpkg https://github.com/Microsoft/vcpkg
- CMake https://cmake.org/
- Qt-Framework https://www.qt.io/
- WIX toolset (optional for creating installer)

Build steps:
just execute the build.ps1 script.

Building on Linux
-----------------
Im trying my best to support Linux too, but I does not have the experience to do so. Im happy about any help I can get here.

Try 
```
cmake .
make
```

Building on Mac
---------------
Im trying my best to support Mac too, but I does not have the experience to do so. Im happy about any help I can get here.
