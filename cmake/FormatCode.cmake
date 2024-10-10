cmake_minimum_required(VERSION 3.28)

# Check if there is any modified files
execute_process(COMMAND git diff --shortstat
    OUTPUT_VARIABLE numBefore
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMAND_ERROR_IS_FATAL ANY)

# Set list of source files and run the clang-format on them
set(EXPRESSION h hpp hh c cpp cc cxx)
list(TRANSFORM EXPRESSION PREPEND "${CMAKE_SOURCE_DIR}/*.")
file(GLOB_RECURSE SOURCE_FILES FOLLOW_SYMLINKS
    LIST_DIRECTORIES false ${EXPRESSION}
)
list(FILTER SOURCE_FILES EXCLUDE REGEX ".*/build/.*")
execute_process(COMMAND clang-format --version)
execute_process(COMMAND clang-format --Wno-error=unknown -style=file -i ${SOURCE_FILES}
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMAND_ERROR_IS_FATAL ANY)

# Check if there is any modified files
execute_process(COMMAND git diff --shortstat
    OUTPUT_VARIABLE numAfter
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMAND_ERROR_IS_FATAL ANY)

# Check if there is any modified file
if(NOT "${numBefore}" STREQUAL "${numAfter}")
    message( FATAL_ERROR "There is modified file. Check them!!!")
endif()


