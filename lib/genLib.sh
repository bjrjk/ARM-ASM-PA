#!/bin/sh
# Generate Dynamic Library
gcc -march=armv7-a -fPIC -shared iolib.c -o libiolib.so
# Generate Static Library
gcc -march=armv7-a -fPIC -c iolib.c -o iolib.o
ar -r libiolib.a iolib.o
