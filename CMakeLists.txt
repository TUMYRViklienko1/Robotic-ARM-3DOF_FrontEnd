
cmake_minimum_required(VERSION 3.21.1)

option(LINK_INSIGHT "Link Qt Insight Tracker library" ON)
option(BUILD_QDS_COMPONENTS "Build design studio components" ON)

project(RoboticArm3DOF_GUIApp LANGUAGES CXX)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}" "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

set(CMAKE_AUTOMOC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(QT_QML_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/qml)
set(QML_IMPORT_PATH ${QT_QML_OUTPUT_DIRECTORY}
    CACHE STRING "Import paths for Qt Creator's code model"
    FORCE
)




find_package(Qt6 6.7 REQUIRED COMPONENTS Core Gui Qml Quick Test)
qt_standard_project_setup()

# qt_add_qml_module(
#     SOURCES
#     WidgetListDynmaic_cords.h WidgetListDynmaic_cords.cpp
# )

qt_add_executable(${CMAKE_PROJECT_NAME}
    BackEnd.h BackEnd.cpp
    SerialPort.h SerialPort.cpp
    InverseKinematics.h InverseKinematics.cpp
     WidgetListDynmaic_cords.h WidgetListDynmaic_cords.cpp
   )
qt_add_resources(${CMAKE_PROJECT_NAME} "configuration"
    PREFIX "/"
    FILES
    qtquickcontrols2.conf)


include(qds)

if (BUILD_QDS_COMPONENTS)
    include(qmlcomponents OPTIONAL)
endif()

if (LINK_INSIGHT)
    include(insight OPTIONAL)
endif ()

include(GNUInstallDirs)
install(TARGETS ${CMAKE_PROJECT_NAME}
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
find_package(Qt6 REQUIRED COMPONENTS SerialPort)
find_package(Qt6 REQUIRED COMPONENTS Widgets)
find_package(Qt6 REQUIRED COMPONENTS Core)
target_link_libraries(${CMAKE_PROJECT_NAME}
    PRIVATE Qt6::SerialPort
    PRIVATE Qt6::Test

    Qt6::Widgets
    Qt6::Core
)
