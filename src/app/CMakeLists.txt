add_library (${CMAKE_PROJECT_NAME}Obj OBJECT app.cpp)
target_link_libraries (${CMAKE_PROJECT_NAME}Obj PRIVATE ${CMAKE_PROJECT_NAME}Lib)
target_include_directories(${CMAKE_PROJECT_NAME}Obj PUBLIC include)

add_executable (${CMAKE_PROJECT_NAME} main.cpp)
target_link_libraries (${CMAKE_PROJECT_NAME} PRIVATE ${CMAKE_PROJECT_NAME}Obj ${CMAKE_PROJECT_NAME}Lib)