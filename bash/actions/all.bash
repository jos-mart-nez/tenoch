#/bin/bash
source bash/modules/try.bash
try bash/actions/build.bash $@
if [ -n "$2" ]
then
  try bash/actions/run.bash $@  
fi
