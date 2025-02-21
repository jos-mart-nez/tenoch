#!/bin/bash
source bash/modules/try.bash
try bash/actions/format.bash
function commit {
  echo "=> Commit.sh"
  source bash/modules/error.bash
  try git add .
  if ! git commit -m "update"
  then
    error "commit failed"
  fi
}
time commit "$@"
