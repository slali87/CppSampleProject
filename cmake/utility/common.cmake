# Get project name
function(getProjectName projectName)
    get_filename_component(name ${CMAKE_SOURCE_DIR} NAME)
    string(REPLACE " " "_" name ${name})
    set(${projectName} ${name} PARENT_SCOPE)
endfunction()

# Get version string
function(getVersion version)
    set(${version} "3.28" PARENT_SCOPE)
endfunction()

# Get list of source files
function(getListOfSourceFiles sourceFiles)
    set(expression h hpp hh c cpp cc cxx)
    list(TRANSFORM expression PREPEND "${CMAKE_SOURCE_DIR}/*.")
    file(GLOB_RECURSE files FOLLOW_SYMLINKS
        LIST_DIRECTORIES false ${expression}
    )
    list(FILTER files EXCLUDE REGEX ".*/build/.*")

    set(${sourceFiles} ${files} PARENT_SCOPE)
endfunction()

# Delete 'pattern's from the file named 'fileName'
function(deleteFromfile fileName pattern)
   file(READ ${fileName} fileContents)
   string(REGEX REPLACE "${pattern}" "" fileContents "${fileContents}")
   file(WRITE ${fileName} "${fileContents}")
endfunction()

# Delete whole lines matched with the 'pattern' from the file named 'fileName'
function(deleteLinesFromfile fileName pattern)
  file (STRINGS ${fileName} lines)
  file(WRITE ${fileName} "")
  foreach(line IN LISTS lines)
    string(REGEX REPLACE ${pattern} "" stripped "${line}")
    if("${stripped}" STREQUAL "${line}")
        file(APPEND ${fileName} "${stripped}\n")
    endif()
  endforeach()
endfunction()

# Search a 'pattern' in every line of the file named 'fileName'.
# If found, put "Found" string to 'found'
function(searchInFile fileName pattern found)
  file (STRINGS ${fileName} lines)
  foreach(line IN LISTS lines)
    string(REGEX MATCH ${pattern} stripped "${line}")
    if(NOT "${stripped}" STREQUAL "")
        set (${found} "Found" PARENT_SCOPE)
        return()
    endif()
  endforeach()
endfunction()

# Set build type based on the CMAKE_PARENT_LIST_FILE.
function(setBuildType)
  get_filename_component(scriptName ${CMAKE_PARENT_LIST_FILE} NAME_WLE)
  string(REPLACE "Set" "" buildType ${scriptName})

  set(directory "./build/BuildType/")
  if(EXISTS "${directory}")
      file(REMOVE_RECURSE "${directory}")
  endif()
  file(MAKE_DIRECTORY "${directory}")
  file(TOUCH "${directory}${buildType}")
endfunction()