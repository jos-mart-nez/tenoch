#!/bin/bash
find $1/src -type f -exec command clang-format -i {} \;
find $1/inc -type f -exec command clang-format -i {} \;
