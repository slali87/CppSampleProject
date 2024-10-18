include(cmake/utility/Common.cmake)
getVersion(version)
cmake_minimum_required(VERSION ${version})

# Check if there is any modified files
execute_process(COMMAND git diff --shortstat
    OUTPUT_VARIABLE statBefore
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMAND_ERROR_IS_FATAL ANY)

# Set list of source files and run the clang-format on them
getListOfSourceFiles(sourceFiles)
execute_process(COMMAND clang-format --version)
execute_process(COMMAND clang-format -style=file -i ${sourceFiles}
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMAND_ERROR_IS_FATAL ANY)

# Check if there is any modified files
execute_process(COMMAND git diff --shortstat
    OUTPUT_VARIABLE statAfter
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMAND_ERROR_IS_FATAL ANY)

# Check if there is any modified file
if(NOT "${statBefore}" STREQUAL "${statAfter}")
    message( FATAL_ERROR "There is modified file. Check them!!!")
endif()


