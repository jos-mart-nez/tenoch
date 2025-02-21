#!/bin/bash
source bash/modules/try.bash
try ./update.sh "$@"
function push {
  echo "=> Push"
  git push
}
time push
