
import QtQuick 2.9
import QtQuick.Controls 2.2
import quorum.stepper 1.0

Item {
    id: root
    width: 760
    height: mainRow.implicitHeight
    anchors.top:parent.top
    anchors.topMargin: 15

    property var rotationValues: [187, 140, 180, 90, 180, -194, -140, -180, -90, 180, 7]
//    property var rotationValues: [45,120,90,87,180,270,15,30,60,135,300]
    property int currentCycle: 0
    property bool running: false

    Row {
        id: mainRow
        spacing: 20

        // ===============================
        // LEFT SIDE: Rotation controls
        // ===============================
        Column {
            id: rotationsColumn
            anchors.topMargin: 30
            spacing: 15

            Repeater {
                model: 11

                RotationControl {
                    index: modelData + 1
                    rowH: 22
                    fontPx: 14

                    value: root.rotationValues[modelData]

                    onValueChangedByUser: {
                        root.rotationValues[modelData] = value
                    }
                }
            }
        }

        // ===============================
        // RIGHT SIDE: Cycle panel
        // ===============================
        Rectangle {
            id: cyclePanel
            width: 180
            color: "#f0f0f0"
            border.width: 1
            radius: 4
            anchors.top: rotationsColumn.top
            anchors.bottom: rotationsColumn.bottom

            Column {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 12

                Label {
                    text: "Cycle"
                    font.pixelSize: 16
                    font.bold: true
                }

                Rectangle {
                    width: parent.width
                    height: 50
                    border.width: 1
                    radius: 4
                    color: "white"

                    Label {
                        anchors.centerIn: parent
                        text: Stepper.torqueTestCycleCount+1
                        font.pixelSize: 24
                        font.bold: true
                    }
                }

                Button {
                    text: "Start"
                    onClicked: {
                        Stepper.startTorqueTest()
                    }
                }

                Button {
                    text: "Stop"
                    onClicked: {
                        Stepper.stopTorqueTest()
                }
            }
                Dial {
                    id: dial
                    width: 65
                    height: 65
                    from:30
                    to:6
                    onValueChanged: Stepper.cycleInterval_ms=value
                }
                Column{
                    spacing:5
                    anchors.left: dial.horizontalCenter
                    Text{
                        text:"Speed:"
                    }
                    Text{
                        text:Stepper.cycleSpeedDialText
                    }
                }


            }
    }

    // Simple demo timer for cycle increment
    Timer {
        id: cycleTimer
        interval: 1000
        repeat: true
        running: false
        onTriggered: root.currentCycle++
    }
}

}
