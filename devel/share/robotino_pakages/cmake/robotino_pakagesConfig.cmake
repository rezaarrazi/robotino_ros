# generated from catkin/cmake/template/pkgConfig.cmake.in

# append elements to a list and remove existing duplicates from the list
# copied from catkin/cmake/list_append_deduplicate.cmake to keep pkgConfig
# self contained
macro(_list_append_deduplicate listname)
  if(NOT "${ARGN}" STREQUAL "")
    if(${listname})
      list(REMOVE_ITEM ${listname} ${ARGN})
    endif()
    list(APPEND ${listname} ${ARGN})
  endif()
endmacro()

# append elements to a list if they are not already in the list
# copied from catkin/cmake/list_append_unique.cmake to keep pkgConfig
# self contained
macro(_list_append_unique listname)
  foreach(_item ${ARGN})
    list(FIND ${listname} ${_item} _index)
    if(_index EQUAL -1)
      list(APPEND ${listname} ${_item})
    endif()
  endforeach()
endmacro()

# pack a list of libraries with optional build configuration keywords
# copied from catkin/cmake/catkin_libraries.cmake to keep pkgConfig
# self contained
macro(_pack_libraries_with_build_configuration VAR)
  set(${VAR} "")
  set(_argn ${ARGN})
  list(LENGTH _argn _count)
  set(_index 0)
  while(${_index} LESS ${_count})
    list(GET _argn ${_index} lib)
    if("${lib}" MATCHES "^(debug|optimized|general)$")
      math(EXPR _index "${_index} + 1")
      if(${_index} EQUAL ${_count})
        message(FATAL_ERROR "_pack_libraries_with_build_configuration() the list of libraries '${ARGN}' ends with '${lib}' which is a build configuration keyword and must be followed by a library")
      endif()
      list(GET _argn ${_index} library)
      list(APPEND ${VAR} "${lib}${CATKIN_BUILD_CONFIGURATION_KEYWORD_SEPARATOR}${library}")
    else()
      list(APPEND ${VAR} "${lib}")
    endif()
    math(EXPR _index "${_index} + 1")
  endwhile()
endmacro()

# unpack a list of libraries with optional build configuration keyword prefixes
# copied from catkin/cmake/catkin_libraries.cmake to keep pkgConfig
# self contained
macro(_unpack_libraries_with_build_configuration VAR)
  set(${VAR} "")
  foreach(lib ${ARGN})
    string(REGEX REPLACE "^(debug|optimized|general)${CATKIN_BUILD_CONFIGURATION_KEYWORD_SEPARATOR}(.+)$" "\\1;\\2" lib "${lib}")
    list(APPEND ${VAR} "${lib}")
  endforeach()
endmacro()


if(robotino_pakages_CONFIG_INCLUDED)
  return()
endif()
set(robotino_pakages_CONFIG_INCLUDED TRUE)

# set variables for source/devel/install prefixes
if("TRUE" STREQUAL "TRUE")
  set(robotino_pakages_SOURCE_PREFIX /home/hilman/robotino_ros_ws/src/robotino_pakages)
  set(robotino_pakages_DEVEL_PREFIX /home/hilman/robotino_ros_ws/devel)
  set(robotino_pakages_INSTALL_PREFIX "")
  set(robotino_pakages_PREFIX ${robotino_pakages_DEVEL_PREFIX})
else()
  set(robotino_pakages_SOURCE_PREFIX "")
  set(robotino_pakages_DEVEL_PREFIX "")
  set(robotino_pakages_INSTALL_PREFIX /home/hilman/robotino_ros_ws/install)
  set(robotino_pakages_PREFIX ${robotino_pakages_INSTALL_PREFIX})
endif()

# warn when using a deprecated package
if(NOT "" STREQUAL "")
  set(_msg "WARNING: package 'robotino_pakages' is deprecated")
  # append custom deprecation text if available
  if(NOT "" STREQUAL "TRUE")
    set(_msg "${_msg} ()")
  endif()
  message("${_msg}")
endif()

# flag project as catkin-based to distinguish if a find_package()-ed project is a catkin project
set(robotino_pakages_FOUND_CATKIN_PROJECT TRUE)

if(NOT " " STREQUAL " ")
  set(robotino_pakages_INCLUDE_DIRS "")
  set(_include_dirs "")
  if(NOT " " STREQUAL " ")
    set(_report "Check the issue tracker '' and consider creating a ticket if the problem has not been reported yet.")
  elseif(NOT " " STREQUAL " ")
    set(_report "Check the website '' for information and consider reporting the problem.")
  else()
    set(_report "Report the problem to the maintainer 'hilman <hilman@todo.todo>' and request to fix the problem.")
  endif()
  foreach(idir ${_include_dirs})
    if(IS_ABSOLUTE ${idir} AND IS_DIRECTORY ${idir})
      set(include ${idir})
    elseif("${idir} " STREQUAL "include ")
      get_filename_component(include "${robotino_pakages_DIR}/../../../include" ABSOLUTE)
      if(NOT IS_DIRECTORY ${include})
        message(FATAL_ERROR "Project 'robotino_pakages' specifies '${idir}' as an include dir, which is not found.  It does not exist in '${include}'.  ${_report}")
      endif()
    else()
      message(FATAL_ERROR "Project 'robotino_pakages' specifies '${idir}' as an include dir, which is not found.  It does neither exist as an absolute directory nor in '/home/hilman/robotino_ros_ws/src/robotino_pakages/${idir}'.  ${_report}")
    endif()
    _list_append_unique(robotino_pakages_INCLUDE_DIRS ${include})
  endforeach()
