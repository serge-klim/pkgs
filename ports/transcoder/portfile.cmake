vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO serge-klim/transcoder
    REF "v${VERSION}"
    SHA512 6334c43d91316087a8adbee9b1de1a3c1649141ed2c2946585419872b12e2fe6d819f91138501c72e783fba60150d03490fd0808fadbd32b7145c5b95d6ef724
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


