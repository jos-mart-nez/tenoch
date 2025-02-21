#!/bin/bash
function clean {
  echo "=> Clean"
  source bash/globals/outDir.bash
  rm -rf $OUT_DIR
}
time clean
