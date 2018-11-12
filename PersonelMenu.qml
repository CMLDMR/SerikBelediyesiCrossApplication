import QtQuick 2.11
import QtQuick.Controls 2.4

import com.mongodb 0.7


Item {

    id: item
    //    width: Utility.rootWidth
    //    height: Utility.rootHeight
    anchors.fill: parent

    anchors.topMargin: 60

    onWidthChanged: {
        print ("Personel Menu Width: " + width );
    }

    MouseArea{
        anchors.fill: parent
    }


    Rectangle {
        width: parent.width
        height: parent.height
        color: "#CC000000"

        Rectangle {

            width: parent.width > 1024 ? 750 : parent.width
            height: parent.height
            color: "orange"
            anchors.centerIn: parent

            Flow {
                anchors.fill: parent
                anchors.margins: 4
                spacing: 10
                anchors.topMargin: 30

                Rectangle {
                    width: 150
                    height: 50
                    color: "black"
                    Text {
                        text: qsTr("Basında Biz")
                        font.bold: true
                        font.pointSize: 10
                        font.family: "Tahoma"
                        color: "white"
                        anchors.centerIn: parent
                    }

                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            loadBasinPanel();
                        }
                    }
                }

                Rectangle {
                    width: 150
                    height: 50
                    color: "black"
                    Text {
                        text: qsTr("Basında Biz")
                        font.bold: true
                        font.pointSize: 10
                        font.family: "Tahoma"
                        color: "white"
                        anchors.centerIn: parent
                    }
                }

                Rectangle {
                    width: 150
                    height: 50
                    color: "black"
                    Text {
                        text: qsTr("Basında Biz")
                        font.bold: true
                        font.pointSize: 10
                        font.family: "Tahoma"
                        color: "white"
                        anchors.centerIn: parent
                    }
                }

                Rectangle {
                    width: 150
                    height: 50
                    color: "black"
                    Text {
                        text: qsTr("Basında Biz")
                        font.bold: true
                        font.pointSize: 10
                        font.family: "Tahoma"
                        color: "white"
                        anchors.centerIn: parent
                    }
                }

                Rectangle {
                    width: 150
                    height: 50
                    color: "black"
                    Text {
                        text: qsTr("Basında Biz")
                        font.bold: true
                        font.pointSize: 10
                        font.family: "Tahoma"
                        color: "white"
                        anchors.centerIn: parent
                    }
                }
            }
        }
    }




    function loadBasinPanel(){

        var com = Qt.createComponent("qrc:/Basin/BasindaBiz.qml");

        if( com.status === Component.Ready )
        {

            var e = com.createObject(item);

            if( e === null )
            {
                print ("Error: Can Not Load BasindaBiz Panel");
            }

        }

    }



}
