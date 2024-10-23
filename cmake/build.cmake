include(cmake/utility/common.cmake)
getVersion(version)
cmake_minimum_required(VERSION ${version})

if(EXISTS "./build/BuildType/Release")
    execute_process(COMMAND cmake --preset=conan-release
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        COMMAND_ERROR_IS_FATAL ANY)
    execute_process(COMMAND cmake --build --preset=conan-release
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        COMMAND_ERROR_IS_FATAL ANY)
elseif(EXISTS "./build/BuildType/Debug")
    execute_process(COMMAND cmake --preset=conan-debug
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        COMMAND_ERROR_IS_FATAL ANY)
    execute_process(COMMAND cmake --build --preset=conan-debug
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        COMMAND_ERROR_IS_FATAL ANY)
else()
    message(FATAL_ERROR "BuildType has not been found")
endif()