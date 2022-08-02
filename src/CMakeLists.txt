include_directories(../incl)

add_library (${CMAKE_PROJECT_NAME}InnerLib App.h App.cpp)
add_executable (${CMAKE_PROJECT_NAME} main.cpp)
target_link_libraries (${CMAKE_PROJECT_NAME} ${CMAKE_PROJECT_NAME}InnerLib ${CMAKE_PROJECT_NAME}Lib)
