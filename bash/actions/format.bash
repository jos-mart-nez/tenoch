#!/bin/bash
function format {
  echo "=> Format"
  function fmt_file {
    if ! clang-format --Werror --dry-run $1 2> /dev/null
    then
      echo "  $1"
      clang-format -i $1
    fi
  }
  export -f fmt_file
  function fmt_dir {
    find $1 -type f -exec bash -c 'fmt_file "$0"' {} \;
  }
  function fmt_proj {
    fmt_dir $1/glsl
    fmt_dir $1/inc
    fmt_dir $1/src
  }
  function fmt_all {
    fmt_proj gtg
  }
  fmt_all
}
time format
