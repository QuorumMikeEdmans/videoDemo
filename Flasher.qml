import QtQuick 2.0

Rectangle{
    id: flasher
    property bool flash: true
    width:16
    height:width
    radius:width/2
    visible: Stepper.rotating
    border.width: 1
    border.color: "dark grey"
    Rectangle
    {
        anchors.centerIn: parent
        width:parent.width-4
        height:width
        radius:width/2
        color: parent.flash ? "red":"#c0c0c0"
    }

}
