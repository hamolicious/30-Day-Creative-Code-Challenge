#!/usr/bin/env bash

nasm -f elf32 fizzbuzz.asm -o fizzbuzz.o && \
  ld -m elf_i386 fizzbuzz.o -o fizzbuzz
