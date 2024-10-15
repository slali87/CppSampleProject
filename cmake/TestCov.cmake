cmake_minimum_required(VERSION 3.28)

execute_process(COMMAND cmake --preset=conan-testcov
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMAND_ERROR_IS_FATAL ANY)
execute_process(COMMAND cmake --build --preset=conan-testcov
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMAND_ERROR_IS_FATAL ANY)

execute_process(COMMAND lcov --capture --initial --rc branch_coverage=1 --directory . --output-file lcovResultBefore --ignore-errors mismatch
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/build/TestCov
    COMMAND_ERROR_IS_FATAL ANY)

get_filename_component(ProjectId ${CMAKE_CURRENT_SOURCE_DIR} NAME)
string(REPLACE " " "_" ProjectId ${ProjectId})
# Run the program because the main function of the App is not tested.
execute_process(COMMAND "./build/TestCov/src/app/${ProjectId}"
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMAND_ERROR_IS_FATAL ANY)
execute_process(COMMAND "./build/TestCov/test/${ProjectId}Test"
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMAND_ERROR_IS_FATAL ANY)

execute_process(COMMAND lcov --capture --rc branch_coverage=1 --directory . --output-file lcovResultAfter --ignore-errors mismatch
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/build/TestCov
    COMMAND_ERROR_IS_FATAL ANY)
execute_process(COMMAND lcov --rc branch_coverage=1 --add-tracefile lcovResultBefore --add-tracefile lcovResultAfter --output-file lcovResultCombined
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/build/TestCov
    COMMAND_ERROR_IS_FATAL ANY)

# Delete whole line matched with the PATTERN from the file named FILE_NAME
function(deleteinplace IN_FILE PATTERN)
  file (STRINGS ${IN_FILE} LINES)
  file(WRITE ${IN_FILE} "")
  foreach(LINE IN LISTS LINES)
    string(REGEX REPLACE ${PATTERN} "" STRIPPED "${LINE}")
    if("${STRIPPED}" STREQUAL "${LINE}")
        file(APPEND ${IN_FILE} "${STRIPPED}\n")
    endif()
  endforeach()
endfunction()

# _ZN11IHelloWorldD0Ev and _ZN11IHelloWorldD2Ev destructors are created by compiler, but the former (deleting destructor of a pure virtual class) is expectedly never called.	
deleteinplace(./build/TestCov/lcovResultCombined "_ZN3lib4ILibD0Ev")

execute_process(COMMAND lcov --remove --rc branch_coverage=1 lcovResultCombined "/usr/*" "gmock" "gtest" -o lcovResult
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/build/TestCov
    COMMAND_ERROR_IS_FATAL ANY)
execute_process(COMMAND genhtml lcovResult --rc branch_coverage=1 --output-directory CodeCoverage
    OUTPUT_FILE log
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/build/TestCov
    COMMAND_ERROR_IS_FATAL ANY)

# Search a PATTERN in every line of the file named FILE_NAME
function(search IN_FILE PATTERN FOUND)
  file (STRINGS ${IN_FILE} LINES)
  foreach(LINE IN LISTS LINES)
    string(REGEX MATCH ${PATTERN} STRIPPED "${LINE}")
    if(NOT "${STRIPPED}" STREQUAL "")
        set (${FOUND} "Found" PARENT_SCOPE)
        return()
    endif()
  endforeach()
endfunction()

search(./build/TestCov/log ".*lines.*: 100.0%.*" FOUNDL)
if ("${FOUNDL}" STREQUAL "")
    message(FATAL_ERROR "Coverage line issue")
endif()
search(./build/TestCov/log ".*functions.*: 100.0%.*" FOUNDF)
if ("${FOUNDF}" STREQUAL "")
    message(FATAL_ERROR "Coverage function issue")
endif()

# Remove the test files before check the branches because measuring of branches is not applicable for them.
execute_process(COMMAND lcov --remove --rc branch_coverage=1 lcovResult "*/test/*" -o lcovResultNoTest
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/build/TestCov
    COMMAND_ERROR_IS_FATAL ANY)
execute_process(COMMAND genhtml lcovResultNoTest --rc branch_coverage=1 --output-directory CodeCoverageNoTest
    OUTPUT_FILE logNoTest
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/build/TestCov
    COMMAND_ERROR_IS_FATAL ANY)

# Search for no data since currently there are no any branches in the code.
search(./build/TestCov/logNoTest ".*branches.*: no data found.*" FOUNDB)
if ("${FOUNDB}" STREQUAL "")
    message(FATAL_ERROR "Coverage branch issue")
endif()