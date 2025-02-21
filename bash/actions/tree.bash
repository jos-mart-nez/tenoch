#!/bin/bash
function print_tree {
  echo "=> Tree"
  source bash/globals/outDir.bash
  tree -I $OUT_DIR -I bash
}
time print_tree
