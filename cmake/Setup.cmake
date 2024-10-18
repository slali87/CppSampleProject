include(cmake/utility/Common.cmake)
getVersion(version)
cmake_minimum_required(VERSION ${version})

# install deps
execute_process(COMMAND conan config install ./tools/conan/settings_user.yml
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
  COMMAND_ERROR_IS_FATAL ANY)

if(UNIX)
  set(profile "${CMAKE_SOURCE_DIR}/tools/conan/profileLinux")
elseif(WIN32)
  set(profile "${CMAKE_SOURCE_DIR}/tools/conan/profileWindows")
endif()

execute_process(COMMAND conan install . -b=missing -pr:a=${profile}
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
  COMMAND_ERROR_IS_FATAL ANY)
execute_process(COMMAND conan install . -s "&:build_type=Debug" -pr:a=${profile}
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
  COMMAND_ERROR_IS_FATAL ANY)
execute_process(COMMAND conan install . -s "&:build_type=TestCov" -pr:a=${profile}
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
  COMMAND_ERROR_IS_FATAL ANY)

# set default build type to release
if(NOT EXISTS "./build/BuildType/")
  execute_process(COMMAND cmake -P cmake/SetRelease.cmake
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMAND_ERROR_IS_FATAL ANY)
endif()

# set git hooks
execute_process(COMMAND git config core.hooksPath ${CMAKE_SOURCE_DIR}/tools/git/hooks
  COMMAND_ERROR_IS_FATAL ANY)
execute_process(COMMAND git config commit.template ${CMAKE_SOURCE_DIR}/tools/git/hooks/template_commit-msg
  COMMAND_ERROR_IS_FATAL ANY)