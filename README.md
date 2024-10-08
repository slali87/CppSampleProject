# **CppSampleProject**

## Welcome to **CppSampleProject**, the C++ sample project!

This is a cross-platform **C++** sample project which presents a base project structure which is ideal to develop many projects in parallel. The dependencies are organized into one common place by Conan in order to avoid its unnecessary downloading and building. It contains templates to create libraries and applications (executable programs) as well. It uses [**CMake**](https://cmake.org/), [**Git**](https://git-scm.com/), [**GitHub**](https://github.com/), [**Conan**](https://conan.io/), [**Google Test**](https://github.com/google/googletest), [**Google Mock**](https://github.com/google/googletest/tree/main/googlemock), [**Markdown**](https://www.markdownguide.org/), **Bash** script, [**Valgrind**](https://valgrind.org/), [**LCOV Code Coverage**](https://wiki.documentfoundation.org/Development/Lcov), [**Clang-Tidy**](https://clang.llvm.org/extra/clang-tidy/), [**ClangFormat**](https://clang.llvm.org/docs/ClangFormat.html), [**Doxygen**](https://www.doxygen.nl/), [**Graphviz**](https://graphviz.org/), [**Lizard**](https://github.com/terryyin/lizard).

### **Structure of the project (only the major files are listed):**
```
.
└── CppSampleProject
    ├── build
    │   ├── Debug
    │   └── Release
    ├── cmake
    ├── src
    │   ├── CMakeLists.txt
    │   ├── app
    │   │   ├── CMakeLists.txt
    │   │   ├── app.cpp
    │   │   ├── include
    │   │   │   └── app.hpp
    │   │   └── main.cpp
    │   └── lib
    │       ├── CMakeLists.txt
    │       ├── include
    │       │   └── lib
    │       │       ├── iLib.hpp
    │       │       └── lib.hpp
    │       └── lib.cpp
    ├── test
    │   ├── CMakeLists.txt
    │   ├── app
    │   │   └── appTest.cpp
    │   └── lib
    │       ├── libTest.cpp
    │       └── mock
    │           └── lib
    │               └── libMock.hpp
    ├── tools
    └── CMakeLists.txt
```
- **CppSampleProject**  
    This is the root folder of this **Git** repository.  
    It can be renamed without code modification.

- **build `*`**  
    It is a folder to store the generated files (builds, reports, documents...).

- **cmake**  
    It is a folder to store the CMake script files.

- **src**  
    It is a folder to store the source files of the application and the library.

- **test**  
    It is a folder to store the test related source files.

- **tools**  
    It is a folder to store the tools and scripts.

`*` ***Please note*** that the folders - marked with `*` - are not part of this **Git** repository!  
The **build** will be created implicitly in part [*Steps to resolve the dependencies and set up the project:*](#steps-to-resolve-the-dependencies-and-set-up-the-project).

### **Operating Systems:**
The project has been tested on:
- **Linux (Gcc)**
- **Windows (MinGW)**

### **Prerequisites:**
The following programs have to be installed and directly available (added into PATH) on the machine:
- a **C++ compiler**
- **CMake**
- **Git**
- **Conan**
- **Python**

### **Clone the CppSampleProject:**
Run the following commands:
```
git clone https://github.com/slali87/CppSampleProject.git
cd CppSampleProject
```

### **Steps to resolve the dependencies and set up the project:**
```
cmake -P cmake/Setup.cmake
```

### **Steps of build:**
```
cmake --preset=conan-release
cmake --build --preset=conan-release
```
Same for debug:
```
cmake --preset=conan-debug
cmake --build --preset=conan-debug
```

### **Commands of run:**
```
./build/Release/src/app/CppSampleProject
./build/Release/test/CppSampleProjectTest
ctest --test-dir ./build/Release/test
```
The first command runs the application, the second runs the tests.  
The third runs the tests by **ctest**.  
Same for debug:
```
./build/Debug/src/app/CppSampleProject
./build/Debug/test/CppSampleProjectTest
ctest --test-dir ./build/Debug/test
```

### **Delete the build directory:**
```
cmake -P cmake/Clean.cmake
```

### **Run all steps (including: deps, setup, config, build, run, test):**
```
TODO: ./run.sh all
```

### **Commands to switch betwen Release and Debug mode:**
```
TODO: ./run.sh setRel
TODO: ./run.sh setDeb
```
The default mode is Release.

### **Command to run Valgrind:**
```
TODO: ./run.sh valgrind
```
The **Valgrind** program has to be available on the machine.  
The debug version of the executable has to be built.

### **Command to measure the code coverage:**
```
TODO: ./run.sh testCov
```
The **LCOV Code Coverage** program has to be available on the machine.  
The report will be saved into the **build** directory; the main file is "./build/TestCov/CodeCoverage/index.html".  
Online the code coverage of the latest version can be found here: [**Code coverage**](https://slali87.github.io/CppSampleProject/CodeCoverage/).  
***Please note***:  
    - It detects that each Google test`s TEST macro runs multiple times, instead of 1.  
    - The test files are also checked by design to detect if all tests are run and there is no dead code in the test part; but the branch coverage is not applicable for the tests. 

### **Command to analyse the code:**
```
TODO: ./run.sh analyseCode
```
The **Clang-Tidy** program has to be available on the machine.  
The './run.sh config' command has to be ran before running this.

### **Command to format the code:**
```
TODO: ./run.sh formatCode
```
The **ClangFormat** program has to be available on the machine.

### **Command to create the document:**
```
cmake -P cmake/Doxygen.cmake
```
The **Doxygen** and the **Graphviz** programs have to be available on the machine.  
The doc will be saved into the **build** directory; the main file is "./build/Doc/html/index.html".  
Online the documentation about the latest version can be found here: [**Documentation**](https://slali87.github.io/CppSampleProject/).

### **Command to check complexity:**
```
TODO: ./run.sh complex
```
The **Lizard** program has to be available on the machine.  
A codecloud picture will be saved into the **build** directory; the file is "./build/codecloud.html".  
Online the pic about the latest version can be found here: [**Codecloud**](https://slali87.github.io/CppSampleProject/codecloud.html).

### **Commands to create a patch from the last commit, and to apply it:**
```
cmake -P cmake/CreatePatch.cmake
cmake -P cmake/ApplyPatch.cmake
```

## **Happy developing!**
