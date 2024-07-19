add_library (${CMAKE_PROJECT_NAME}InnerLib App.h App.cpp)
target_link_libraries (${CMAKE_PROJECT_NAME}InnerLib PRIVATE ${CMAKE_PROJECT_NAME}Lib)
add_executable (${CMAKE_PROJECT_NAME} main.cpp)
target_link_libraries (${CMAKE_PROJECT_NAME} PRIVATE ${CMAKE_PROJECT_NAME}InnerLib)
