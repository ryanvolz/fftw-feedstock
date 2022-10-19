
mkdir build && cd build

set CMAKE_CONFIG="Release"

cmake -LAH -G"NMake Makefiles"                             ^
  -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%"                ^
  -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%"                   ^
  -DCMAKE_BUILD_TYPE="%CMAKE_CONFIG%"                      ^
  -DENABLE_THREADS=ON                                      ^
  -DWITH_COMBINED_THREADS=ON                               ^
  -DHAVE_SSE2=ON                                           ^
  -DENABLE_AVX=ON                                          ^
  -DLIBM_LIBRARY=LIBM-NOTFOUND                             ^
  ..
if errorlevel 1 exit 1

cmake --build . --config %CMAKE_CONFIG% --target install
if errorlevel 1 exit 1

ctest --output-on-failure --timeout 100
if errorlevel 1 exit 1

del CMakeCache.txt

cmake -LAH -G"NMake Makefiles"                             ^
  -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%"                ^
  -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%"                   ^
  -DCMAKE_BUILD_TYPE="%CMAKE_CONFIG%"                      ^
  -DENABLE_THREADS=ON                                      ^
  -DWITH_COMBINED_THREADS=ON                               ^
  -DHAVE_SSE2=ON                                           ^
  -DENABLE_AVX=ON                                          ^
  -DENABLE_FLOAT=ON                                        ^
  -DLIBM_LIBRARY=LIBM-NOTFOUND                             ^
  ..
if errorlevel 1 exit 1

cmake --build . --config %CMAKE_CONFIG% --target install
if errorlevel 1 exit 1

ctest --output-on-failure --timeout 100
if errorlevel 1 exit 1

