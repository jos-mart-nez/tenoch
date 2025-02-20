#!/bin/bash
function fmtc {
  if ! clang-format --Werror --dry-run $1 2> /dev/null
  then
    echo "  $1"
    clang-format -i $1
  fi
}
export -f fmtc
function fmtdir {
  find $1 -type f -exec bash -c 'fmtc "$0"' {} \;
}
function fmtproj {
  fmtdir $1/inc
  fmtdir $1/src
}
function fmtall {
  fmtproj gtg
}
echo "=> Format"
time fmtall
