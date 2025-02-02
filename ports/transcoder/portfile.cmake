vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO serge-klim/transcoder
    REF "v${VERSION}"
    SHA512 f9b2cb3f4e6b80c2a5416d6bd93443694fdbfd51f7999ad6f436854ce38a215d5e0a074c8bacf9e40cfa6b41a27b76de030f05369810691e0277bf888ea8cf76
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


