cmake_minimum_required(VERSION 3.28)

execute_process(COMMAND git format-patch -1 HEAD --output=${CMAKE_SOURCE_DIR}/build/patchFile.patch WORKING_DIRECTORY ${CMAKE_SOURCE_DIR} COMMAND_ERROR_IS_FATAL ANY)