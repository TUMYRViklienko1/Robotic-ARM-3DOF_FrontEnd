import QtQuick
import QtQuick3D

Node {
    id: node
    scale.x: 0.01
    scale.y: 0.01
    scale.z: 0.01

    // Resources
    property int waistRotation
    property int shoulderRotation
    property int elbowRotation
    // Nodes:
    Node {
        id: rootNode
        objectName: "RootNode"
        Model {
            id: rootBase
            objectName: "RootBase"
            source: "meshes/rootBase_mesh.mesh"
            materials: [
                whitePlastic_material,
                darkPlastic_material
            ]

            Model {
                id: waist
                objectName: "Waist"
                source: "meshes/roboticArm3DOF___servoMotorRC_MG90S_001_1_body_001_1_mesh.mesh"
                eulerRotation.y: waistRotation

                materials: [
                    darkPlastic_material
                ]

                Model {
                    id: shoulder
                    objectName: "Shoulder"
                    source: "meshes/shoulder_mesh.mesh"
                    materials: [
                        darkPlastic_material,
                        whitePlastic_material
                    ]
                    eulerRotation.x: shoulderRotation
                    Model {
                        id: elbow
                        objectName: "Elbow"
                        source: "meshes/roboticArm3DOF___connector_arm1_001_2_mesh.mesh"
                        materials: [
                            darkPlastic_material
                        ]
                          eulerRotation.x: elbowRotation
                        Model {
                            id: gripper
                            objectName: "Gripper"
                            source: "meshes/roboticArm3DOF___hand_v2_1_endEffector_base_1_mesh.mesh"
                            materials: [
                                darkPlastic_material
                            ]

                            Model {
                                id: finger_R
                                objectName: "Finger_R"
                                source: "meshes/roboticArm3DOF___hand_v2_1_endEffector_grip_1_mesh.mesh"
                                materials: [
                                    whitePlastic_material
                                ]
                            }

                            Model {
                                id: finger_L
                                objectName: "Finger_L"
                                source: "meshes/roboticArm3DOF___hand_v2_1_endEffector_grip_3_mesh.mesh"
                                materials: [
                                    whitePlastic_material
                                ]
                            }

                            Model {
                                id: controllerGripper
                                objectName: "ControllerGripper"
                                source: "meshes/roboticArm3DOF___hand_v2_1_horn_MG90S_001_1_mesh.mesh"
                                materials: [
                                    darkPlastic_material
                                ]
                            }
                        }
                    }
                }
            }
        }
        Node {
            id: circle
            objectName: "Circle"
        }
    }

    Node {
        id: __materialLibrary__

        PrincipledMaterial {
            id: darkPlastic_material
            objectName: "darkPlastic"
            baseColor: "#ff090909"
            roughness: 0.7886598110198975
        }

        PrincipledMaterial {
            id: whitePlastic_material
            objectName: "whitePlastic"
            baseColor: "#ff9d9d9d"
            roughness: 0.7422680258750916
        }
    }

    // Animations:
}

/*##^##
Designer {
    D{i:0;cameraSpeed3d:25;cameraSpeed3dMultiplier:1}
}
##^##*/
