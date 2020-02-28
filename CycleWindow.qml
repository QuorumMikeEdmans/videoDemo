import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls 1.4
import QtMultimedia 5.0
import quorum.stepper 1.0

Item{
    anchors.fill:parent
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
    Button{
        id: stillButton
        width: 100
        height: 40
        text: "Still"
        onClicked:
        {
            videoWindow.captureImage()
        }
    }
    Button{
        id: videoButton
        width: 100
        height: 40
        text: "Video"
        onClicked:
        {
            camera.captureMode=Camera.CaptureVideo
            camera.start()
        }
    }
    Button{
        id: clockwise
        width: 100
        height: 40
        text: "Clockwise"
        onClicked:
        {
            Stepper.moveStepper(true,10,500);
        }
    }
    Button{
        id: anticlockwise
        width: 100
        height: 40
        text: "Anticlockwise"
        onClicked: {
            Stepper.moveStepper(false,10,500);
        }
    }
    Button{
        id: fast
        width: 100
        height: 40
        text: "Fast"
        onClicked:{
            Stepper.moveStepper(false,200,1);
        }
    }
    }
}
