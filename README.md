# New README

## Install dependencies
qpoints requires source code of [QEMU]() and [Capstone Engine](). Run ```install_requirements.sh``` to download them in the current directory.
```bash
chmod u+x ./install_requirements.sh
./install_requirements.sh
```
In order to use the generated plugins, install ```qemu-user```: 
```bash
sudo apt install qemu-user
```


## Compiling
To generate ```libbv.so``` and ```libtracer.so``` run the following commands:
```bash 
export QEMU_DIR=/path/to/qemu # default: ./qemu
export CAPSTONE_DIR=/path/to/qemu # default: ./capstone
make
```

## Generate BBV
BBV file are generated using ```libbbv.so``` plugin. Run the following command to produce BBV file of an application called ```hello``` that takes one input argument:
```bash 
export OUT_DIR=./output
export OUT_NAME=hello
export SIMPOINT_INTERVAL=100000000 # 100M
qemu-riscv64 \
    -plugin ./libbv.so,out_dir=${OUT_DIR},out_name=${OUT_NAME},simpoint_interval=${SIMPOINT_INTERVAL} \
    ./hello \
    -append "input-args"
```
---
---

# Original README
# qpoints
Qemu tracing plugin using SimPoints

Compiling
---
Set QEMU_DIR to point to the qemu source folder before running make.

```
$ export QEMU_DIR=/path/to/qemu
$ make
```

Running
---

$ ./qemu-aarch64 -d plugin -plugin ../../qpoints/libbbv.so,arg=<bench_name> /path/to/benchmark/

You should see two files: <bench_name>_bbv.gz and <bench_name>_pc.txt

The bbv file is processed by the SimPoints binary to create the simpoints and
weights file.

$ ./SimPoint.3.2/bin/simpoint -inputVectorsGzipped -loadFVFile <bench_name>_bbv.gz -k 10 -saveSimpoints <bench_name>.simpts  -saveSimpointWeights <bench_name>.weights

The generated simpts and weights file are used by the tracer plugin to generate
traces.

Then you run tracer to generate the traces.

$ ./qemu-aarch64 -d plugin -plugin ../../qpoints/libtracer.so,arg=<bench_name> /path/to/benchmark/

Related
---

See http://web.eece.maine.edu/~vweaver/projects/qemusim/

