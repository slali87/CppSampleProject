cmake_minimum_required(VERSION 3.28)

# install deps
if(UNIX)
  set(Profile "${CMAKE_SOURCE_DIR}/tools/conan/profileLinux")
elseif(WIN32)
  set(Profile "${CMAKE_SOURCE_DIR}/tools/conan/profileWindows")
endif()
execute_process(COMMAND conan install . -b=missing -pr:a=${Profile}
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
  COMMAND_ERROR_IS_FATAL ANY)
execute_process(COMMAND conan install . -s "&:build_type=Debug" -pr:a=${Profile}
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
  COMMAND_ERROR_IS_FATAL ANY)

# set git hooks
execute_process(COMMAND git config core.hooksPath ${CMAKE_SOURCE_DIR}/tools/git/hooks
  COMMAND_ERROR_IS_FATAL ANY)
execute_process(COMMAND git config commit.template ${CMAKE_SOURCE_DIR}/tools/git/hooks/template_commit-msg
  COMMAND_ERROR_IS_FATAL ANY)