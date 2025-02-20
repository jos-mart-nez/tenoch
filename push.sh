#!/bin/bash
./update.sh "$@"
echo "=> Push"
time git push
