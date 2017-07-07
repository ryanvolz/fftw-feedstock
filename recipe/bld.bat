
@rem See https://github.com/xantares/fftw-cmake/ 
cp "%RECIPE_DIR%\CMakeLists.txt" .
if errorlevel 1 exit 1
cp "%RECIPE_DIR%\config.h.in" .
if errorlevel 1 exit 1

mkdir build && cd build

set CMAKE_CONFIG="Release"

cmake -LAH -G"NMake Makefiles"                             ^
  -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%"                ^
  -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%"                   ^
  -DCMAKE_BUILD_TYPE="%CMAKE_CONFIG%"                      ^
  -DENABLE_THREADS=ON                                      ^
  -DWITH_COMBINED_THREADS=ON                               ^
  -DENABLE_FLOAT=ON                                        ^
  -DENABLE_LONG_DOUBLE=OFF                                 ^
  ..
if errorlevel 1 exit 1

cmake --build . --config %CMAKE_CONFIG% --target install
if errorlevel 1 exit 1

cmake --build . --config %CMAKE_CONFIG% --target tests 
if errorlevel 1 exit 1

ctest --output-on-failure --timeout 100
if errorlevel 1 exit 1

