add_library (${CMAKE_PROJECT_NAME}Lib ../incl/Lib.h Lib.cpp ../incl/IHelloWorld.h ../incl/HelloWorld.h HelloWorld.cpp)
target_include_directories(${CMAKE_PROJECT_NAME}Lib PUBLIC ../incl)