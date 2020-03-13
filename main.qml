import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls 1.4
import QtMultimedia 5.0
import quorum.stepper 1.0
//import QtQuick.VirtualKeyboard 2.2

ApplicationWindow {
    id: window
    visible: true
    width: 800
    height: 480
    title: qsTr("Capn Ken's Stepper Controller")

    TabView
    {
        z:1
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        width:800
        VideoCameraWindow{
            width:400;height:400
            anchors.right: parent.right
            anchors.top:parent.top
            z:2         // Make sure this is shown on top of tab windows
            visible: manualControl.visible
//            onVisibleChanged: {
//                if (!visible)
//                {
//                    console.log("Stop Camera")
//                    stopCamera()
//                }else
//                {
//                    console.log("Start Camera")
//                    startCamera()
//                }

//            }
        }
        height: 480
        Tab{ id:manualControl;title: "Manual Control";ManualControl{}}
        Tab{ title: "Cycle";CycleWindow{}}
        Tab{ id:imageBrowser;title: "Image Browser";ImageBrowser{}}
    }
}

