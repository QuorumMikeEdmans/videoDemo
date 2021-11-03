
import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2
import QtMultimedia 5.0
import quorum.stepper 1.0


Item{
    property int spinBoxHeight: 40
    property int spinBoxTextHeight:24
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
        x:320

        Row{
            Text {
                width: 420
                height: 15
                wrapMode: Text.WordWrap
                text: Stepper.cycleStatusText
                font.pixelSize: 16
            }
            Flasher{
                visible: Stepper.rotating
                flash: Stepper.blinkOn
            }
        }

        Row{
            Text {
                width: 160
                height: spinBoxHeight
                text: qsTr("Rotation / deg")
                font.pixelSize: 18
            }
            SpinBox {
                editable:true
                font.pixelSize: spinBoxTextHeight
                height: spinBoxHeight
                from:0
                to:360
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
                editable:true
                height: spinBoxHeight
                font.pixelSize: spinBoxTextHeight
                from: 0
                to:180
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
                height: spinBoxHeight
                font.pixelSize: spinBoxTextHeight
                enabled:!Stepper.infiniteCycle
                editable:true
                from: 1
                to: 10000
                value:1000
                stepSize: 10
                onValueChanged: {
                    Stepper.numberCycles=value
                    if (value<10)
                        stepSize=1;
                    else
                        if (value<100)
                            stepSize=10
                    else stepSize=100
                }
            }
        }
        Row{
        spacing:20
        Dial {
            id: dial
            width: 65
            height: 65
            from:30
            to:6
            onValueChanged: Stepper.cycleInterval_ms=value
        }
        MyButton{
            anchors.verticalCenter: parent.verticalCenter
            width: 100
            height: 40
            text: "Start"
            onClicked:
            {
                Stepper.startCycle()
            }
        }
        MyButton{
            anchors.verticalCenter: parent.verticalCenter
            width: 100
            height: 40
            text: "Stop"

            onClicked:
            {
                Stepper.stopCycle()
            }
        }
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
    }

}
