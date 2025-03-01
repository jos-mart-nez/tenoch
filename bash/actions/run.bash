#!/bin/bash
function run {
  echo "=> Run"
  source bash/globals/outDir.bash
  source bash/globals/binDir.bash
  source bash/parameters/all.bash
  cd $OUT_DIR/$BUILD_TYPE/$BIN_DIR/$RUN_TARGET
  shift
  shift
  ./$RUN_TARGET $@
}
time run $@
