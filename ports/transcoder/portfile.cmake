vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO serge-klim/transcoder
    REF "v${VERSION}"
    SHA512 40d58224da0c49847ab26c7edd0ac8507aba34ce01ae9fddb587500cbac5c60c40107066e73402d3b3534cc026c87fe03de5b0d675f661ca6329b426f480ebaa
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


