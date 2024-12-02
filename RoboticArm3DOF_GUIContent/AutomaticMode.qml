import QtQuick 6.7
import QtQuick.Layouts
import QtQml
import backEnd.com 1.0

Item {
    id:automaticMode
    property alias mDelay: delay
    ColumnLayout{
        Text{
             text: "Auto mode:"
             color: "white"
             font.pixelSize: 32

         }

        RowLayout{
            id:autoRowLayout

            InverseTextInput {
                id:delay
                recColor: "#5362f4"
            }
            MyButton {
                id: autoModeStartButton
                title: "Auto"
                //backgroundDefultColor: "#eb984e"
                onPressed: {
                    stopButton.autoModeIsRunning = true
                    sizeAutoMode = AutoModeModel.getSize()-1;
                    startAutoMode()
                }
            }

            MyButton{
                id:stopButton
                title: "Stop"
                // backgroundDefultColor: "#e74c3c"
                onPressed: autoModeIsRunning = !autoModeIsRunning
            }

        }

        Text{
             text: "Recorded orders:"
             color: "white"
             font.pixelSize: 20
         }


        ListView {
            id: angleFromListView
            width: 300
            height: 300
            focus: true
            clip: true

            model: personModelAutoMode

            // Reusing the same delegate from the first ListView
            delegate:Loader {
                id: deleteLoader
                source: "ModelDelegate.qml"
                active: true
                onLoaded: {
                    if (item) {
                        item.flagForLoader = false;
                    }
                }
            }
            header: Rectangle {
                width: angleFromListView.width
                height: 40
                color: "#2b2b2b"

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 5
                    Text {
                        text: "Claw"
                        color: "white"
                        font.bold: true
                        Layout.alignment: Qt.AlignLeft
                        Layout.preferredWidth: angleFromListView.width / 4
                    }
                    Text {
                        text: "Theta 1"
                        color: "white"
                        font.bold: true
                        Layout.alignment: Qt.AlignLeft
                        Layout.preferredWidth: angleFromListView.width / 4
                    }
                    Text {
                        text: "Theta 2"
                        color: "white"
                        font.bold: true
                        Layout.alignment: Qt.AlignLeft
                        Layout.preferredWidth: angleFromListView.width / 4
                    }
                    Text {
                        text: "Theta 3"
                        color: "white"
                        font.bold: true
                        Layout.alignment: Qt.AlignLeft
                        Layout.preferredWidth: angleFromListView.width / 4
                    }
                }
            }

            footer: Rectangle {
                anchors { left: parent.left; right: parent.right }
                height: 40
                color: "#2b2b2b"
            }

            highlight: Rectangle {
                color: "lightsteelblue"
                radius: 5
            }
        }
    }
}
