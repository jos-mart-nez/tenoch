#/bin/bash
if ! ./configure.sh $1
then
	exit 1
fi
if ! ./build.sh $1
then
	exit 1
fi
./run.sh $1 $2

