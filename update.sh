#!/bin/bash
./format.sh
echo "=> Add"
time git add .
echo "=> Commit"
time git commit -m "update"
