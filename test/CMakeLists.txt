include_directories(../incl)
include_directories(../src)
include_directories(../../../Deps/googletest/googletest/include)

add_executable (${CMAKE_PROJECT_NAME}Test main.cpp LibTestCases.cpp AppTestCases.cpp)
find_library(GTest gtest HINTS ${CMAKE_CURRENT_SOURCE_DIR}/../../../Deps/googletest/build/lib/)
if(UNIX)
  set(PThreadLib -pthread)
else()
  set(StaticLink -static)
endif()
target_link_libraries(${CMAKE_PROJECT_NAME}Test PUBLIC ${CMAKE_PROJECT_NAME}Lib ${CMAKE_PROJECT_NAME}InnerLib ${PThreadLib} ${StaticLink} ${GTest})

add_test(NAME ${CMAKE_PROJECT_NAME}Test COMMAND ${CMAKE_PROJECT_NAME}Test)
