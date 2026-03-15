cmake_minimum_required(VERSION 3.12...3.31)

project(
  libopc
  VERSION 1.0.0
  HOMEPAGE_URL "https://github.com/freuter/libopc"
  DESCRIPTION "Open Packaging Convention Library"
  LANGUAGES C 
)

# ============================================================================
# CPack
# ============================================================================
set(CPACK_PACKAGE_VENDOR "libopc-project")
set(CPACK_PACKAGE_DESCRIPTION_FILE ${CMAKE_SOURCE_DIR}/README.md)
set(CPACK_RESOURCE_FILE_LICENSE ${CMAKE_SOURCE_DIR}/LICENSE)
set(CPACK_RESOURCE_FILE_README ${CMAKE_SOURCE_DIR}/README.md)

# ============================================================================
# CTest
# ============================================================================
set (CTEST_OUTPUT_ON_FAILURE TRUE)

# ============================================================================
# CMake
# ============================================================================
list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")
set(CMAKE_EXPORT_COMPILE_COMMANDS OFF)

# ============================================================================
# Configuration
# ============================================================================
option(LIBOPC_BUILD_TESTING "Enable libopc Examples as tests" ON)
option(LIBOPC_BUILD_SHARED "Enable building libopc shared library" ON)
option(LIBOPC_BUILD_STATIC "Enable building libopc static library" ON)
option(LIBOPC_INSTALL "Enable installation of libopc" ON)

option(ASAN "Enable AddressSanitizer (ASan)" ON)

get_property(IS_MULTI GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)

if(NOT DEFINED CMAKE_BUILD_TYPE AND NOT IS_MULTI)
    message(STATUS "No CMAKE_BUILD_TYPE set -- using Release")
    set(CMAKE_BUILD_TYPE Release)
endif(NOT DEFINED CMAKE_BUILD_TYPE AND NOT IS_MULTI)

# ============================================================================
# Include
# ============================================================================
include(CheckCSourceCompiles)
include(CheckFunctionExists)
include(CheckIncludeFile)
include(CMakePackageConfigHelpers)
include(CheckTypeSize)
include(CheckCCompilerFlag)
include(CMakeDependentOption)
include(GNUInstallDirs)

# ============================================================================
# Flags
# ============================================================================
if(ASAN)
    if(CMAKE_C_COMPILER_ID MATCHES "AppleClang|GNU|Clang")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fno-omit-frame-pointer -fsanitize=address")
        set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -fno-omit-frame-pointer -fsanitize=address")
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fno-omit-frame-pointer -fsanitize=address")
    elseif(MSVC)
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} /fsanitize=address")
    endif()
endif()

# ============================================================================
# Include
# ============================================================================
include(cmake/external/zlib.cmake)
include(cmake/external/libxml2.cmake)
if(LIBOPC_BUILD_TESTING)
    include(CTest)
    enable_testing()
    include(cmake/external/unity.cmake)
endif()

# ============================================================================
# 
# ============================================================================
set(opc_sources
    opc/container.c
    opc/file.c
    opc/helper.c
    opc/inputstream.c
    opc/opc.c
    opc/outputstream.c
    opc/part.c
    opc/properties.c
    opc/relation.c
    opc/xmlreader.c
    opc/xmlwriter.c
    opc/zip.c
)

set(opc_headers
    opc/container.h
    opc/file.h
    opc/helper.h
    opc/inputstream.h
    opc/opc.h
    opc/outputstream.h
    opc/part.h
    opc/properties.h
    opc/relation.h
    opc/xmlreader.h
    opc/xmlwriter.h
    opc/zip.h
)

set(mce_sources
    mce/helper.c
    mce/textreader.c
    mce/textwriter.c
)

set(mce_headers
    mce/helper.h
    mce/textreader.h
    mce/textwriter.h
)

set(plib_sources
    plib/plib.c
)

set(plib_headers
    plib/plib.h
)

set(sample_sources
    sample/mce_extract.c
    sample/mce_read.c
)

set(test_sources
    test/
)

set(fuzz_sources
    fuzz/
)

# ============================================================================
# Pkg-Config
# ============================================================================
configure_file(
  ${CMAKE_CURRENT_SOURCE_DIR}/${PROJECT_NAME}.pc.in
  ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.pc
  @ONLY
)
