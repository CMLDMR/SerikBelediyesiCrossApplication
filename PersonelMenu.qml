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
//        print ("Personel Menu Width: " + width );
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
            color: "#CC2299CC"
            anchors.centerIn: parent

            Flow {
                anchors.fill: parent
                anchors.margins: 4
                spacing: 10
                anchors.topMargin: 30
                anchors.bottomMargin: 50

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
                        text: qsTr("Personel Yönetimi")
                        font.bold: true
                        font.pointSize: 10
                        font.family: "Tahoma"
                        color: "white"
                        anchors.centerIn: parent
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            loadPersonelYonetimPaneli();
                        }
                    }
                }

//                Rectangle {
//                    width: 150
//                    height: 50
//                    color: "black"
//                    Text {
//                        text: qsTr("Basında Biz")
//                        font.bold: true
//                        font.pointSize: 10
//                        font.family: "Tahoma"
//                        color: "white"
//                        anchors.centerIn: parent
//                    }
//                }

//                Rectangle {
//                    width: 150
//                    height: 50
//                    color: "black"
//                    Text {
//                        text: qsTr("Basında Biz")
//                        font.bold: true
//                        font.pointSize: 10
//                        font.family: "Tahoma"
//                        color: "white"
//                        anchors.centerIn: parent
//                    }
//                }

//                Rectangle {
//                    width: 150
//                    height: 50
//                    color: "black"
//                    Text {
//                        text: qsTr("Basında Biz")
//                        font.bold: true
//                        font.pointSize: 10
//                        font.family: "Tahoma"
//                        color: "white"
//                        anchors.centerIn: parent
//                    }
//                }
            }

            Rectangle {
                width: parent.width
                height: 50
                color: "crimson"
                anchors.bottom: parent.bottom
                Text {
                    text: qsTr("Kapat")
                    font.bold: true
                    font.pointSize: 10
                    font.family: "Tahoma"
                    color: "white"
                    anchors.centerIn: parent
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        item.destroy();
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


    function loadPersonelYonetimPaneli(){

        if( Personel.checkYetki("Admin") )
        {
            var com = Qt.createComponent("qrc:/Personel/PersonelYonetim.qml");

            if( com.status === Component.Ready )
            {

                var e = com.createObject(item);

                if( e === null )
                {
                    print ("Error: Load PersonelYonetim.qml");
                }

            }
        }else{
            Utility.information = "Bu Alana Giriş Yetkiniz Bulunmamaktadır";
        }




    }



}
