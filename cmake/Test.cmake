cmake_minimum_required(VERSION 3.28)

get_filename_component(ProjectId ${CMAKE_CURRENT_SOURCE_DIR} NAME)
string(REPLACE " " "_" ProjectId ${ProjectId})

if(EXISTS "./build/BuildType/Release")
    execute_process(COMMAND "./build/Release/test/${ProjectId}Test"
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        COMMAND_ERROR_IS_FATAL ANY)
elseif(EXISTS "./build/BuildType/Debug")
    execute_process(COMMAND "./build/Debug/test/${ProjectId}Test"
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        COMMAND_ERROR_IS_FATAL ANY)
else()
    message(FATAL_ERROR "BuildType has not been found")
endif()