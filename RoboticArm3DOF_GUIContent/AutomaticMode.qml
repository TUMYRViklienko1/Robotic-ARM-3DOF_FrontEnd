import QtQuick 6.7
import QtQuick.Layouts
import QtQml
import backEnd.com 1.0

Item {
    id:automaticMode
    property alias mDelay: delay


    GridLayout{
        columns: 4
        columnSpacing: 5
        rowSpacing: 5
        Text{
            Layout.column: 0
            Layout.columnSpan: 3
            Layout.row: 0


            text: "Auto mode:"
            color: "white"
            font.pixelSize: 32
        }

        Text{
            Layout.column: 0
            Layout.row: 1


            text: "Delay"
            color: "white"
            font.pixelSize: 14
        }

        InverseTextInput {
            id:delay

            Layout.column: 0
            Layout.row: 2

            recColor: "white"
        }


        MyButton {
            id: autoModeStartButton

            Layout.column: 2
            Layout.row: 2

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

            Layout.column: 3
            Layout.row: 2

            title: "Stop"
            // backgroundDefultColor: "#e74c3c"
            onPressed: autoModeIsRunning = !autoModeIsRunning
        }

        Text{

            Layout.column: 0
            Layout.columnSpan: 3
            Layout.row: 3

            text: "Recorded orders:"
            color: "white"
            font.pixelSize: 20
        }

        ListView {
            id: angleFromListView

            Layout.column: 0
            Layout.columnSpan: 4
            Layout.row: 4
            Layout.preferredWidth: 300
            Layout.preferredHeight: 200



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
