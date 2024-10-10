cmake_minimum_required(VERSION 3.28)

get_filename_component(ProjectId ${CMAKE_CURRENT_SOURCE_DIR} NAME)
string(REPLACE " " "_" ProjectId ${ProjectId})

execute_process(COMMAND valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --error-exitcode=1 "${CMAKE_SOURCE_DIR}/build/Debug/src/app/${ProjectId}"
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMAND_ERROR_IS_FATAL ANY)
execute_process(COMMAND valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --error-exitcode=1 "${CMAKE_SOURCE_DIR}/build/Debug/test/${ProjectId}Test"
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMAND_ERROR_IS_FATAL ANY)