#!/usr/bin/env bash

gdb -tui -ex "layout asm" -ex "layout regs" -ex "break loop" -ex "run" ./fizzbuzz

