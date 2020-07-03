#!/bin/sh
as template.s -o template.o
gcc -march=armv7-a template.o -L. -liolib -static -o template
