import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls 1.4
import QtMultimedia 5.0
import quorum.stepper 1.0

Item{
    anchors.fill:parent
    VideoCameraWindow{
        width:400;height:400
        anchors.left: parent.left
        anchors.top:parent.top
    }

    Column{
        spacing: 10
        topPadding: 40
        x:481

        property bool clockwise: clockwiseButton.checked
        property int rotationDegrees: spinBox.value

        CheckBox {
            id: checkEnableMotor
            text: qsTr("Enable Motor")
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
            maximumValue: 360
            minimumValue: 0
            value:90
        }
    }
    Row {
         ExclusiveGroup { id: direction }
         RadioButton {
             id:clockwiseButton
             text: "Clockwise"
             checked: true
             exclusiveGroup: direction
         }
         RadioButton {
             text: "AntiClockwise"
             exclusiveGroup: direction
         }
    }

    Button{
        id: rotateButton
        width: 100
        height: 40
        text: "Rotate"
        onClicked:{
            Stepper.moveStepper(true,rotationDegrees,200);
        }
    }

    RoundButton {
        id: roundButton
        text: "Rotate"
    }

}

}


