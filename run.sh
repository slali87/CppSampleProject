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
   OS=$(uname)
   PATTERN="Linux"
   if echo "$OS" | grep -Eq "$PATTERN"; then
      search="\"$1 - Linux\""
   else
      search="\"$1 - Windows\""
   fi

   configFile="./build.config"
   local result
   while IFS=, read -r key value; do
      if [ "$key" = "$search" ]; then
         result="$value"
         break
      fi
   done < "$configFile"

   echo $"${result//\"}"
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

      command="cmake -S googletest -B googletest/build"
      if [ ${#cmakeGen} -gt 0 ]; then
         command="$command -G \"$cmakeGen\""
      fi
      eval $command
      cmake --build googletest/build -j 10
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

   command="cmake -B build/$buildType -DCMAKE_BUILD_TYPE:STRING=$buildType"
   if [ ${#cmakeGen} -gt 0 ]; then
      command="$command -G \"$cmakeGen\""
   fi
   eval $command
   error=$?

   grep "CXX_FLAGS = " ./build/ -r
   (( error |= $? ))

   return $error
}

function build
{
   echo "Build the project"

   cmake --build ./build/"$buildType" --config "$buildType" -j 10
   return $?
}

function run
{
   echo "Run the application"

   ./build/"$buildType"/src/CppSampleProject
   return $?
}

function test
{
   echo "Run the test"

   ./build/"$buildType"/test/CppSampleProjectTest
   return $?
}

function clean
{
   echo "Clean the build"

   rm -rf ./build
   return $?
}

function setBuildType
{
   echo "Set build type to $1"

   DIR="./build"
   if [ -d "$DIR" ]; then
      echo "Directory: $DIR already exists."
   else
      echo "Create directory: $DIR."
      mkdir "$DIR"
   fi
   echo "$1" > "$DIR/BuildType"

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
   if [ $1 = "setRel" ]; then
      setBuildType "Release"
   elif [ $1 = "setDeb" ]; then
      setBuildType "Debug"
   elif [ $1 = "deps" ]; then
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

function readBuildType
{
   buildType=$(head -n 1 ./build/BuildType)
   if [ ${#buildType} -eq 0 ]; then
      buildType="Release"
   fi
   echo The current build type is: $buildType
}

echo "Run is starting..."
echo "The received parameter is \"$1\"."

if [ $# -eq 1 ]; then
   readBuildType
   runTheJob $1
   finish $?
else
   finish 1 "The number of parameters must be 1!"
fi
