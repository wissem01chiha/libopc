find_package(LibXml2 QUIET)
if(LibXml2_FOUND)
    message(STATUS "libxml2 found: ${LibXml2_INCLUDE_DIRS}")
else()
    message(STATUS "libxml2 not found. Downloading and building from source...")
    include(FetchContent)
    FetchContent_Declare(
        libxml2
        URL https://gitlab.gnome.org/GNOME/libxml2/-/archive/v2.15.2/libxml2-v2.15.2.zip
    )
    set(LIBXML2_WITH_ICONV OFF)
    FetchContent_MakeAvailable(libxml2)
    include_directories(SYSTEM ${libxml2_SOURCE_DIR})
    message(STATUS "libxml2 has been fetched and is available at ${libxml2_SOURCE_DIR}")
endif()
