find_package(GTest REQUIRED)

add_library(${CMAKE_PROJECT_NAME}Mock INTERFACE)
target_include_directories(${CMAKE_PROJECT_NAME}Mock INTERFACE lib/mock)

add_executable (${CMAKE_PROJECT_NAME}Test app/appTest.cpp lib/libTest.cpp)
target_link_libraries (${CMAKE_PROJECT_NAME}Test PRIVATE ${CMAKE_PROJECT_NAME}Obj ${CMAKE_PROJECT_NAME}Lib ${CMAKE_PROJECT_NAME}Mock gtest::gtest)

include(GoogleTest)
gtest_discover_tests(${CMAKE_PROJECT_NAME}Test)

