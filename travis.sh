#!/usr/bin/env sh
set -e

# pass additional args in $1 (starting with whitespace character)
run_all () {
  run_all_cmd="ctest -V -C Debug -DC_STANDARD=${C_STANDARD:-99} -DCXX_STANDARD=${CXX_STANDARD:-98} -S \"$TRAVIS_BUILD_DIR/cmake/travis.cmake\""
  eval "${run_all_cmd}$1"
}

mkdir build
cd build

if [ -n "${COVERAGE}" ]; then
  # build (linux)
  run_all " -DBUILD_CFP=ON -DBUILD_PYTHON=ON -DBUILD_ZFORP=ON -DZFP_WITH_ALIGNED_ALLOC=1 -DBUILD_OPENMP=ON -DBUILD_CUDA=OFF -DWITH_COVERAGE=ON"
else
  # build/test without OpenMP, with CFP (and custom namespace), with zfPy, with Fortran (linux only)
  if [[ "$OSTYPE" == "darwin"* ]]; then
    BUILD_ZFORP=OFF
  else
    BUILD_ZFORP=ON
  fi

  run_all " -DBUILD_PYTHON=ON -DBUILD_OPENMP=OFF -DBUILD_CUDA=OFF"
fi
