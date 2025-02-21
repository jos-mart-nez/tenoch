#!/bin/bash
function try {
  if ! "$@"
  then
    exit
  fi
}
