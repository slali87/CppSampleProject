cmake_minimum_required(VERSION 3.28)

message("Run Doxygen")
# Workaround for the CMake-Doxygen-Windows path issue
if(${CMAKE_ARGC} EQUAL 4)
   set(Doxygen "${CMAKE_ARGV3}")
else()
   set(Doxygen "doxygen")
endif()
message("Doxygen: ${Doxygen}")
execute_process(COMMAND ${Doxygen} -v WORKING_DIRECTORY ${CMAKE_SOURCE_DIR} COMMAND_ERROR_IS_FATAL ANY)
execute_process(COMMAND ${Doxygen} ${CMAKE_SOURCE_DIR}/Doxyfile WORKING_DIRECTORY ${CMAKE_SOURCE_DIR} COMMAND_ERROR_IS_FATAL ANY)

# Delete PATTERN from the file named FILE_NAME
function(delete FILE_NAME PATTERN)
   file(READ ${FILE_NAME} FILE_CONTENTS)
   string(REGEX REPLACE "${PATTERN}" "" FILE_CONTENTS "${FILE_CONTENTS}")
   file(WRITE ${FILE_NAME} "${FILE_CONTENTS}")
endfunction()

# Remove unwanted 'strong' html tags from the results, Doxygen puts them for some reason...
message("Remove unwanted 'strong' html tags")
set(PATTERN "&lt;strong&gt;|&lt;/strong&gt;|<strong>|</strong>")
delete(./build/Doc/html/index.html "${PATTERN}")
if(EXISTS "./build/Doc/html/index.js")
   delete(./build/Doc/html/index.js "${PATTERN}")
endif()
delete(./build/Doc/html/navtreedata.js "${PATTERN}")