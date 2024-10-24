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
cmake -P cmake/setup.cmake
```

### **Steps of build:**
```
cmake -P cmake/build.cmake
```

### **Commands of run:**
```
cmake -P cmake/run.cmake
cmake -P cmake/test.cmake
```
The first command runs the application, the second runs the tests.  
The **ctest** command also works:  
```
ctest --test-dir ./build/Release/test   # For Release
ctest --test-dir ./build/Debug/test     # For Debug
```

### **Delete the build directory:**
```
cmake -P cmake/clean.cmake
```

### **Run all steps (including: deps, setup, config, build, run, test):**
```
cmake -P cmake/all.cmake
```

### **Commands to switch betwen Release and Debug mode:**
```
cmake -P cmake/setRelease.cmake
cmake -P cmake/setDebug.cmake
```
The default mode is Release.

### **Command to run Valgrind:**
```
cmake -P cmake/valgrind.cmake
```
The **Valgrind** program has to be available on the machine.  
The debug version of the executable has to be built.

### **Command to measure the code coverage:**
```
cmake -P cmake/testCov.cmake
```
The **LCOV Code Coverage** program has to be available on the machine.  
The report will be saved into the **build** directory; the main file is "./build/TestCov/CodeCoverage/index.html".  
Online the code coverage of the latest version can be found here: [**Code coverage**](https://slali87.github.io/CppSampleProject/CodeCoverage/).  
***Please note***:  
    - It detects that each Google test`s TEST macro runs multiple times, instead of 1.  
    - The test files are also checked by design to detect if all tests are run and there is no dead code in the test part; but the branch coverage is not applicable for the tests. 

### **Command to analyse the code:**
```
cmake -P cmake/analyseCode.cmake
```
The **Clang-Tidy** program has to be available on the machine.  
The './run.sh config' command has to be ran before running this.

### **Command to format the code:**
```
cmake -P cmake/formatCode.cmake
```
The **ClangFormat** program has to be available on the machine.

### **Command to create the document:**
```
cmake -P cmake/doxygen.cmake
```
The **Doxygen** and the **Graphviz** programs have to be available on the machine.  
The doc will be saved into the **build** directory; the main file is "./build/Doc/html/index.html".  
Online the documentation about the latest version can be found here: [**Documentation**](https://slali87.github.io/CppSampleProject/).

### **Command to check complexity:**
```
cmake -P cmake/complex.cmake
```
The **Lizard** program has to be available on the machine.  
A codecloud picture will be saved into the **build** directory; the file is "./build/codecloud.html".  
Online the pic about the latest version can be found here: [**Codecloud**](https://slali87.github.io/CppSampleProject/codecloud.html).

### **Commands to create a patch from the last commit, and to apply it:**
```
cmake -P cmake/createPatch.cmake
cmake -P cmake/applyPatch.cmake
```

## **Happy developing!**
