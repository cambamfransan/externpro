# CARES_FOUND - cares was found
# CARES_INCLUDE_DIR - the cares include directory
# CARES_LIBRARIES - the cares libraries
# CARES_LIBRARY - the cares library
set(prj cares)
# this file (-config) installed to share/cmake
get_filename_component(XP_ROOTDIR ${CMAKE_CURRENT_LIST_DIR}/../.. ABSOLUTE)
get_filename_component(XP_ROOTDIR ${XP_ROOTDIR} ABSOLUTE) # remove relative parts
# targets file (-targets) installed to lib/cmake
include(${XP_ROOTDIR}/lib/cmake/${prj}-targets.cmake)
string(TOUPPER ${prj} PRJ)
unset(${PRJ}_INCLUDE_DIR CACHE)
find_path(${PRJ}_INCLUDE_DIR ares.h PATHS ${XP_ROOTDIR}/include/${prj} NO_DEFAULT_PATH)
set(${PRJ}_LIBRARIES cares)
set(${PRJ}_LIBRARY cares)
if(WIN32)
  add_definitions(-DCARES_STATICLIB)
endif()
set(reqVars ${PRJ}_INCLUDE_DIR ${PRJ}_LIBRARIES ${PRJ}_LIBRARY)
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(${prj} REQUIRED_VARS ${reqVars})
mark_as_advanced(${reqVars})
