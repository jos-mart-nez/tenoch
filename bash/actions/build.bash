#!/bin/bash
source bash/modules/try.bash
try bash/actions/configure.bash $@
function build {
  echo "=> Build"
  source bash/parameters/all.bash
  source bash/globals/outDir.bash
  if ! cmake --build $OUT_DIR/$BUILD_TYPE --parallel $(nproc)
  then
    exit 1
  fi
}
time build $@
