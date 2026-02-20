
import QtQuick 2.9
import QtQuick.Controls 2.2
import quorum.stepper 1.0

Item {
    id: root
    width: 520
    height: rowH

    property color backGroundColour: "#ffffff"

    property int index: 1
    property int value: 0        // <-- external init comes in here
    property int rowH: 22
    property int fontPx: 14

    signal valueChangedByUser(int value)

    function wrap360(v) {
        var r = v
//        var r = v % 360
//        return r < 0 ? r + 360 : r
        return r;
    }

    Timer{
        id: blinkTimer
        running:true
        repeat: true
        interval: 1000
        property bool flashON: true
        onTriggered:
        {
            if (Stepper.torqueTestRunning)
            {
                flashON=!flashON
                if (Stepper.torqueTestCycleCount ==index)       // Blink box
                {
                    if (flashON)
                        backGroundColour="#00ff00"
                    else
                        backGroundColour="#ffffff"
                }
                else if (Stepper.torqueTestCycleCount >index)
                {
                        backGroundColour="#00ff00"
                }
                else
                    backGroundColour="#ffffff"
            }
        }

    }


    function setValueWrapped(v) {
        var w = v
//        var w = wrap360(v)
        if (root.value !== w) root.value = w
    }

    function stepByDegrees(delta) {
        setValueWrapped(root.value + delta)
        root.valueChangedByUser(root.value)
    }

    // If C++/parent sets root.value, push it into the SpinBox
    onValueChanged: {
        var w = root.value
//        var w = wrap360(root.value)
        if (w !== root.value) root.value = w
        if (spin.value !== root.value) spin.value = root.value
    }

    Row {
        anchors.fill: parent
        spacing: 6

        Label {
            text: "Rotation " + root.index
            width: 120
            height: root.rowH
            font.pixelSize: root.fontPx
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        Button { text: "<<<"; width: 46; height: root.rowH; font.pixelSize: root.fontPx; padding: 0
            onClicked: root.stepByDegrees(-180)
        }
        Button { text: "<<";  width: 38; height: root.rowH; font.pixelSize: root.fontPx; padding: 0
            onClicked: root.stepByDegrees(-45)
        }

        SpinBox {
            id: spin
            from: -360; to: 360
            editable: true
            stepSize: 1
            background: Rectangle{
                color:backGroundColour
                radius: 5
            }

            width: 120
            height: root.rowH
            font.pixelSize: root.fontPx

            // initialize from root.value
            Component.onCompleted: spin.value = root.wrap360(root.value)

            // user edits -> update root.value
            onValueModified: {
                var w = root.wrap360(spin.value)
                if (w !== spin.value) spin.value = w
                if (root.value !== w) root.value = w
                root.valueChangedByUser(root.value)
            }

            textFromValue: function(v, locale) { return v + "°" }
            valueFromText: function(t, locale) {
                var s = t.replace(/[^\d-]/g, "")
                var n = parseInt(s, 10)
                if (isNaN(n)) n = 0
                return root.wrap360(n)
            }
        }

        Button { text: ">>";  width: 38; height: root.rowH; font.pixelSize: root.fontPx; padding: 0
            onClicked: root.stepByDegrees(+45)
        }
        Button { text: ">>>"; width: 46; height: root.rowH; font.pixelSize: root.fontPx; padding: 0
            onClicked: root.stepByDegrees(+180)
        }
    }
}


//import QtQuick 2.9
//import QtQuick.Controls 2.2

//Item {
//    id: root
//    width: 520
//    height: rowH

//    property int index: 1
//    property alias value: spin.value

//    property int rowH: 30
//    property int fontPx: 15

//    signal valueChangedByUser(int value)

//    function wrap360(v) {
//        var r = v % 360
//        return r < 0 ? r + 360 : r
//    }

//    function stepByDegrees(delta) {
//        spin.value = wrap360(spin.value + delta)
//        root.valueChangedByUser(spin.value)
//    }

//    Row {
//        id: row
//        anchors.fill: parent
//        spacing: 6

//        Label {
//            text: "Rotation " + root.index
//            width: 120
//            height: root.rowH
//            font.pixelSize: root.fontPx
//            verticalAlignment: Text.AlignVCenter
//            elide: Text.ElideRight
//        }

//        Button {
//            text: "<<<"
//            width: 46
//            height: root.rowH
//            font.pixelSize: root.fontPx
//            padding: 0
//            onClicked: root.stepByDegrees(-180)
//        }

//        Button {
//            text: "<<"
//            width: 38
//            height: root.rowH
//            font.pixelSize: root.fontPx
//            padding: 0
//            onClicked: root.stepByDegrees(-45)
//        }

//        SpinBox {
//            id: spin
//            from: 0
//            to: 359
//            editable: true
//            stepSize: 1

//            width: 120
//            height: root.rowH
//            font.pixelSize: root.fontPx

////            // Optional: make typed values wrap
////            onValueModified: {
////                spin.value = root.wrap360(spin.value)
////                root.valueChangedByUser(spin.value)
////            }
//            onValueModified: spin.value = root.wrap360(spin.value)

//            textFromValue: function(v, locale) { return v + "°" }
//            valueFromText: function(t, locale) {
//                var s = t.replace(/[^\d-]/g, "")
//                var n = parseInt(s, 10)
//                if (isNaN(n)) n = 0
//                return root.wrap360(n)
//            }
//        }

//        Button {
//            text: ">>"
//            width: 38
//            height: root.rowH
//            font.pixelSize: root.fontPx
//            padding: 0
//            onClicked: root.stepByDegrees(+45)
//        }

//        Button {
//            text: ">>>"
//            width: 46
//            height: root.rowH
//            font.pixelSize: root.fontPx
//            padding: 0
//            onClicked: root.stepByDegrees(+180)
//        }
//    }
//}

