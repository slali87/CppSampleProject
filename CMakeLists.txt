include(cmake/utility/Common.cmake)

getVersion(version)
cmake_minimum_required(VERSION ${version})

getProjectName(projectName)
project(${projectName} LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_FLAGS "-Wall -Wextra -Werror -pedantic -ansi")
message(STATUS "CMAKE_CXX_FLAGS: " ${CMAKE_CXX_FLAGS})

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

include(cmake/utility/Config.cmake)

add_subdirectory(src)
include(CTest)
if(BUILD_TESTING)
    add_subdirectory(test)
endif()
