#!/bin/bash
function configure {
  echo "=> Configure"
  source bash/globals/outDir.bash
  source bash/parameters/all.bash $@
  source bash/modules/error.bash
  if [ "$BUILD_TYPE" == "deb" ]
  then
    cmake_bt="Debug"
  elif [ "$BUILD_TYPE" == "rel" ]
  then
    cmake_bt="Release"
  elif [ "$BUILD_TYPE" == "reldeb" ]
  then
    cmake_bt="RelWithDebInfo"
  elif [ "$BUILD_TYPE" == "size" ]
  then
    cmake_bt="MinSizeRel"
  else
    error "invalid build type name ($BUILD_TYPE)"
  fi
  common="cmake -S . -B $OUT_DIR/$PLATFORM/$BUILD_TYPE -DCMAKE_BUILD_TYPE=$cmake_bt -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -G Ninja"
  if [ "$PLATFORM" == "linux" ]
  then
    $common
  elif [ "$PLATFORM" == "windows" ]
  then
    $common 
  else
    error "invalid platform name ($PLATFORM)"
  fi
}
time configure $@
