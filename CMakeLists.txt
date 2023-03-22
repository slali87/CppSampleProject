cmake_minimum_required(VERSION 3.10)
get_filename_component(ProjectId ${CMAKE_CURRENT_SOURCE_DIR} NAME)
string(REPLACE " " "_" ProjectId ${ProjectId})
project(${ProjectId} LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_FLAGS "-Wall -Wextra -Werror -pedantic -ansi")

option(CODE_COVERAGE "Enable coverage reporting" OFF)
if(CODE_COVERAGE)
    # Add -fno-exceptions otherwise there are a lot of branch detections because of Google test`s TEST macro.
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O0 -g --coverage -fno-exceptions")
endif()
message(STATUS "CMAKE_CXX_FLAGS: " ${CMAKE_CXX_FLAGS})

add_subdirectory(src_lib)
add_subdirectory(src)
enable_testing ()
add_subdirectory(test)
