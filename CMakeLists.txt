cmake_minimum_required(VERSION 3.12)

project(MinetestMapperGUI
		VERSION 1.0.0.0)

set(USE_FOLDERS ON)

add_subdirectory("Minetestmapper/")
add_subdirectory("MinetestMapperGUI/")

set(CMAKE_INSTALL_SYSTEM_RUNTIME_DESTINATION ".")
include(InstallRequiredSystemLibraries)
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE.md")
include(CPack)
