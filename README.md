buildmk
=======

Simple and easy makefile setup for C++.

I was looking for simple and flexible ways to build and maintain my C++ projects.  CMake and others are OK but
I didn't want to use new syntax and generated makefiles.  I also wanted to add new things easily and see how
everything is being built.

With build.mk, just create a very simple makefile in each project folder.  It has include the provided build.mk.
In each makefile, you can either build the current folder or specify which folders to build (using DIRS).  Simply set
some variables in your makefile.  Besides sub-folders, a makefile can either build a 'lib' or an 'exe' (using TYPE).
You just list the source files (using SOURCES) you want to build. Then build.mk (you included) takes care of dependencies
even the header file dependencies--so when you modify a source file, it only rebuilds what it has to (seems lot faster
than CMake to me).

Sample 'makefile' for building multiple folders:
```
DIRS = src example
include build.mk
```
Sample 'makefile' for source files in a folder::
```
TYPE = exe
SOURCES = test.cpp
INCLUDES = -I. -I/usr/local/include -I../src
LIBS = ../libHelper.a
INSLIBS = -lpcre
OUT = test
include ../build.mk
```

build.mk directives and commands::
```
# build.mk:
#   CONFIG    Build config (debug, opttest, release)
#   TYPE      Type of project (lib, exe)
#   SOURCES   Names of cpp files; ex: str.cpp util.cpp
#   INCLUDES  Include directories with -I compiler option; ex: -I../include -I/usr/local/include
#   INSLIBS   Libs to be linked specified with compiler options -l or -L; ex: -lpthread -L/usr/lib/x86_64-linux-gnu
#   LIBS      Project libs to be linked--paths to .a files; ex: libRegExp.a ../lib/libtest.a
#   MKDIRS    Names of dirs to create; ex: ../lib
#   OUT       Name of the output file; ex: ../lib/libtest.a
#   DIRS      Names of directories with makefiles to build; ex: src test
#   EXTMAKES  Names of makefiles to build; ex: proja.mk projb.mk
#
#   $(PWD)    Current directory (ie with current makefile)
#
#   make          -- builds
#   make -B       -- builds even if up to date
#   make cleanall -- cleans all DIRS
#   make clean    -- cleans current folder/makefile only
#   make xx._s    -- generates assembly/listing file for xx.cpp
#   make xx._p    -- generates preprocessed file for xx.cpp
```