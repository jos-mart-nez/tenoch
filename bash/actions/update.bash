#!/bin/bash
source bash/modules/try.bash
try bash/actions/format.bash
function commit {
  echo "=> Commit.sh"
  try git add .
  try git commit -m "update"
}
time commit "$@"
