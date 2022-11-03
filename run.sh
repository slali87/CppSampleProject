#!/bin/bash

function finish
{
   if [ $# -eq 2 ]; then
      echo $2
   fi

   echo
   echo "=============================="
   if [ $1 -eq 0 ]; then
      echo "Run successfully finished!"
   else
      echo "Run failed!!!"
   fi
   echo "=============================="

   exit $1
}

function getConfigValue
{
   configFile="./build.config"
   OS=$(uname)
   local value

   PATTERN="Linux"
   if echo "$OS" | grep -Eq "$PATTERN"; then
      value=$(grep -Po "(?<=^\"$1 - Linux\",).*" $configFile)
   else
      value=$(grep -Po "(?<=^\"$1 - Windows\",).*" $configFile)
   fi
   echo $"${value//\"}"
}

function solveDependecies
{
   echo "Solve dependecies"

   DIR="./../../Deps"
   if [ -d "$DIR" ]; then
      echo "Directory: $DIR already exists."
   else
      echo "Create directory: $DIR."
      mkdir "$DIR"
   fi
   cd "$DIR"

   DIR="googletest"
   if [ -d "$DIR" ]; then
      echo "Directory: $DIR already exists."
   else
      echo "Fetch and build: $DIR."
      git clone https://github.com/google/googletest.git

      cd -
      cmakeGen=$(getConfigValue "CMake generator")
      cd -
      echo The generator is: $cmakeGen
      if [ ${#cmakeGen} -gt 0 ]; then
         cmake -S googletest -B googletest/build "-G $cmakeGen"
      else
         cmake -S googletest -B googletest/build
      fi
      cmake --build googletest/build
   fi
   error=$?
   cd -

   return $error
}

function runSetup
{
   echo "Run setup"

   git config core.hooksPath ./tools/git/hooks
   git config commit.template ./tools/git/hooks/template_commit-msg
   return $?
}

function configure
{
   echo "Configure CMake"

   cmakeGen=$(getConfigValue "CMake generator")
   echo The generator is: $cmakeGen

   if [ ${#cmakeGen} -gt 0 ]; then
      cmake -B build "-G $cmakeGen"
   else
      cmake -B build
   fi
   return $?
}

function build
{
   echo "Build the project"

   cd build
   cmake --build .
   error=$?
   cd -
   return $error
}

function run
{
   echo "Run the application"

   ./build/src/CppSampleProject
   return $?
}

function test
{
   echo "Run the test"

   ./build/test/CppSampleProjectTest
   return $?
}

function clean
{
   echo "Clean the build"

   rm -rf ./build
   return $?
}

function createPatch
{
   echo "Create a patch from the last commit"

   git format-patch -1 HEAD --stdout > ./build/patchFile.patch
   return $?
}

function applyPatch
{
   echo "Apply the patch"

   git am < ./build/patchFile.patch
   return $?
}

function runTheJob
{
   if [ $1 = "deps" ]; then
      solveDependecies
   elif [ $1 = "setup" ]; then
      runSetup
   elif [ $1 = "config" ]; then
      configure
   elif [ $1 = "build" ]; then
      build
   elif [ $1 = "run" ]; then
      run
   elif [ $1 = "test" ]; then
      test
   elif [ $1 = "all" ]; then
      solveDependecies || finish 1
      runSetup || finish 1
      configure || finish 1
      build || finish 1
      run || finish 1
      test || finish 1
   elif [ $1 = "clean" ]; then
      clean
   elif [ $1 = "createPatch" ]; then
      createPatch
   elif [ $1 = "applyPatch" ]; then
      applyPatch
   else
      finish 1 "The parameter is wrong!"
   fi

   return $?
}

echo "Run is starting..."
echo "The received parameter is \"$1\"."

if [ $# -eq 1 ]; then
   runTheJob $1
   finish $?
else
   finish 1 "The number of parameters must be 1!"
fi
