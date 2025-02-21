#!/bin/bash
function style {
  echo "=> Style"
  source bash/modules/error.bash
  if [ -z "$1" ]
  then
    error "style argument needed"
  fi
  clang-format --style=$1 --dump-config > .clang-format
}
time style $@
