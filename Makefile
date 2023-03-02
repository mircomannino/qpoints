QEMU_DIR ?= ./qemu
CAPSTONE_DIR ?= ./capstone
GLIB_INC ?=`pkg-config --cflags glib-2.0`
CXXFLAGS ?= -g -Wall -std=c++14 -march=native $(GLIB_INC) \
	-iquote $(QEMU_DIR)/include/qemu/ \
	-iquote $(CAPSTONE_DIR)/include

all: libbbv.so libtracer.so

libbbv.so: bbv.cc
	$(CXX) $(CXXFLAGS) -shared -fPIC -o $@ $< -ldl -lrt -lz

libtracer.so: tracer.cc
	$(CXX) $(CXXFLAGS) -shared -fPIC -o $@ $< cs_disas.cc -ldl -lrt

clean:
	rm -f *.o libbbv.so libtracer.so
