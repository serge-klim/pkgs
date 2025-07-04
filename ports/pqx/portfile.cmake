vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO serge-klim/pqx
    REF e74da2ae6146e6d85957ee94f2cc06b1b8f1c3a3
    SHA512 75768313768311e309940040354b25bba30a124b632585941dde7ec86f0848782ec3be2c7b4f3ced4024aaad7819b615b4da51cc0e12051712ae76721612b2be
    HEAD_REF main
)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static" ARROW_LINK_STATICALLY)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
       -DCMAKE_CXX_STANDARD=20
       -DVCPKG_TARGET_TRIPLET=ON
       -DARROW_LINK_STATICALLY:BOOL=${ARROW_LINK_STATICALLY}       
)

vcpkg_cmake_install()
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")


