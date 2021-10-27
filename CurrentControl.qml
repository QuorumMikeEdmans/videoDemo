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
    GroupBox
    {
        title: "Stepper Current"
        topPadding: 8
        Column{
            spacing: 2
            topPadding: 10
            x:0
            ButtonGroup{id: currentGroup}

            RadioButton {
               text: "140mA"
               checked: true
               ButtonGroup.group: currentGroup
               onClicked: {Stepper.setStepperCurrent(0)}
               }
            RadioButton {
               text: "163mA"
               checked: true
               ButtonGroup.group: currentGroup
               onClicked: {Stepper.setStepperCurrent(1)}
               }
            RadioButton {
               text: "188mA"
               checked: false
               ButtonGroup.group: currentGroup
               onClicked: {Stepper.setStepperCurrent(2)}
               }
            RadioButton {
               text: "208mA"
               checked: false
               ButtonGroup.group: currentGroup
               onClicked: {Stepper.setStepperCurrent(3)}
               }
            RadioButton {
               text: "228mA"
               checked: false
               ButtonGroup.group: currentGroup
               onClicked: {Stepper.setStepperCurrent(4)}
               }
            RadioButton {
               text: "238mA"
               checked: false
               ButtonGroup.group: currentGroup
               onClicked: {Stepper.setStepperCurrent(5)}
               }
            RadioButton {
               text: "270mA"
               checked: false
               ButtonGroup.group: currentGroup
               onClicked: {Stepper.setStepperCurrent(6)}
               }
            RadioButton {
               text: "412mA"
               checked: false
               ButtonGroup.group: currentGroup
               onClicked: {Stepper.setStepperCurrent(7)}
               }
            RadioButton {
               text: "620mA"
               checked: false
               ButtonGroup.group: currentGroup
               onClicked: {Stepper.setStepperCurrent(8)}
               }
        }
    }
}


