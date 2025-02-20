#!/bin/bash
./format.sh
function commit {
  echo "=> Commit.sh"
  if ! git add .
  then 
    exit 1
  fi
  if ! git commit -m "$@"
  then
    exit 1
  fi
}
time commit "$@"
