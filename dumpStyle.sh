#!/bin/bash
rm -f .clang-format
clang-format -style=Google -dump-config > .clang-format
