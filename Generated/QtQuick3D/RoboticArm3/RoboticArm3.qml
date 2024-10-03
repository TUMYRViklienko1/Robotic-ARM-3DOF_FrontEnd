import QtQuick
import QtQuick3D


Node {
    id: node
    scale.x: 0.01
    scale.y: 0.01
    scale.z: 0.01

    // Resources

    // Nodes:

    property int waistRotation
    property int shoulderRotation
    property int elbowRotation
    property int clawMove
    property int clawRotation
     property alias waistJointCord: waist.scenePosition
     property alias shoulderJointCord: shoulder.scenePosition
     property alias elbowJointCord: elbow.scenePosition
    property alias clawJointCord: gripper.scenePosition
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
                x: 0
               y: 3242
                z: -19
                source: "meshes/roboticArm3DOF___servoMotorRC_MG90S_001_1_body_001_1_mesh.mesh"
                eulerRotation.y: waistRotation
                materials: [
                    darkPlastic_material
                ]

                Model {
                    id: shoulder
                    objectName: "Shoulder"
                    x: -28.798
                    //y: 5465.485
                    y:5416

                    z: -25.8258
                    source: "meshes/shoulder_mesh.mesh"
                    eulerRotation.z: 0
                    eulerRotation.y: 0
                    eulerRotation.x: shoulderRotation
                    materials: [
                        darkPlastic_material,
                        whitePlastic_material
                    ]

                    Model {
                        id: elbow
                        objectName: "Elbow"
                        x: 16.70

                       // y: 7537.34
                        y: 7550
                        z: 355
                        source: "meshes/roboticArm3DOF___connector_arm1_001_2_mesh.mesh"
                       eulerRotation.x: elbowRotation
                        materials: [
                            darkPlastic_material
                        ]

                        Model {
                            id: gripper
                            objectName: "Gripper"
                            x: -10.537
                            y: 5350
                            z: -346.00717
                            source: "meshes/roboticArm3DOF___hand_v2_1_endEffector_base_1_001_mesh.mesh"
                            materials: [
                                darkPlastic_material
                            ]

                            Model {
                                id: finger_R
                                objectName: "Finger_R"

                                x: clawMove
                                y: 3060
                                z: 0

                                source: "meshes/roboticArm3DOF___hand_v2_1_endEffector_grip_1_001_mesh.mesh"
                                materials: [
                                    whitePlastic_material
                                ]
                            }

                            Model {
                                id: finger_L
                                objectName: "Finger_L"

                                x: -(clawMove)
                                y: 3060
                                z: 0

                                source: "meshes/roboticArm3DOF___hand_v2_1_endEffector_grip_3_001_mesh.mesh"
                                materials: [
                                    whitePlastic_material
                                ]
                            }

                            Model {
                                id: controllerGripper
                                objectName: "ControllerGripper"
                                x: 545
                                y: 1750
                                eulerRotation.z: clawRotation
                                z: 2122.91821
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
            x: 1758.7012939453125
            y: 16208.34765625
            z: 330.9190368652344
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
