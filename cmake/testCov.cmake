include(cmake/utility/common.cmake)
getVersion(version)
cmake_minimum_required(VERSION ${version})

execute_process(COMMAND cmake --preset=conan-testcov
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMAND_ERROR_IS_FATAL ANY)
execute_process(COMMAND cmake --build --preset=conan-testcov
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMAND_ERROR_IS_FATAL ANY)

execute_process(COMMAND lcov --capture --initial --rc branch_coverage=1 --directory . --output-file lcovResultBefore --ignore-errors mismatch
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/build/TestCov
    COMMAND_ERROR_IS_FATAL ANY)

getProjectName(projectName)
# Run the program because the main function of the App is not tested.
execute_process(COMMAND "./build/TestCov/src/app/${projectName}"
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMAND_ERROR_IS_FATAL ANY)
execute_process(COMMAND "./build/TestCov/test/${projectName}Test"
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMAND_ERROR_IS_FATAL ANY)

execute_process(COMMAND lcov --capture --rc branch_coverage=1 --directory . --output-file lcovResultAfter --ignore-errors mismatch
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/build/TestCov
    COMMAND_ERROR_IS_FATAL ANY)
execute_process(COMMAND lcov --rc branch_coverage=1 --add-tracefile lcovResultBefore --add-tracefile lcovResultAfter --output-file lcovResultCombined
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/build/TestCov
    COMMAND_ERROR_IS_FATAL ANY)

# _ZN11IHelloWorldD0Ev and _ZN11IHelloWorldD2Ev destructors are created by compiler, but the former (deleting destructor of a pure virtual class) is expectedly never called.	
deleteLinesFromFile(./build/TestCov/lcovResultCombined "_ZN3lib4ILibD0Ev")

execute_process(COMMAND lcov --remove --rc branch_coverage=1 lcovResultCombined "/usr/*" "gmock" "gtest" -o lcovResult
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/build/TestCov
    COMMAND_ERROR_IS_FATAL ANY)
execute_process(COMMAND genhtml lcovResult --rc branch_coverage=1 --output-directory CodeCoverage
    OUTPUT_FILE log
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/build/TestCov
    COMMAND_ERROR_IS_FATAL ANY)

searchInFile(./build/TestCov/log ".*lines.*: 100.0%.*" foundLine)
if ("${foundLine}" STREQUAL "")
    message(FATAL_ERROR "Coverage line issue")
endif()
searchInFile(./build/TestCov/log ".*functions.*: 100.0%.*" foundFile)
if ("${foundFile}" STREQUAL "")
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
searchInFile(./build/TestCov/logNoTest ".*branches.*: no data found.*" foundBranch)
if ("${foundBranch}" STREQUAL "")
    message(FATAL_ERROR "Coverage branch issue")
endif()