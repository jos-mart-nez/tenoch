#!/bin/bash
source bash/modules/try.bash
try bash/actions/configure.bash $@
function build {
  echo "=> Build"
  source bash/parameters/all.bash
  source bash/globals/outDir.bash
  cmake --build $OUT_DIR/$BUILD_TYPE
}
time build $@
