import QtQuick 2.0

Item {

    anchors.fill: parent
    id: resimfullscreen
    property string imgurl: ""

    Rectangle{
        anchors.fill: parent
        color: "#C0000000"
        MouseArea{
            anchors.fill: parent
        }

        Image {
            id: img
            source: imgurl
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
        }
        Rectangle{
            width: parent.width
            height: 50
            anchors.bottom: parent.bottom
            color: "steelblue"
            Text {
                id: closetext
                text: qsTr("Kapat")
                font.bold: true
                font.family: "Tahoma"
                font.pointSize: 10
                color: "white"
                anchors.centerIn: parent
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    resimfullscreen.destroy();
                }
            }
        }
    }

}
