import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls 1.4
import QtMultimedia 5.0
import quorum.stepper 1.0


Item{

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
