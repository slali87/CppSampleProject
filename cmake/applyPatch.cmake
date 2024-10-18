include(cmake/utility/common.cmake)
getVersion(version)
cmake_minimum_required(VERSION ${version})

execute_process(COMMAND git am
    INPUT_FILE ${CMAKE_SOURCE_DIR}/build/patchFile.patch
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMAND_ERROR_IS_FATAL ANY)