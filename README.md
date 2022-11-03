# **CppSampleProject**

## Welcome to **CppSampleProject**, the C++ sample project!

This is a **C++** sample project which presents a base project structure which is ideal to develop many projects in parallel. The dependencies are organized into one common place in order to avoid its unnecessary downloading and building. It contains templates to create libraries and applications (executable programs) as well. It uses [**CMake**](https://cmake.org/), [**Git**](https://git-scm.com/), [**GitHub**](https://github.com/), [**Google Test**](https://github.com/google/googletest), [**Markdown**](https://www.markdownguide.org/) and **Bash** and **Batch** scripts.

### **Structure of the project:**
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
    It is a folder to store the results of the build.

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
The **Deps** will be created explicitly in part [*Steps to resolve the dependencies*](#steps-to-resolve-the-dependencies).  
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

### **Steps to resolve the dependencies:**
Move into the **ProgrammingRepo** folder and run the following commands to create the **Deps** folder and fetch, build the **Google Test**:
```
mkdir Deps
cd Deps
git clone https://github.com/google/googletest.git
cmake -S googletest -B googletest/build   # Specify the CMake generator if the default is not right!
cmake --build googletest/build
cd ..
```

### **Clone the CppSampleProject:**
Move into the **ProgrammingRepo** folder and run:
```
cd Projects
git clone https://github.com/slali87/CppSampleProject.git
cd CppSampleProject
```

### **Set up the project:**
Move into the **CppSampleProject** folder and run:
```
./run.sh setup   #on Windows it should be run from git-bash or something like that
```

### **Steps of build:**
Move into the **CppSampleProject** folder and run:
```
cmake -B build   # Specify the CMake generator if the default is not right!
cd build
cmake --build .
```

### **Commands of run:**
Move into the **build** folder and run:
```
src/CppSampleProject
test/CppSampleProjectTest
ctest
```
The first command runs the application, the second runs the tests.  
The third runs the tests by **ctest**.

## **Happy developing!**
