import QtQuick 2.11
import QtQuick.Controls 2.4

import com.mongodb 0.7

Item {

    id: item

    anchors.fill: parent


    Rectangle {
        width: parent.width
        height: parent.height
        color: "#CC000000"



        Rectangle {
            width: parent.width > 1024 ? 1024 : parent.width
            height: parent.height
            color: "white"
            anchors.centerIn: parent


            Rectangle {
                width: parent.width
                height: 50
                color: "white"
                anchors.top: parent.top
                anchors.topMargin: 10
                Text {
                    text: qsTr("Basında Biz Yönetim Paneli")
                    font.bold: true
                    font.pointSize: 10
                    font.family: "Tahoma"
                    color: "black"
                    anchors.centerIn: parent
                }
            }

            ScrollView{
                anchors.fill: parent
                anchors.topMargin: 60
                anchors.bottomMargin: 100
                id: scroll
                clip: true

                Column{
                    anchors.fill: parent
                    spacing: 5

                    Repeater{
                        id: repeater
//                        model: 15

                        Rectangle {
                            width: scroll.width
                            height: 50
                            color: "gray"
                            border.width: 1
                            border.color: "black"
                            Text {
                                text: qsTr(modelData.getElement("gazete").String)
                                font.bold: true
                                font.pointSize: 10
                                font.family: "Tahoma"
                                color: "white"
                                anchors.centerIn: parent
                            }


                        }

                        Component.onCompleted: {
                            loadbaskilar();
                        }

                    }

                }
            }

            Rectangle {
                width: parent.width
                height: 50
                color: "Black"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 50
                Text {
                    text: qsTr("Yeni Ekle+")
                    font.bold: true
                    font.pointSize: 10
                    font.family: "Tahoma"
                    color: "white"
                    anchors.centerIn: parent
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        var com = Qt.createComponent("qrc:/Basin/YeniEkle.qml");

                        if( com.status === Component.Ready )
                        {
                            var e = com.createObject(item);

                            e.inserted.connect(function(){

                                loadbaskilar();

                            });
                        }
                    }
                }
            }

            Rectangle {
                width: parent.width
                height: 50
                color: "Darkgray"
                anchors.bottom: parent.bottom
                Text {
                    text: qsTr("Kapat X")
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


    function loadbaskilar(){


        var sort = QBSON.newBSON();

        sort.addInt("_id",-1);

        var option = QBSON.newBSON();

        option.addBson("sort",sort);



        var list = db.find("basin",QBSON.newBSON() , option );


        repeater.model = list;


    }




}
