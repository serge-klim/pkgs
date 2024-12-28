vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO serge-klim/h5x
    REF "v${VERSION}"
    SHA512 eac88716cf26d49b824d24f634df6289d12dc2efc44e8ba1738aea9f1afd2a5dea0c7f3b60279acf224df8c713d614935447e45b4a90b6df353ac037611f5de0
    HEAD_REF main
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
   FEATURES
     "tools"      BUILD_TOOLS
     "tests"      BUILD_TESTS
)

if (VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
    set(HDF5_LINK_STATICALLY ON)
else()
    set(HDF5_LINK_STATICALLY OFF)
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
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")