# Install script for directory: C:/Users/ututi/Desktop/project_RoboticArm/QT_GUI_2/RoboticArm3DOF_GUI/cmake-build-release/_deps/ds-src/src/imports

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/Qt/6.7.2/mingw_64")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "C:/Program Files/JetBrains/CLion 2024.1.2/bin/mingw/bin/objdump.exe")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Users/ututi/Desktop/project_RoboticArm/QT_GUI_2/RoboticArm3DOF_GUI/cmake-build-release/_deps/ds-build/src/imports/components/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Users/ututi/Desktop/project_RoboticArm/QT_GUI_2/RoboticArm3DOF_GUI/cmake-build-release/_deps/ds-build/src/imports/effects_qt6/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Users/ututi/Desktop/project_RoboticArm/QT_GUI_2/RoboticArm3DOF_GUI/cmake-build-release/_deps/ds-build/src/imports/designeffects/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Users/ututi/Desktop/project_RoboticArm/QT_GUI_2/RoboticArm3DOF_GUI/cmake-build-release/_deps/ds-build/src/imports/flowview/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Users/ututi/Desktop/project_RoboticArm/QT_GUI_2/RoboticArm3DOF_GUI/cmake-build-release/_deps/ds-build/src/imports/logichelper/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Users/ututi/Desktop/project_RoboticArm/QT_GUI_2/RoboticArm3DOF_GUI/cmake-build-release/_deps/ds-build/src/imports/multitext/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Users/ututi/Desktop/project_RoboticArm/QT_GUI_2/RoboticArm3DOF_GUI/cmake-build-release/_deps/ds-build/src/imports/tools/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Users/ututi/Desktop/project_RoboticArm/QT_GUI_2/RoboticArm3DOF_GUI/cmake-build-release/_deps/ds-build/src/imports/application/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Users/ututi/Desktop/project_RoboticArm/QT_GUI_2/RoboticArm3DOF_GUI/cmake-build-release/_deps/ds-build/src/imports/utils/cmake_install.cmake")
endif()
