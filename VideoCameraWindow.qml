import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls 1.4
import QtMultimedia 5.0
import quorum.stepper 1.0


Item{

    Timer{
        id: startTimer
        running:false
        repeat: false
        onTriggered:
            if (parent.visible)
                camera.start()
    }
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

    onVisibleChanged: {
        if (visible)
        {
            startTimer.start(500)
            console.log("timer started")
        }
        else
        {
            console.log ("Stop camera")
            camera.stop()
        }
    }

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

        Camera {
           id: camera
           captureMode: Camera.CaptureVideo
           imageCapture {
            }
        }

        VideoOutput {
        source: camera
        anchors.fill:parent
        anchors.margins: 20
        focus : visible
    }

}
