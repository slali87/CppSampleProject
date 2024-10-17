cmake_minimum_required(VERSION 3.28)

if(NOT EXISTS "./build/BuildType/")
    file(MAKE_DIRECTORY "./build/BuildType/")
endif()

if(EXISTS "./build/BuildType/Release")
    file(RENAME "./build/BuildType/Release" "./build/BuildType/Debug")
elseif(NOT EXISTS "./build/BuildType/Debug")
    file(TOUCH "./build/BuildType/Debug")
endif()