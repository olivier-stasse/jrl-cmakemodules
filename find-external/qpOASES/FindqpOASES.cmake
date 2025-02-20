#
# Copyright 2019 CNRS
#
# Author: Guilhem Saurel
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU Lesser General Public License as published by the Free
# Software Foundation, either version 3 of the License, or (at your option) any
# later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
# details.
#
# You should have received a copy of the GNU Lesser General Public License along
# with this program.  If not, see <https://www.gnu.org/licenses/>.
#

# Try to find qpOASES in standard prefixes and in ${qpOASES_PREFIX} Once done
# this will define qpOASES_FOUND - System has qpOASES qpOASES_INCLUDE_DIRS - The
# qpOASES include directories qpOASES_LIBRARIES - The libraries needed to use
# qpOASES qpOASES_DEFINITIONS - Compiler switches required for using qpOASES

find_path(
  qpOASES_INCLUDE_DIR
  NAMES qpOASES.hpp
  PATHS ${qpOASES_PREFIX} ${qpOASES_PREFIX}/include
)
find_library(
  qpOASES_LIBRARY
  NAMES qpOASES
  PATHS ${qpOASES_PREFIX} ${qpOASES_PREFIX}/lib
)

set(qpOASES_LIBRARIES ${qpOASES_LIBRARY})
set(qpOASES_INCLUDE_DIRS ${qpOASES_INCLUDE_DIR})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
  qpOASES
  DEFAULT_MSG
  qpOASES_LIBRARY
  qpOASES_INCLUDE_DIR
)
mark_as_advanced(qpOASES_INCLUDE_DIR qpOASES_LIBRARY)

if(qpOASES_FOUND AND NOT TARGET qpOASES::qpOASES)
  add_library(qpOASES::qpOASES SHARED IMPORTED)
  set_target_properties(
    qpOASES::qpOASES
    PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${qpOASES_INCLUDE_DIR}"
  )
  set_target_properties(
    qpOASES::qpOASES
    PROPERTIES IMPORTED_LOCATION_RELEASE "${qpOASES_LIBRARY}"
  )
  set_property(
    TARGET qpOASES::qpOASES
    APPEND
    PROPERTY IMPORTED_CONFIGURATIONS "RELEASE"
  )
  set_target_properties(
    qpOASES::qpOASES
    PROPERTIES IMPORTED_LINK_INTERFACE_LANGUAGES "CXX"
  )
  message(
    STATUS
    "qpOASES found (include: ${qpOASES_INCLUDE_DIR}, lib: ${qpOASES_LIBRARY})"
  )
endif()
