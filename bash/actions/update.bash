#!/bin/bash
source bash/modules/try.bash
try bash/actions/format.bash
function commit {
  echo "=> Commit.sh"
  source bash/modules/error.bash
  try git add .
  message=$@
  if ! git commit -m "$message"
  then
    error "commit failed"
  fi
}
time commit $@
