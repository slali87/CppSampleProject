include(cmake/utility/common.cmake)
getVersion(version)
cmake_minimum_required(VERSION ${version})

execute_process(COMMAND cmake -P cmake/setup.cmake
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMAND_ERROR_IS_FATAL ANY)
execute_process(COMMAND cmake -P cmake/build.cmake
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMAND_ERROR_IS_FATAL ANY)
execute_process(COMMAND cmake -P cmake/run.cmake
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMAND_ERROR_IS_FATAL ANY)
execute_process(COMMAND cmake -P cmake/test.cmake
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMAND_ERROR_IS_FATAL ANY)
