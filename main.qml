import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls 1.4
import QtMultimedia 5.0
import quorum.stepper 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 800
    height: 480
    title: qsTr("Mike's Video")

    TabView
    {
        anchors.centerIn:parent
        width:800
        height: 480
        Tab{ title: "Manual Control";ManualControl{}}
        Tab{ title: "Image Browser";ImageBrowser{}}
        CycleWindow{}
        DemoTab{}
    }
}

