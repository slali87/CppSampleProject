# **CppSampleProject**

## Welcome to **CppSampleProject**, the C++ sample project!

This is a cross-platform **C++** sample project which presents a base project structure which is ideal to develop many projects in parallel. The dependencies are organized into one common place in order to avoid its unnecessary downloading and building. It contains templates to create libraries and applications (executable programs) as well. It uses [**CMake**](https://cmake.org/), [**Git**](https://git-scm.com/), [**GitHub**](https://github.com/), [**Google Test**](https://github.com/google/googletest), [**Google Mock**](https://github.com/google/googletest/tree/main/googlemock), [**Markdown**](https://www.markdownguide.org/), **Bash** script, [**Valgrind**](https://valgrind.org/), [**LCOV Code Coverage**](https://wiki.documentfoundation.org/Development/Lcov), [**Clang-Tidy**](https://clang.llvm.org/extra/clang-tidy/), [**ClangFormat**](https://clang.llvm.org/docs/ClangFormat.html), [**Doxygen**](https://www.doxygen.nl/), [**Graphviz**](https://graphviz.org/), [**Lizard**](https://github.com/terryyin/lizard).

### **Structure of the project (only the major files are listed):**
```
ProgrammingRepo
    Deps
    Projects
        CppSampleProject
            build
            incl
                Lib.h
            src
                main.cpp
                App.h
                App.cpp
                CMakeLists.txt
            src_lib
                Lib.cpp
                CMakeLists.txt
            test
                main.cpp
                AppTestCases.cpp
                LibTestCases.cpp
                CMakeLists.txt
            tools
            CMakeLists.txt
```
- **ProgrammingRepo `*`**  
    It is a folder to store the projects and the dependencies.

- **Deps `*`**  
    It is a folder to store the dependencies like **Google Test**.  
    Since this directory is at the same level as the **Projects**, many **CppSampleProject**s or other projects can use it and its contents.

- **Projects `*`**  
    It is an umbrella folder to store the similar projects.

- **CppSampleProject**  
    This is the root folder of this **Git** repository.  
    It can be renamed without code modification.

- **build `*`**  
    It is a folder to store the generated files (builds, reports, documents...).

- **incl**  
    It is a folder to store the library related include files.

- **src**  
    It is a folder to store the header and source files of the application.

- **src_lib**  
    It is a folder to store the library related source files.

- **test**  
    It is a folder to store the test related header and source files.

- **tools**  
    It is a folder to store the tools and scripts.

`*` ***Please note*** that the folders - marked with `*` - are not part of this **Git** repository!  
The **ProgrammingRepo** and **Projects** folders are [*prerequisites*](#prerequisites).  
The **Deps** will be created implicitly in part [*Steps to resolve the dependencies*](#steps-to-resolve-the-dependencies).  
The **build** will be created implicitly in part [*Steps of build*](#steps-of-build).

### **Operating Systems:**
The project has been tested on:
- **Linux (Gcc)**
- **Windows (MinGW)**

### **Prerequisites:**
The following programs have to be installed and directly available (added into PATH) on the machine:
- a **C++ compiler**
- **CMake**
- **Git**

The **ProgrammingRepo** and **Projects** folders have to exist. Other folder names can be used without code modification.  

### **Clone the CppSampleProject:**
Move into the **ProgrammingRepo** folder and run:
```
cd Projects
git clone https://github.com/slali87/CppSampleProject.git
cd CppSampleProject
```

### **Customize the project:**
Open the **build.config** file and edit it if it is needed.  
\
After that, move into the **CppSampleProject** folder and run the **run.sh** script with the following parameters.  
On Windows, it should be run from git-bash or something like that.

### **Steps to resolve the dependencies:**
```
./run.sh deps
```
It creates the **Deps** folder and fetches, builds the **Google Test** if any of them is missing.

### **Set up the project:**
```
./run.sh setup
```

### **Steps of build:**
```
./run.sh config
./run.sh build
```

### **Commands of run:**
```
./run.sh run
./run.sh test
cd ./build && ctest && cd -
```
The first command runs the application, the second runs the tests.  
The third runs the tests by **ctest**.

### **Delete the build directory:**
```
./run.sh clean
```

### **Run all steps (including: deps, setup, config, build, run, test):**
```
./run.sh all
```

### **Commands to switch betwen Release and Debug mode:**
```
./run.sh setRel
./run.sh setDeb
```
The default mode is Release.

### **Command to run Valgrind:**
```
./run.sh valgrind
```
The **Valgrind** program has to be available on the machine.  
The debug version of the executable has to be built.

### **Command to measure the code coverage:**
```
./run.sh testCov
```
The **LCOV Code Coverage** program has to be available on the machine.  
The report will be saved into the **build** directory; the main file is "./build/TestCov/CodeCoverage/index.html".  
Online the code coverage of the latest version can be found here: [**Code coverage**](https://slali87.github.io/CppSampleProject/CodeCoverage/).  
***Please note***:  
    - It detects that each Google test`s TEST macro runs multiple times, instead of 1.  
    - The test files are also checked by design to detect if all tests are run and there is no dead code in the test part; but the branch coverage is not applicable for the tests. 

### **Command to analyse the code:**
```
./run.sh analyseCode
```
The **Clang-Tidy** program has to be available on the machine.  
The './run.sh config' command has to be ran before running this.

### **Command to format the code:**
```
./run.sh formatCode
```
The **ClangFormat** program has to be available on the machine.

### **Command to create the document:**
```
./run.sh doc
```
The **Doxygen** and the **Graphviz** programs have to be available on the machine.  
The doc will be saved into the **build** directory; the main file is "./build/Doc/html/index.html".  
Online the documentation about the latest version can be found here: [**Documentation**](https://slali87.github.io/CppSampleProject/).

### **Command to check complexity:**
```
./run.sh complex
```
The **Lizard** program has to be available on the machine.  
A codecloud picture will be saved into the **build** directory; the file is "./build/codecloud.html".  
Online the pic about the latest version can be found here: [**Codecloud**](https://slali87.github.io/CppSampleProject/codecloud.html).

### **Commands to create a patch from the last commit, and to apply it:**
```
./run.sh createPatch
./run.sh applyPatch
```

## **Happy developing!**
