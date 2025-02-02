vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO serge-klim/h5x
    REF "v${VERSION}"
    SHA512 5fec2dbb04cafeb6947575eee56265ac855144b6be78779d894e6ffe75dda98141eab0218f24bb8462c741156b60020fd5bbb4da3a48d5de3c9ae9266e391ea2
    HEAD_REF main
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
   FEATURES
     "tools"      BUILD_TOOLS
     "tests"      BUILD_TESTS
)

if (VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
    set(HDF5_LINK_STATICALLY OFF)
else()
    set(HDF5_LINK_STATICALLY ON)
endif()

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static" HDF5_LINK_STATICALLY)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
       -DCMAKE_CXX_STANDARD=20
       -DVCPKG_TARGET_TRIPLET=ON
       ${FEATURE_OPTIONS}
       -DHDF5_LINK_STATICALLY=${HDF5_LINK_STATICALLY}
       -DBUILD_BENCHMARK=OFF       
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()
vcpkg_fixup_pkgconfig()