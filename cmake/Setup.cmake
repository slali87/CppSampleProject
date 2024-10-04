cmake_minimum_required(VERSION 3.28)

#set config settings
execute_process(COMMAND conan profile detect --force WORKING_DIRECTORY ${CMAKE_SOURCE_DIR} COMMAND_ERROR_IS_FATAL ANY)

# install deps
execute_process(COMMAND conan install . -b=missing
                COMMAND conan install . -s "&:build_type=Debug" WORKING_DIRECTORY ${CMAKE_SOURCE_DIR} COMMAND_ERROR_IS_FATAL ANY)

# set git hooks
execute_process(COMMAND git config core.hooksPath ${CMAKE_SOURCE_DIR}/tools/git/hooks
                COMMAND git config commit.template ${CMAKE_SOURCE_DIR}/tools/git/hooks/template_commit-msg COMMAND_ERROR_IS_FATAL ANY)