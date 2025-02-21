#/bin/bash
source bash/modules/try.bash
try bash/actions/format.bash
try bash/actions/build.bash $@
if [ -n "$3" ]
then
  try bash/actions/run.bash $@  
fi
