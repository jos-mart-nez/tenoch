#!/bin/bash
source bash/modules/try.bash
try bash/actions/update.bash $@
function push {
  echo "=> Push"
  git push
}
time push
