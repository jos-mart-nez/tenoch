#!/bin/bash
if ./configure.sh $1
then
  echo "=> Build"
  time cmake --build out/$1
fi
