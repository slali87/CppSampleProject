cmake_minimum_required(VERSION 3.28)

# Add -fno-exceptions otherwise there are a lot of branch detections because of Google test`s TEST macro.
SET( CMAKE_CXX_FLAGS_TESTCOV "-O0 -g --coverage -fno-exceptions"
        CACHE STRING "Flags used by the C++ compiler during coverage builds."
        FORCE )

MARK_AS_ADVANCED(
        CMAKE_CXX_FLAGS_TESTCOV)

# Update the documentation string of CMAKE_BUILD_TYPE for GUIs
SET( CMAKE_BUILD_TYPE "${CMAKE_BUILD_TYPE}" CACHE STRING
        "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel TestCov."
        FORCE )