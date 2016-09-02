# ----------------------------------------------------------------------
# FindSQLite3.cmake - SQLite3 CMake module
#
# Copyright (C) 2015 Alexandre Pretyman. All rights reserved.
#
# ----------------------------------------------------------------------

if(NOT HUNTER_ENABLED)
  macro(hunter_status_debug)
    message(${ARGV})
  endmacro()
endif()

hunter_status_debug("SQLCIPHER_ROOT: ${SQLCIPHER_ROOT}")

find_path(
    SQLCIPHER_INCLUDE_DIR
      sqlite3.h
    PATHS
      "${SQLCIPHER_ROOT}/include"
    NO_DEFAULT_PATH
)

hunter_status_debug("SQLCIPHER_INCLUDE_DIR: ${SQLCIPHER_INCLUDE_DIR}")

find_library(
    SQLCIPHER_LIBRARY
      sqlcipher
    PATHS
      "${SQLCIPHER_ROOT}/lib"
    NO_DEFAULT_PATH
)

hunter_status_debug("SQLCIPHER_LIBRARY: ${SQLCIPHER_LIBRARY}")

if(NOT TARGET "SQLCipher")
  if(SQLCIPHER_INCLUDE_DIR AND SQLCIPHER_LIBRARY)
    set(SQLCIPHER_FOUND TRUE)
    add_library("SQLCipher" UNKNOWN IMPORTED)
    set_target_properties("SQLCipher"
        PROPERTIES
          INTERFACE_INCLUDE_DIRECTORIES "${SQLCIPHER_INCLUDE_DIR}"
          IMPORTED_LOCATION "${SQLCIPHER_LIBRARY}"
    )
    get_filename_component(
        SQLCIPHER_LIB_DIR
          "${SQLCIPHER_LIBRARY}"
        DIRECTORY CACHE
    )

    if(UNIX AND NOT APPLE AND NOT ANDROID) # if Linux
      string(REGEX MATCH "\\.a$" _ends_in_dot_a "${SQLCIPHER_LIBRARY}")
      string(COMPARE NOTEQUAL "${_ends_in_dot_a}" "" _sqlite_is_static)
      if(_sqlite_is_static)
        # when static linking we need to add pthread and dl libraries
        find_package(Threads REQUIRED)
        list(APPEND _sqlite3_static_library_dependencies Threads::Threads ${CMAKE_DL_LIBS})
        set_target_properties("SQLCipher"
            PROPERTIES
              INTERFACE_LINK_LIBRARIES "${_sqlite3_static_library_dependencies}"
        )
      endif()
    endif()
  elseif(SQLCipher_FIND_REQUIRED)
    message(FATAL_ERROR "Could not find SQLCipher")
  endif()
endif()
