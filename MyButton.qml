import QtQuick 2.0

Rectangle {
    signal clicked
    signal buttonClicked
    property string text
    property int fontSizePixels: 14
    width: 60
    height: 25

    radius: 5
    border.width: 1
    border.color: "dark gray"

    color:"light gray"
    function buttonClick()
    { clicked()}

    Text {
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.fill: parent
        anchors.margins: 5
        text: parent.text
        font.pixelSize: fontSizePixels

    }

    MouseArea{
        anchors.fill: parent
        onClicked: buttonClick()
//        onClicked: buttonClicked()
    }


}
