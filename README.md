buildmk
=======

Simple and easy makefile setup for C++.

I was looking for simple and flexible ways to build and maintain my C++ projects.  CMake and others are OK but
I didn't want to use new syntax and generated makefiles.  I also wanted to add new things easily and see how
everything is being built.

With build.mk, just create a very simple makefile in each project folder.  It has include the provided build.mk.
Then simply set some variables in your makefile.   A make file can either build a 'lib' or an 'exe'.  You just list
the source files you want to build  build.mk  takes care of dependencies even the header file dependencies--so when
you modify a source file, it only rebuilds what it has to (seems lot faster than CMake to me).

# build.mk:
#   TYPE      Type of project (lib, exe)
#   SOURCES   Names of cpp files; ex: str.cpp util.cpp
#   INCLUDES  Include directories with -I compiler option; ex: -I../include -I/usr/local/include
#   MKDIRS    Names of dirs to create; ex: ../lib
#   OUT       Name of the output file; ex: ../lib/libtest.a
#   DIRS      Names of directories with makefiles to build; ex: src test
#   EXTMAKES  Names of makefiles to build; ex: proja.mk projb.mk
#
#   CONFIG    Build config (debug, release)
#
#   make                -- builds (defaults to debug)
#   make CONFIG=release -- builds release
#   make -B             -- builds even if up to date
#   make cleanall       -- cleans
#   make clean          -- cleans current folder/makefile only
#   make xx._s          -- generates assembly/listing file for xx.cpp
#   make xx._p          -- generates preprocessed file for xx.cpp
