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

build.mk:
<br>  TYPE      Type of project (lib, exe)
<br>  SOURCES   Names of cpp files; ex: str.cpp util.cpp
<br>  INCLUDES  Include directories with -I compiler option; ex: -I../include -I/usr/local/include
<br>  MKDIRS    Names of dirs to create; ex: ../lib
<br>  OUT       Name of the output file; ex: ../lib/libtest.a
<br>  DIRS      Names of directories with makefiles to build; ex: src test
<br>  EXTMAKES  Names of makefiles to build; ex: proja.mk projb.mk
<br>
<br>  CONFIG    Build config (debug, release)
<br>
<br>  make                -- builds (defaults to debug)
<br>  make CONFIG=release -- builds release
<br>  make -B             -- builds even if up to date
<br>  make cleanall       -- cleans
<br>  make clean          -- cleans current folder/makefile only
<br>  make xx._s          -- generates assembly/listing file for xx.cpp
<br>  make xx._p          -- generates preprocessed file for xx.cpp
