#!/bin/bash
./format.sh
function commit {
  echo "=> Commit.sh"
  git add .
  git commit -m "update"
}
time commit
