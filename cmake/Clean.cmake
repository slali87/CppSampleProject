include(cmake/utility/Common.cmake)
getVersion(version)
cmake_minimum_required(VERSION ${version})

file(REMOVE_RECURSE ./build CMakeUserPresets.json)