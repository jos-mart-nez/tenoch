#!/bin/bash
echo "=> Configure"
time cmake -S . -B out/$1 -DCMAKE_BUILD_TYPE=$1 -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -G Ninja
