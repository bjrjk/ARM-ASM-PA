#!/bin/sh
# Dynamic Link
gcc -march=armv7-a test.c -L. -liolib -o dynamic.test
# Static Link
gcc -march=armv7-a test.c -L. -liolib -static -o static.test
