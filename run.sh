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

   if [ "$1" = "TestCov" ]; then
      buildDir=$1
   else
      buildDir=$buildType
   fi

   command="cmake -B build/$buildDir"

   if [ "$1" = "TestCov" ]; then
      command="$command -DCODE_COVERAGE=ON"
   else
      command="$command -DCMAKE_BUILD_TYPE:STRING=$buildType -DCMAKE_EXPORT_COMPILE_COMMANDS=ON"
   fi

   cmakeGen=$(getConfigValue "CMake generator")
   echo The generator is: $cmakeGen

   if [ ${#cmakeGen} -gt 0 ]; then
      command="$command -G \"$cmakeGen\""
   fi

   echo Running: $command
   eval $command
   error=$?

   grep "CXX_FLAGS = " ./build/ -r
   (( error |= $? ))

   return $error
}

function build
{
   echo "Build the project"

   if [ "$1" = "TestCov" ]; then
      buildDir=$1
   else
      buildDir=$buildType
   fi

   command="cmake --build ./build/$buildDir"

   if ! [ "$1" = "TestCov" ]; then
      command="$command --config $buildType"
   fi
   command="$command -j 10"

   echo Running: $command
   eval $command

   return $?
}

function run
{
   echo "Run the application"

   ./build/"$buildType"/src/$(basename $(pwd))
   return $?
}

function test
{
   echo "Run the test"

   ./build/"$buildType"/test/$(basename $(pwd))Test
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

function runValgrind
{
   echo "Run Valgrind"

   if ! [ -f "./build/Debug/src/$(basename $(pwd))" ]; then
      echo "Debug executable is not found"
      return 1
   fi
   
   valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --error-exitcode=1 ./build/Debug/src/$(basename $(pwd))
   return $?
}

function testCoverage
{
   configure "TestCov"
   error=$?
   build "TestCov"
   (( error |= $? ))

   executableName=$(basename $(pwd))
   cd ./build/TestCov
	lcov --capture --initial --rc lcov_branch_coverage=1 --directory . --output-file lcovResultBefore
	src/"$executableName"	# Run the program because the main function of the App is not tested.
	test/"$executableName"Test
	lcov --capture --rc lcov_branch_coverage=1 --directory . --output-file lcovResultAfter
	lcov --rc lcov_branch_coverage=1 --add-tracefile lcovResultBefore --add-tracefile lcovResultAfter --output-file lcovResultCombined
	lcov --remove --rc lcov_branch_coverage=1 lcovResultCombined '/usr/*' '*/Deps/*' -o lcovResult
	genhtml lcovResult --rc genhtml_branch_coverage=1 --output-directory CodeCoverage > log
   (( error |= $? ))

   if ! grep -Eq "lines\.*: 100.0%" ./log; then
      return 1
   elif ! grep -Eq "functions\.*: 100.0%" ./log; then
      return 1
   fi

   # Remove the test files before check the branches because measuring of branches is not applicable for them.
   lcov --remove --rc lcov_branch_coverage=1 lcovResult '*/test/*' -o lcovResultNoTest
	genhtml lcovResultNoTest --rc genhtml_branch_coverage=1 --output-directory CodeCoverageNoTest > logNoTest

   # Search for no data since currently there are no any branches in the code.
   if ! grep -Eq "branches\.*: no data found" ./logNoTest; then
      return 1
   fi

   return $error
}

function analyseCode
{
   find . -path ./build -prune -o -regex '.*\.\(cpp\|h\)' -exec echo " --- Checking file: {} --- " \; -exec clang-tidy {} -p ./build/"$buildType"/ \;
   return $?
}

function formatCode
{
   # Check if there is any modified files
   numBefore=$(git diff --shortstat | tr -dc '0-9');

   find . -path ./build -prune -o -regex '.*\.\(cpp\|h\)' -exec clang-format -style=file -i {} \;
   error=$?

   # Check if there is any modified files
   numAfter=$(git diff --shortstat | tr -dc '0-9');

   if ! [ "$numBefore" = "$numAfter" ]; then
      echo "There is modified file. Check them!!!"
      error=1
   fi

   return $error
}

function doc
{
   doxygen Doxyfile
   error=$?
   # Remove unwanted 'strong' html tags from the results, Doxygen puts them for some reason...
   sed -i -e 's/\(&lt;strong&gt;\|&lt;\/strong&gt;\|<strong>\|<\/strong>\)//g' ./build/Doc/html/index.html \
      ./build/Doc/html/navtreedata.js \
      ./build/Doc/html/search/pages_0.js \
      ./build/Doc/html/search/all_0.js
   (( error |= $? ))
   return $error
}

function complexity
{
   # The limits and extensions should be re-investigated, the tool was sometimes stuck with t4
   lizard \
      -Tnloc=200 -Tcyclomatic_complexity=10 -Ttoken_count=1000 -Tparameter_count=5 -Tlength=250 \
      -t1 \
      -scyclomatic_complexity \
      -Eboolcount -Edependencycount -Eduplicate -Eduplicated_param_list -Eexitcount -Egotocount -Eio -End -Ens -Estatementcount -Ewordcount \
      -x'./build/*'
   error=$?

   mkdir ./build/
   mv codecloud.html ./build/
   return $error
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
   elif [ $1 = "valgrind" ]; then
      runValgrind
   elif [ $1 = "testCov" ]; then
      testCoverage
   elif [ $1 = "analyseCode" ]; then
      analyseCode
   elif [ $1 = "formatCode" ]; then
      formatCode
   elif [ $1 = "doc" ]; then
      doc
   elif [ $1 = "complex" ]; then
      complexity
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
