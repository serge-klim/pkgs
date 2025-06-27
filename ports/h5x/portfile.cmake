vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO serge-klim/h5x
    REF "v${VERSION}"
    SHA512 b2a5c148761410f6bbd103267acd1eb3e16244d274c9120d19437fd37118890ff36d225beff1d8caebf1289c1cafb9466798f9b92d7f8e9da16e06e3bb6b470a
    HEAD_REF main
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
   FEATURES
     "tools"      BUILD_TOOLS
     "tests"      BUILD_TESTS
)


string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static" HDF5_LINK_STATICALLY)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
       -DCMAKE_CXX_STANDARD=20
       -DVCPKG_TARGET_TRIPLET=ON
       ${FEATURE_OPTIONS}
       -DHDF5_LINK_STATICALLY:BOOL=${HDF5_LINK_STATICALLY}
       -DBUILD_BENCHMARK=OFF       
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()
vcpkg_fixup_pkgconfig()