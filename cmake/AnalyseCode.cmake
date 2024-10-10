cmake_minimum_required(VERSION 3.28)

# Set list of source files and run the clang-tidy on them
set(EXPRESSION h hpp hh c cpp cc cxx)
list(TRANSFORM EXPRESSION PREPEND "${CMAKE_SOURCE_DIR}/*.")
file(GLOB_RECURSE SOURCE_FILES FOLLOW_SYMLINKS
    LIST_DIRECTORIES false ${EXPRESSION}
)
list(FILTER SOURCE_FILES EXCLUDE REGEX ".*/build/.*")
if(EXISTS "./build/Release/compile_commands.json")
   set(CompileCommands "./build/Release/compile_commands.json")
elseif(EXISTS "./build/Debug/compile_commands.json")
    set(CompileCommands "./build/Debug/compile_commands.json")
else()
    message(FATAL_ERROR "The compile_commands.json has not been found")
endif()
execute_process(COMMAND clang-tidy --version)
execute_process(COMMAND clang-tidy ${SOURCE_FILES} -p "${CompileCommands}"
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMAND_ERROR_IS_FATAL ANY)

   