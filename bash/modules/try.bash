#!/bin/bash
function try {
  if ! $@
  then
    exit 1
  fi
}
