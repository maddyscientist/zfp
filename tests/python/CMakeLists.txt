include_directories(${ZFP_SOURCE_DIR}/tests/utils)
include_directories(${ZFP_SOURCE_DIR})
add_cython_target(test_utils test_utils.pyx C)
add_library(test_utils MODULE ${test_utils})
target_link_libraries(test_utils zfp genSmoothRandNumsLib stridedOperationsLib zfpCompressionParamsLib zfpChecksumsLib zfpHashLib)
python_extension_module(test_utils)
set_target_properties(test_utils PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${PYLIB_BUILD_DIR})

add_test(NAME test_numpy
  COMMAND ${PYTHON_EXECUTABLE} test_numpy.py
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

set_tests_properties(test_numpy PROPERTIES
  ENVIRONMENT PYTHONPATH=${PYLIB_BUILD_DIR}:$ENV{PYTHONPATH})
