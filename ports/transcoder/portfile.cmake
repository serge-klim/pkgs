vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO serge-klim/transcoder
    REF "v${VERSION}"
    SHA512 1a270670e5234a6744015dad22927daa090cfeab143d8c7e8f84848725c6f5085c6c10d0b1568dc6355c83666af87a676ead2899e7028d5927281dd920ede358
    HEAD_REF main
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
   FEATURES
     "tests"      BUILD_TESTS
)


if (VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
    set(HDF5_LINK_STATICALLY ON)
else()
    set(HDF5_LINK_STATICALLY OFF)
endif()


vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
       -DCMAKE_CXX_STANDARD=20
       -DVCPKG_TARGET_TRIPLET=ON
       ${FEATURE_OPTIONS}
)

vcpkg_cmake_install()
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")


