include(cmake/utility/Common.cmake)
getVersion(version)
cmake_minimum_required(VERSION ${version})

getProjectName(projectName)

if(EXISTS "./build/BuildType/Release")
    execute_process(COMMAND "./build/Release/test/${projectName}Test"
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        COMMAND_ERROR_IS_FATAL ANY)
elseif(EXISTS "./build/BuildType/Debug")
    execute_process(COMMAND "./build/Debug/test/${projectName}Test"
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        COMMAND_ERROR_IS_FATAL ANY)
else()
    message(FATAL_ERROR "BuildType has not been found")
endif()