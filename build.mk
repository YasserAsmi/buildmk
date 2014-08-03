# Copyright (c) 2014 Yasser Asmi
# Released under the MIT License (http://opensource.org/licenses/MIT)
#
# build.mk:
# 	TYPE      Type of project (lib, exe)
# 	SOURCES   Names of cpp files; ex: str.cpp util.cpp
# 	INCLUDES  Include directories with -I compiler option; ex: -I../include -I/usr/local/include
# 	MKDIRS    Names of dirs to create; ex: ../lib
# 	OUT       Name of the output file; ex: ../lib/libtest.a
#	DIRS      Names of directories with makefiles to build; ex: src test
#   EXTMAKES  Names of makefiles to build; ex: proja.mk projb.mk
#
# 	CONFIG    Build config (debug, release)
#
#   make          	    -- builds (defaults to debug)
#   make CONFIG=release -- builds release
#   make -B       		-- builds even if up to date
#   make cleanall 		-- cleans
#   make clean    		-- cleans current folder/makefile only
#   make xx._s    		-- generates assembly/listing file for xx.cpp
#   make xx._p    		-- generates preprocessed file for xx.cpp

CONFIG ?= debug
TYPE ?= exe
INCLUDES ?= -I/usr/local/include

OBJS = $(SOURCES:.cpp=.o)

ifeq ($(CONFIG)	,debug)
CXXFLAGS += -g -Wall
else
CXXFLAGS += -O3 -Wall -DNDEBUG
endif

all: dirs extmakes cfgcheck mkdirs $(OUT)

.PHONY: clean cleanall all $(DIRS) $(MKDIRS) $(EXTMAKES)

cfgcheck:
ifneq ($(CONFIG)	,release)
ifneq ($(CONFIG)	,debug)
	@echo "Error: Invalid CONFIG 	'$(CONFIG)	'' (options: debug,release)"
	@exit 1
endif
endif
	@echo "Making '$(CURDIR)' CONFIG="$(CONFIG)

$(OUT): $(OBJS)
ifeq ($(TYPE),lib)
	$(AR) rcs $(OUT) $(OBJS)
endif
ifeq ($(TYPE),exe)
	$(CXX) -o $@ $^ ${LDFLAGS} $(LIBS)
endif

-include $(OBJS:.o=._d)

%.o: %.cpp
	$(CXX) -c $(INCLUDES) $(CXXFLAGS) $*.cpp -o $*.o
	$(CXX) -MM $(INCLUDES) $(CXXFLAGS) $*.cpp > $*._d
	@cp -f $*._d $*._d.tmp
	@sed -e 's/.*://' -e 's/\\$$//' < $*._d.tmp | fmt -1 | sed -e 's/^ *//' -e 's/$$/:/' >> $*._d
	@rm -f $*._d.tmp

%._e: %.cpp
	$(CXX) -E $(INCLUDES) $(CXXFLAGS) $*.cpp -o $*._e

%._s: %.cpp
	$(CXX) -c -Wa,-adhln -g $(INCLUDES) $(CXXFLAGS) $*.cpp > $*._s

dirs: $(DIRS)

extmakes: $(EXTMAKES)

mkdirs: $(MKDIRS)

clean:
	rm -f $(OUT) *.o *._d *._e *._s

cleanall: TARG:=cleanall
cleanall: $(DIRS) $(EXTMAKES)
	rm -f $(OUT) *.o *._d *._e *._s

$(DIRS):
	@$(MAKE) -C $@ $(TARG)

$(EXTMAKES):
	@$(MAKE) -f $@ $(TARG)

$(MKDIRS):
	@mkdir -p $@