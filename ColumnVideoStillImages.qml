import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls 1.4
import QtMultimedia 5.0
import quorum.stepper 1.0


Column{
        width:400
        spacing:20
        signal captureImage

        property int  imageWidth: 240
        property int  imageHeight: 200
        onCaptureImage:
        {
            camera.captureMode=Camera.CaptureStillImage
            camera.imageCapture.captureToLocation("/home/pi/capturedImages")
        }

        Camera {
           id: camera
           captureMode: Camera.CaptureVideo
           imageCapture {
               onImageCaptured: {
                   stillWindow.source = preview
               }
            }
        }


        VideoOutput {
        source: camera
        height: imageHeight
        width: imageWidth
        focus : visible
    }

        Image {
            id: stillWindow
            height: imageHeight
            width: imageWidth
            source: "file://home/pi/capturedImages/IMG.jpg"

            fillMode: Image.PreserveAspectFit
            smooth: true
        }
}
