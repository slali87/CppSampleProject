include(cmake/utility/Common.cmake)
getVersion(version)
cmake_minimum_required(VERSION ${version})

execute_process(COMMAND cmake -P cmake/Setup.cmake
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMAND_ERROR_IS_FATAL ANY)
execute_process(COMMAND cmake -P cmake/Build.cmake
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMAND_ERROR_IS_FATAL ANY)
execute_process(COMMAND cmake -P cmake/Run.cmake
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMAND_ERROR_IS_FATAL ANY)
execute_process(COMMAND cmake -P cmake/Test.cmake
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMAND_ERROR_IS_FATAL ANY)
