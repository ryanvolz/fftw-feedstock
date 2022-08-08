#!/usr/bin/env bas
cd ${RECIPE_DIR}/test_cmake
mkdir build
cmake -S . -B build
cmake --build build
cmake --install build
