cmake_minimum_required(VERSION 3.28)

if(NOT EXISTS "./build/BuildType/")
    file(MAKE_DIRECTORY "./build/BuildType/")
endif()

if(EXISTS "./build/BuildType/Debug")
    file(RENAME "./build/BuildType/Debug" "./build/BuildType/Release")
elseif(NOT EXISTS "./build/BuildType/Release")
    file(TOUCH "./build/BuildType/Release")
endif()