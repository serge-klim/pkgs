cmake_minimum_required(VERSION 3.24)
project(hdf5-blosc VERSION 1.0.1 LANGUAGES C)

find_package(hdf5 CONFIG REQUIRED)
find_package(blosc CONFIG REQUIRED)


add_library (hdf5_blosc STATIC
             src/blosc_filter.c
             src/blosc_plugin.c
)

target_sources(hdf5_blosc PUBLIC FILE_SET HEADERS
                BASE_DIRS src
				FILES
                src/blosc_filter.h
                src/blosc_plugin.h
)


target_include_directories(hdf5_blosc INTERFACE
		$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
		$<INSTALL_INTERFACE:include>
		)

target_link_libraries(hdf5_blosc PUBLIC
                        blosc$<IF:$<BOOL:${BLOSC_LINK_STATICALLY}>,_static,_shared>
                        hdf5::hdf5$<IF:$<BOOL:${HDF5_LINK_STATICALLY}>,-static,-shared>
                        )


include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

configure_package_config_file(${PROJECT_SOURCE_DIR}/config.cmake.in
							${CMAKE_CURRENT_BINARY_DIR}/hdf5_blosc-config.cmake
							INSTALL_DESTINATION lib/cmake/hdf5_blosc
							NO_SET_AND_CHECK_MACRO
)

write_basic_package_version_file(
		${CMAKE_CURRENT_BINARY_DIR}/hdf5_blosc-config-version.cmake
		VERSION ${CMAKE_PROJECT_VERSION}
		COMPATIBILITY AnyNewerVersion
)

install(TARGETS hdf5_blosc
        EXPORT hdf5_blosc-targets
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        FILE_SET HEADERS DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

install(FILES 
			${CMAKE_CURRENT_BINARY_DIR}/hdf5_blosc-config.cmake
			${CMAKE_CURRENT_BINARY_DIR}/hdf5_blosc-config-version.cmake
		DESTINATION 
		    ${CMAKE_INSTALL_DATADIR}/hdf5_blosc
)

install(EXPORT hdf5_blosc-targets
		FILE hdf5_blosc-targets.cmake
		NAMESPACE unofficial::
		DESTINATION ${CMAKE_INSTALL_DATADIR}/hdf5_blosc
)
