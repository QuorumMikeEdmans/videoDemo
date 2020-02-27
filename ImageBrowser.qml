import QtQuick 2.9
import QtQuick.Window 2.2
import quorum.imageFileList 1.0

Item {
    id: imageBrowser
    visible: true
    anchors.fill: parent
    property string selectedDate
    property string selectedTime

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
        height: 400

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
}
