include(cmake/utility/common.cmake)
getVersion(version)
cmake_minimum_required(VERSION ${version})

file(REMOVE_RECURSE ./build CMakeUserPresets.json)