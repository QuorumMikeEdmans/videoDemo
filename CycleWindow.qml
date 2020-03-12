import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls 1.4
import QtMultimedia 5.0
import quorum.stepper 1.0

Item{
    anchors.fill:parent
    Component.onCompleted: videoWindow.captureImage()



    Timer {
        id: startTimer
        running:false
        repeat: false
        onTriggered: if (parent.visible)
                         videoWindow.startCamera()
    }

    onVisibleChanged: {
        if (visible)
        {
            startTimer.start(500)
            console.log("timer started")
        }
        else
            videoWindow.stopCamera()
    }


    ColumnVideoStillImages
    {
        anchors.left:parent.left
        id: videoWindow
        anchors.leftMargin: 20
        anchors.topMargin: 20
    }
    Column{
        spacing: 10
        topPadding: 40
        x:481
            Text {
                width: 220
                height: 40
                wrapMode: Text.WordWrap
                text: Stepper.cycleStatusText
                font.pixelSize: 14
            }

        Row{
            Text {
                width: 160
                height: 13
                text: qsTr("Rotation / deg")
                font.pixelSize: 18
            }
            SpinBox {
                maximumValue: 360
                minimumValue: 0
                value:180
                stepSize: 5
                onValueChanged: Stepper.cycleRotationDegrees=value
            }
        }
        Row{
            Text {
                width: 160
                height: 13
                text: qsTr("Pause time")
                font.pixelSize: 18
            }
            SpinBox {
                maximumValue: 120
                minimumValue: 0
                value:20
                stepSize: 5
                onValueChanged: Stepper.pauseTimeSeconds=value
            }
        }
        CheckBox{
            text:"Infinite Cycle"
            checked:true
            onCheckedChanged: Stepper.infiniteCycle=checked
        }

        Row{
            Text {
                width: 160
                height: 13
                text: qsTr("Number cycles")
                font.pixelSize: 18
            }
            SpinBox {
                enabled:!Stepper.infiniteCycle
                maximumValue: 10000
                minimumValue: 1
                value:1000
                stepSize: 10
                onValueChanged: Stepper.numberCycles=value
            }
        }
        Dial {
            id: dial
            width: 98
            height: 104
            from:20
            to:1
            onValueChanged: Stepper.cycleInterval_10ms=value
        }
        Row{
            spacing:5
            anchors.horizontalCenter: dial.horizontalCenter
            Text{
                text:"Speed:"
            }
            Text{
                text:Stepper.cycleSpeedDialText
            }
        }
        Button{
            width: 100
            height: 40
            text: "Start"
            onClicked:
            {
                Stepper.startCycle()
            }
        }
        Button{
            width: 100
            height: 40
            text: "Stop"
            onClicked:
            {
                Stepper.stopCycle()
            }
        }

    }

}
