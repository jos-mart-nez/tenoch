#!/bin/bash
function do_action {
  action=$1
  function try {
    try=$1
    if [ "$action" == "$try" ]
    then
      shift
      if bash bash/actions/$action.bash $@
      then
        exit 0
      else
        exit 1
      fi
    fi
  }
  shift
  try "configure" $@
  try "build" $@
  try "run" $@
  try "all" $@
  try "clean" $@
  try "format" $@
  try "update" $@
  try "push" $@
  try "tree" $@
  try "style" $@
  source bash/modules/error.bash
  error "invalid action ($action)"
}
do_action $@
