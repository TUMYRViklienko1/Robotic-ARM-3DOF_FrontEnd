### This file is automatically generated by Qt Design Studio.
### Do not change

add_subdirectory(Generated)
add_subdirectory(RoboticArm3DOF_GUIContent)
add_subdirectory(RoboticArm3DOF_GUI)
add_subdirectory(App)

target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
	Generated_QtQuick3D_RoboticArm3plugin
	RoboticArm3DOF_GUIContentplugin
	RoboticArm3DOF_GUIplugin)