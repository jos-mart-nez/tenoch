#!/bin/bash
if ! ./update.sh "$@"
then
  exit 1
fi
echo "=> Push"
time git push
