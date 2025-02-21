# cmake -DCMAKE_TOOLCHAIN_FILE=../mingw-w64.cmake -G "MinGW Makefiles" ..
# mingw-w64.cmake - Toolchain file for MinGW-w64 cross-compilation

# Target operating system
set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_SYSTEM_PROCESSOR x86_64) # Or i686 for 32-bit

# Specify the compilers
set(CMAKE_C_COMPILER   x86_64-w64-mingw32-gcc) # Or i686-w64-mingw32-gcc for 32-bit
# set(CMAKE_CXX_COMPILER x86_64-w64-mingw32-g++) # Or i686-w64-mingw32-g++ for 32-bit

# Set cross-compile flag (important for some CMake versions)
# set(CMAKE_CROSSCOMPILING 1)

# Optionally specify the target architecture flags (if needed)
# set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -m64") # Or -m32 for 32-bit
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -m64") # Or -m32 for 32-bit

# Specify where to find Windows libraries (if needed, adjust paths)
# set(CMAKE_FIND_ROOT_PATH  /usr/x86_64-w64-mingw32 /usr/i686-w64-mingw32 /usr/lib/mingw-w64)
# set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
# set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
