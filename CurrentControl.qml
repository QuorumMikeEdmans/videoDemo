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
        Column{
            spacing: 9
            topPadding: 20
            x:0
            ButtonGroup{id: currentGroup}

            RadioButton {
               id:button270mA
               text: "270mA"
               checked: true
               ButtonGroup.group: currentGroup
               onClicked: {Stepper.setStepperCurrent(0)}
               }
            RadioButton {
               id:button412mA
               text: "410mA"
               checked: false
               ButtonGroup.group: currentGroup
               onClicked: {Stepper.setStepperCurrent(1)}
               }
            RadioButton {
               id:button620mA
               text: "620mA"
               checked: false
               ButtonGroup.group: currentGroup
               onClicked: {Stepper.setStepperCurrent(2)}
               }
            RadioButton {
               id:button910mA
               text: "900mA"
               checked: false
               ButtonGroup.group: currentGroup
               onClicked: {Stepper.setStepperCurrent(3)}
               }
            RadioButton {
               id:button1500mA
               text: "1500mA"
               checked: false
               ButtonGroup.group: currentGroup
               onClicked: {Stepper.setStepperCurrent(4)}
               }
            RadioButton {
               id:button2200mA
               text: "2200mA"
               checked: false
               ButtonGroup.group: currentGroup
               onClicked: {Stepper.setStepperCurrent(5)}
               }
        }
    }
}


