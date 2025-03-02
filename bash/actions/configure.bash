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
  if ! cmake -S . -B $OUT_DIR/$BUILD_TYPE -DCMAKE_BUILD_TYPE=$cmake_bt -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_CXX_COMPILER=clang++ -G Ninja
  then
    exit 1
  fi
  cp $OUT_DIR/$BUILD_TYPE/compile_commands.json $OUT_DIR/compile_commands.json
}
time configure $@
