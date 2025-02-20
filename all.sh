#/bin/bash
./format.sh gtg
if ! ./build.sh $1
then
	exit 1
fi
if [ -n "$2" ]
then
  ./run.sh $1 $2
fi
