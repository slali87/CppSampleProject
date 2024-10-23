include(cmake/utility/common.cmake)
getVersion(version)
cmake_minimum_required(VERSION ${version})

# The limits and extensions should be re-investigated, the tool was sometimes stuck with t4
execute_process(COMMAND lizard 
    -Tnloc=200 -Tcyclomatic_complexity=10 -Ttoken_count=1000 -Tparameter_count=5 -Tlength=250 
    -t1 
    -scyclomatic_complexity 
    -Eboolcount -Edependencycount -Eduplicate -Eduplicated_param_list -Eexitcount -Egotocount -Eio -End -Ens -Estatementcount -Ewordcount 
    -x./build/*
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR} COMMAND_ERROR_IS_FATAL ANY)
 
file(RENAME codecloud.html ./build/codecloud.html)