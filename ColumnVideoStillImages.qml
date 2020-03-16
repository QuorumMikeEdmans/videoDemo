import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls 1.4
import QtMultimedia 5.0
import quorum.stepper 1.0
import quorum.imageFileList 1.0


Column{
        width:300
        spacing:20
        signal captureImage

        property int  imageWidth: 240
        property int  imageHeight: 200

        Timer{
            id:statusTimer
            running:true
            interval: 2000
            repeat: true
            onTriggered: {
                if (parent.visible)
                {
                    console.log(camera.cameraState)
                    console.log(camera.cameraStatus)
                    if (camera.cameraState==0)
                        camera.start()
                }
            }
        }
        Connections {
            target: Stepper
            onCaptureStillImage:
            {
                if (camera.cameraState==Camera.ActiveState)
                {
                    camera.captureMode=Camera.CaptureStillImage
                    camera.imageCapture.captureToLocation("/home/pi/capturedImages")
                    console.log("Capture Still image")
                }else
                    console.log("Camera not active")
            }
        }

//        onCaptureImage:
//        {
//            if (camera.cameraState==Camera.ActiveState)
//            {
//                camera.imageCapture.captureToLocation("/home/pi/capturedImages")
//                camera.captureMode=Camera.CaptureStillImage
//            }else
//                console.log("Camera not active")
//        }
        function stopCamera()
        {
            camera.stop()
            console.log("Stop Camera")
        }
        function startCamera()
        {
            camera.start()
            console.log("Start Camera")
        }

        Camera {
           id: camera
           captureMode: Camera.CaptureVideo
           imageCapture {
               onImageCaptured: {
                   stillWindow.source = preview
                   ImageFileList.addNewImage(camera.imageCapture.capturedImagePath, Stepper.rotationPosition)
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
//            source: "file://home/pi/capturedImages/IMG.jpg"

            fillMode: Image.PreserveAspectFit
            smooth: true
        }
}