endif()

set(libraries "")
foreach(library ${libraries})
  # keep build configuration keywords, target names and absolute libraries as-is
  if("${library}" MATCHES "^(debug|optimized|general)$")
    list(APPEND robotino_pakages_LIBRARIES ${library})
  elseif(${library} MATCHES "^-l")
    list(APPEND robotino_pakages_LIBRARIES ${library})
  elseif(${library} MATCHES "^-")
    # This is a linker flag/option (like -pthread)
    # There's no standard variable for these, so create an interface library to hold it
    if(NOT robotino_pakages_NUM_DUMMY_TARGETS)
      set(robotino_pakages_NUM_DUMMY_TARGETS 0)
    endif()
    # Make sure the target name is unique
    set(interface_target_name "catkin::robotino_pakages::wrapped-linker-option${robotino_pakages_NUM_DUMMY_TARGETS}")
    while(TARGET "${interface_target_name}")
      math(EXPR robotino_pakages_NUM_DUMMY_TARGETS "${robotino_pakages_NUM_DUMMY_TARGETS}+1")
      set(interface_target_name "catkin::robotino_pakages::wrapped-linker-option${robotino_pakages_NUM_DUMMY_TARGETS}")
    endwhile()
    add_library("${interface_target_name}" INTERFACE IMPORTED)
    if("${CMAKE_VERSION}" VERSION_LESS "3.13.0")
      set_property(
        TARGET
        "${interface_target_name}"
        APPEND PROPERTY
        INTERFACE_LINK_LIBRARIES "${library}")
    else()
      target_link_options("${interface_target_name}" INTERFACE "${library}")
    endif()
    list(APPEND robotino_pakages_LIBRARIES "${interface_target_name}")
  elseif(TARGET ${library})
    list(APPEND robotino_pakages_LIBRARIES ${library})
  elseif(IS_ABSOLUTE ${library})
    list(APPEND robotino_pakages_LIBRARIES ${library})
  else()
    set(lib_path "")
    set(lib "${library}-NOTFOUND")
    # since the path where the library is found is returned we have to iterate over the paths manually
    foreach(path /home/hilman/robotino_ros_ws/devel/lib;/home/hilman/robotino_ros_ws/devel/lib;/opt/ros/noetic/lib)
      find_library(lib ${library}
        PATHS ${path}
        NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
      if(lib)
        set(lib_path ${path})
        break()
      endif()
    endforeach()
    if(lib)
      _list_append_unique(robotino_pakages_LIBRARY_DIRS ${lib_path})
      list(APPEND robotino_pakages_LIBRARIES ${lib})
    else()
      # as a fall back for non-catkin libraries try to search globally
      find_library(lib ${library})
      if(NOT lib)
        message(FATAL_ERROR "Project '${PROJECT_NAME}' tried to find library '${library}'.  The library is neither a target nor built/installed properly.  Did you compile project 'robotino_pakages'?  Did you find_package() it before the subdirectory containing its code is included?")
      endif()
      list(APPEND robotino_pakages_LIBRARIES ${lib})
    endif()
  endif()
endforeach()

set(robotino_pakages_EXPORTED_TARGETS "")
# create dummy targets for exported code generation targets to make life of users easier
foreach(t ${robotino_pakages_EXPORTED_TARGETS})
  if(NOT TARGET ${t})
    add_custom_target(${t})
  endif()
endforeach()

set(depends "")
foreach(depend ${depends})
  string(REPLACE " " ";" depend_list ${depend})
  # the package name of the dependency must be kept in a unique variable so that it is not overwritten in recursive calls
  list(GET depend_list 0 robotino_pakages_dep)
  list(LENGTH depend_list count)
  if(${count} EQUAL 1)
    # simple dependencies must only be find_package()-ed once
    if(NOT ${robotino_pakages_dep}_FOUND)
      find_package(${robotino_pakages_dep} REQUIRED NO_MODULE)
    endif()
  else()
    # dependencies with components must be find_package()-ed again
    list(REMOVE_AT depend_list 0)
    find_package(${robotino_pakages_dep} REQUIRED NO_MODULE ${depend_list})
  endif()
  _list_append_unique(robotino_pakages_INCLUDE_DIRS ${${robotino_pakages_dep}_INCLUDE_DIRS})

  # merge build configuration keywords with library names to correctly deduplicate
  _pack_libraries_with_build_configuration(robotino_pakages_LIBRARIES ${robotino_pakages_LIBRARIES})
  _pack_libraries_with_build_configuration(_libraries ${${robotino_pakages_dep}_LIBRARIES})
  _list_append_deduplicate(robotino_pakages_LIBRARIES ${_libraries})
  # undo build configuration keyword merging after deduplication
  _unpack_libraries_with_build_configuration(robotino_pakages_LIBRARIES ${robotino_pakages_LIBRARIES})

  _list_append_unique(robotino_pakages_LIBRARY_DIRS ${${robotino_pakages_dep}_LIBRARY_DIRS})
  _list_append_deduplicate(robotino_pakages_EXPORTED_TARGETS ${${robotino_pakages_dep}_EXPORTED_TARGETS})
endforeach()

set(pkg_cfg_extras "")
foreach(extra ${pkg_cfg_extras})
  if(NOT IS_ABSOLUTE ${extra})
    set(extra ${robotino_pakages_DIR}/${extra})
  endif()
  include(${extra})
endforeach()
