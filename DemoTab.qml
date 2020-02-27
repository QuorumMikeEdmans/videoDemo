import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls 1.4
import QtMultimedia 5.0
import quorum.stepper 1.0

Tab{
    title: "Video"
    id: videoTab
    anchors.fill:parent
    Item{
        anchors.fill:parent

        Camera {
           id: camera
           captureMode: Camera.CaptureVideo
           imageCapture {
               onImageCaptured: {
                   photoPreview.source = preview
               }
            }
        }

        VideoOutput {
        source: camera
        anchors.horizontalCenter: parent.horizontalcenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        height: parent.height/2-8
        width: parent.width/2
        focus : visible
    }
    PhotoPreview {
      id: photoPreview
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
                camera.captureMode=Camera.CaptureStillImage
                camera.imageCapture.captureToLocation("/home/pi/capturedImages")
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
            onClicked:
            {
                Stepper.moveStepper(false,10,500);
            }
        }
        Button{
            id: fast
            width: 100
            height: 40
            text: "Fast"
            onClicked:
            {
                Stepper.moveStepper(false,200,1);
            }
        }
    }

//        PhotoPreview {
//        id: photoPreview
//        }
    }
}
