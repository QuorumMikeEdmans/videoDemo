import QtQuick 2.11
import QtQuick.Controls 2.4
import QtMultimedia 5.0

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Mike's Video")



    Camera {
       id: camera
       captureMode: Camera.CaptureVideo


       ///////////////////////////////////////////////////////////
       imageCapture {
           onImageCaptured: {
               photoPreview.source = preview
//               stillControls.previewAvailable = true
//               cameraUI.state = "PhotoPreview"
           }
       }

    }


    VideoOutput {
        source: camera
//        anchors.centerIn:  parent
        anchors.horizontalCenter: parent.horizontalcenter
        anchors.bottom: parent.bottom
        height: parent.height/2
        width: parent.width/2
        focus : visible


    }

    Rectangle {
        id: videoButton
        x: 481
        y: 85
        width: 100
        height: 40
        radius: 10
        color: "#808080"
        Text{
            anchors.centerIn: parent
            text:"Video"
        }
        MouseArea {
            anchors.fill: parent
            width: 163
            height: 47
            onClicked:
            {
                camera.captureMode=Camera.CaptureVideo
                camera.start()

            }
        } // to receive focus and capture key events when visible
    }


    Rectangle {
        id: stillButton
        x: 481
        y: 35
        width: 100
        height: 40
        radius: 10
        color: "#808080"
        Text{
            anchors.centerIn: parent
            text:"Still"
        }
        MouseArea {
            anchors.fill: parent
            width: 163
            height: 47
            onClicked:
            {
                camera.captureMode=Camera.CaptureStillImage
//                camera.imageCapture.capture()
                camera.imageCapture.captureToLocation("/home/pi/capturedImages")
            }
        } // to receive focus and capture key events when visible

    }
    PhotoPreview {
        id: photoPreview


    }

 }


