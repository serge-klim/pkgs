vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO serge-klim/transcoder
    REF "v${VERSION}"
    SHA512 ee8cf9356f6646f6753cbb1636e507805d5972ef6eb1edbad75ca3b73fd1d9c01487aa97d9830df4e68357fa044305c71a3939ea2cc6f456e95bf818d86a8e08
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


