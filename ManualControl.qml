import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2



//import QtQuick 2.11
//import QtQuick.Controls 2.4
//import QtQuick.Controls 1.4
//import QtQuick.Controls.Styles 1.4
import QtMultimedia 5.0
import quorum.stepper 1.0

Item{
    anchors.left:parent.left
    anchors.leftMargin: 40
    width: parent.width/2
    anchors. verticalCenter: parent.verticalCenter
    height: parent.height

    Column{
        spacing: 9
        topPadding: 20
        x:0


        CheckBox {
            id: checkEnableMotor
            text: qsTr("Enable Motor")
            onClicked: Stepper.driveEnabled = checked
            Component.onCompleted: checked = Stepper.driveEnabled
            Connections {
                target: Stepper
                onDriveEnabledChanged:
                {
                    checkEnableMotor.checked = Stepper.driveEnabled
                    console.log("stepper.driveEnabled",Stepper.driveEnabled)
                }
            }
        }

        Row{
            Text {
                id: element
                width: 160
                height: 13
                text: qsTr("Rotation / deg")
                font.pixelSize: 18
            }
            SpinBox {
                id: spinBox
                to: 720
                from: 0
                value:90
                onValueChanged: Stepper.rotationDegrees=value
            }
        }
        Row {
//             ExclusiveGroup { id: direction }
             RadioButton {
                 id:clockwiseButton
                 text: "Clockwise"
                 checked: true

                 onClicked: {anticlockwiseButton.checked=!checked}
//                 exclusiveGroup: direction
                 onCheckedChanged: {
                     Stepper.clockwise=checked
                 }
             }
             RadioButton {
                 id: anticlockwiseButton
                 text: "AntiClockwise"
                 checked:false
//                 exclusiveGroup: direction
             }
        }
        Row{
            spacing:30
            MyButton{
                id: rotateButton
                anchors.verticalCenter: parent.verticalCenter
                width: 100
                height: 40
                text: "Rotate"
                onClicked:{
                    Stepper.rotate();
                }
            }
            Flasher{
                visible: Stepper.rotating
                flash: Stepper.blinkOn
            }
        }
        MyButton{
            id: stopButton
            width: 100
            height: 40
            text: "Stop"
            onClicked:{
                Stepper.stop();
            }
        }
        MyButton{
            id: stepButton
            width: 100
            height: 40
            text: "Step"
            onClicked:{
                Stepper.step();
            }
        }


        Dial {
            id: dial
            width: 98
            height: 104
            from:20
            to:1
            onValueChanged: Stepper.interval_10ms=value
        }
        Text{
            text:"Speed"
            anchors.horizontalCenter: dial.horizontalCenter
        }
        Text{
            text:Stepper.speedDialText
            anchors.horizontalCenter: dial.horizontalCenter
        }

    }


}


