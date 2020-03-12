import QtQuick 2.11
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import quorum.imageFileList 1.0

Item {
    id: imageBrowser
    visible: true
    anchors.fill: parent
    property string selectedDate:listView.model[listView.currentIndex].date
    property string selectedTime:listView.model[listView.currentIndex].time
    property bool displayWarningButton:false

    onVisibleChanged: {
        if (visible)
            ImageFileList.initialise()      // Load file
    }
    Timer {
        id: startTimer
        running:true
        repeat: true
        interval:3000
        onTriggered: if (parent.visible)
                         ImageFileList.initialise()
    }


    Image{
        id: thumbNail
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 20
        anchors.topMargin: 20
        width:350
        height:350
        source: listView.model[listView.currentIndex].imageUrl
    }
    Row{
        anchors.top: thumbNail.bottom
        anchors.horizontalCenter: thumbNail.horizontalCenter
        Text{
            width: 200
            height:20
            text: selectedDate
        }
        Text{
            width: 80
            height:20
            text: selectedTime
        }
    }
    ListView {
        id: listView
        x: 10
        y: 40
        width: 400
        height: 320

        delegate: Item {
            x: 5
            width: 400
            height: 30
            Rectangle {
                anchors.fill: parent
                color: "blue"
                visible: listView.currentIndex==index
            }

            MouseArea{
                anchors.fill: parent
                onClicked:
                {
                    listView.currentIndex=index
                }
            }

            Row {
                id: row1
                Text {
                    text: date
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                }
                Text {
                    text: time
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                }
                spacing: 10
            }
        }
        model: imageFileList

        Component.onCompleted: {
            ImageFileList.initialise()      // Load file
        }
    }
    Button{
        id:btnClearFiles
        x:30
        y:400
        text: "Delete image files"
        visible: !displayWarningButton
        onClicked: displayWarningButton=true;
    }
    Rectangle{
        width:400
        height:250
        radius: 5
        border.color: "black"
        color: "light gray"
        border.width: 3
        visible: displayWarningButton
        anchors.centerIn: parent
        Column
        {
            spacing:30
            topPadding: 40
            leftPadding: 40
            Text{
                width:120
                height:50
                text:"All image files will be deleted. Continue?"
            }

            Row{
                leftPadding: 50
                Button{
                    id:yesButton
                    text: "Yes"
                    onClicked: {
                        ImageFileList.deleteAllFiles()
                        displayWarningButton=false;
                    }
                }
                Button{
                    id:noButton
                    text: "No"
                    onClicked: displayWarningButton=false;
                }
            }
        }
    }
}
