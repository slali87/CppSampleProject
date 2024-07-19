
include_directories(../src)
include_directories(../../../Deps/googletest/googletest/include)
include_directories(../../../Deps/googletest/googlemock/include)

find_library(GTest gtest HINTS ${CMAKE_CURRENT_SOURCE_DIR}/../../../Deps/googletest/build/lib/)
find_library(GMock gmock HINTS ${CMAKE_CURRENT_SOURCE_DIR}/../../../Deps/googletest/build/lib/)
if(UNIX)
  set(PThreadLib -pthread)
else()
  set(StaticLink -static)
endif()

add_executable (${CMAKE_PROJECT_NAME}Test MockHelloWorld.h main.cpp LibTestCases.cpp AppTestCases.cpp)
target_link_libraries(${CMAKE_PROJECT_NAME}Test PRIVATE ${CMAKE_PROJECT_NAME}Lib ${CMAKE_PROJECT_NAME}InnerLib ${PThreadLib} ${StaticLink} ${GTest} ${GMock})

add_test(NAME ${CMAKE_PROJECT_NAME}Test COMMAND ${CMAKE_PROJECT_NAME}Test)
