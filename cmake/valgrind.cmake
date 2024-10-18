include(cmake/utility/common.cmake)
getVersion(version)
cmake_minimum_required(VERSION ${version})

getProjectName(projectName)

set (command valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --error-exitcode=1)
execute_process(COMMAND ${command} "${CMAKE_SOURCE_DIR}/build/Debug/src/app/${projectName}"
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMAND_ERROR_IS_FATAL ANY)
execute_process(COMMAND ${command} "${CMAKE_SOURCE_DIR}/build/Debug/test/${projectName}Test"
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMAND_ERROR_IS_FATAL ANY)