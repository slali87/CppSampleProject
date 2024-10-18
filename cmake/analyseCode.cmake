include(cmake/utility/common.cmake)
getVersion(version)
cmake_minimum_required(VERSION ${version})

# Set list of source files and run the clang-tidy on them
getListOfSourceFiles(sourceFiles)
if(EXISTS "./build/BuildType/Release" AND EXISTS "./build/Release/compile_commands.json")
   set(CompileCommands "./build/Release/compile_commands.json")
elseif(EXISTS "./build/BuildType/Debug" AND EXISTS "./build/Debug/compile_commands.json")
    set(CompileCommands "./build/Debug/compile_commands.json")
else()
    message(FATAL_ERROR "The compile_commands.json has not been found")
endif()
execute_process(COMMAND clang-tidy --version)
execute_process(COMMAND clang-tidy ${sourceFiles} -p "${CompileCommands}"
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMAND_ERROR_IS_FATAL ANY)

   