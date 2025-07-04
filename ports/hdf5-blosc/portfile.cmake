vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Blosc/hdf5-blosc
    REF refs/tags/v${VERSION}
    SHA512 cbc16eb98b8a4f6b53dfa36c62d094a13fac9cc17e865b2e7b0986c27a5b14408c5296c9dd2a9c9027fae451e22caf478416509ed9b6040e33e4c9b5d6dda176
    HEAD_REF master
)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static" LINK_STATICALLY)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" DESTINATION "${SOURCE_PATH}")
file(COPY "${CMAKE_CURRENT_LIST_DIR}/config.cmake.in" DESTINATION "${SOURCE_PATH}")

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
       -DHDF5_LINK_STATICALLY:BOOL=${LINK_STATICALLY}
       -DBLOSC_LINK_STATICALLY:BOOL=${LINK_STATICALLY}
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")