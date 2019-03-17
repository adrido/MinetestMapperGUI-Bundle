cmake_minimum_required(VERSION 3.12)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(getGitVersion)

project(MinetestMapperGui
		VERSION ${git_version_major}.${git_version_minor}.${git_version_patch}.${git_commits_since_last_tag}
		HOMEPAGE_URL "https://bitbucket.org/adrido/minetestmappergui"
		DESCRIPTION "Graphical Userinterface for MinetestMapper")

set(USE_FOLDERS ON)

set(CMAKE_INSTALL_SYSTEM_RUNTIME_COMPONENT "comp_sys_runtime")
set(CMAKE_INSTALL_SYSTEM_RUNTIME_DESTINATION ".")
include(InstallRequiredSystemLibraries)

add_subdirectory("Minetestmapper/")
add_subdirectory("MinetestMapperGUI/")

cpack_add_component(comp_sys_runtime
					DISPLAY_NAME "C++ Runtime")

set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE.txt")
set(CPACK_PACKAGE_VENDOR "adrido")

set(CPACK_PACKAGE_EXECUTABLES MinetestMapperGUI "Minetest Mapper GUI")

set(CPACK_PACKAGE_ICON "${CMAKE_CURRENT_SOURCE_DIR}/MinetestMapperGUI/images/icon.ico")
set(CPACK_PACKAGE_INSTALL_DIRECTORY "${PROJECT_NAME}")

set(CPACK_WIX_CULTURES "en-us;en")
set(CPACK_WIX_PRODUCT_GUID "{366C1F8C-4CDD-44E9-B521-4B2541B51980}")
set(CPACK_WIX_UPGRADE_GUID "{444FE142-7C64-4F12-9F07-254A710076B1}")
set(CPACK_WIX_PRODUCT_ICON "${CPACK_PACKAGE_ICON}")
set(CPACK_WIX_UI_BANNER "${CMAKE_CURRENT_SOURCE_DIR}/WIX_UI_BANNER.BMP")
set(CPACK_WIX_UI_DIALOG "${CMAKE_CURRENT_SOURCE_DIR}/WIX_UI_DIALOG.BMP")
# Schould the program menu folder be MinetestMapper or MinetestMapperGui or Minetest or empty (current)?
#set(CPACK_WIX_PROGRAM_MENU_FOLDER ".")
set(CPACK_WIX_PROPERTY_ARPCOMMENTS "${CMAKE_PROJECT_DESCRIPTION}")
set(CPACK_WIX_PROPERTY_ARPHELPLINK "${CMAKE_PROJECT_HOMEPAGE_URL}")
set(CPACK_WIX_PROPERTY_ARPURLINFOABOUT "${CMAKE_PROJECT_HOMEPAGE_URL}")

include(CPack)
