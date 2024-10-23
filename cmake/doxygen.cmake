include(cmake/utility/common.cmake)
getVersion(version)
cmake_minimum_required(VERSION ${version})

message("Run Doxygen")

# Workaround for the CMake-Doxygen-Windows path issue
if(${CMAKE_ARGC} EQUAL 4)
   set(doxygen "${CMAKE_ARGV3}")
else()
   set(doxygen "doxygen")
endif()
message("Doxygen: ${doxygen}")
execute_process(COMMAND ${doxygen} ${CMAKE_SOURCE_DIR}/Doxyfile
   WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
   COMMAND_ERROR_IS_FATAL ANY)

# Remove unwanted 'strong' html tags from the results, Doxygen puts them for some reason...
message("Remove unwanted 'strong' html tags")
set(pattern "&lt;strong&gt;|&lt;/strong&gt;|<strong>|</strong>")
deleteFromFile(./build/Doc/html/index.html "${pattern}")
if(EXISTS "./build/Doc/html/index.js")
   deleteFromFile(./build/Doc/html/index.js "${pattern}")
endif()
deleteFromFile(./build/Doc/html/navtreedata.js "${pattern}")