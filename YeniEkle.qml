import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.3

import com.mongodb 0.7

Item {

    id: item

    anchors.fill: parent
    anchors.topMargin: 60

    signal inserted();


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

                Row{
                    anchors.fill: parent

                    Rectangle {
                        width: parent.width/5*4
                        height: parent.height
                        color: "white"
                        ComboBox{
                            id: gazeteCombo
                            anchors.fill: parent
                            model: ["Milliyet","EnSonHaber","Hürriyet","Sabah","Akşam","Posta"];

                            Component.onCompleted: {
                                loadGazeteler();
                            }
                        }
                    }
                    Rectangle {
                        width: parent.width/5
                        height: parent.height
                        color: "DarkGray"
                        Text {
                            text: qsTr("Gazete Ekle+")
                            font.bold: true
                            font.pointSize: 10
                            font.family: "Tahoma"
                            color: "white"
                            anchors.centerIn: parent
                            wrapMode: Text.WordWrap
                            width: parent.width
                            horizontalAlignment: Text.AlignHCenter
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                var com = Qt.createComponent("qrc:/Basin/GazeteEkle.qml");

                                if( com.status === Component.Ready )
                                {

                                    var e = com.createObject(item);

                                    e.inserted.connect(function(){
                                        loadGazeteler();
                                        e.destroy();
                                    });

                                }

                            }
                        }
                    }
                }
            }


            Rectangle {

                anchors.fill: parent
                color: "white"
                border.width: 1
                border.color: "black"
                anchors.topMargin: 50
                anchors.bottomMargin: 200


                Image {
                    id: img
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                }

                Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "red"
                    border.width: 5
                    Text {
                        text: qsTr("Resim Seç")
                        font.bold: true
                        font.pointSize: 10
                        font.family: "Tahoma"
                        color: "Gray"
                        anchors.centerIn: parent
                    }
                }



                FileDialog {
                    id: fileDialog
                    nameFilters: ["*.jpg *.jpeg *.png"]
                    onAccepted: {
                        img.source = fileUrl
                        close();
                    }
                    onRejected: {
                        close();
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        fileDialog.open();
                    }
                }

            }


            Rectangle {
                width: parent.width
                height: 200
                color: "#CC005588"
                anchors.bottom: parent.bottom

                Row{
                    anchors.fill: parent

                    Rectangle {
                        width: parent.width/2
                        height: parent.height
                        color: "white"
                        Calendar{
                            anchors.fill: parent
                            id: calender
                        }
                    }

                    Rectangle {
                        width: parent.width/2
                        height: parent.height
                        color: "transparent"
                        Column{
                            anchors.fill: parent

                            Rectangle {
                                width: parent.width
                                height: parent.height/2
                                color: "DarkSlateGray"
                                Text {
                                    text: qsTr("Kaydet")
                                    font.bold: true
                                    font.pointSize: 10
                                    font.family: "Tahoma"
                                    color: "white"
                                    anchors.centerIn: parent
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        saveBasin();
                                        item.destroy();
                                    }
                                }


                            }

                            Rectangle {
                                width: parent.width
                                height: parent.height/2
                                color: "Crimson"
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






                }
            }



        }

    }



    function loadGazeteler(){
        var list = db.find( "basinGazete",QBSON.newBSON(),QBSON.newBSON());
        var arlist = new Array;
        for( var i = 0 ; i < list.length ; i++ )
        {
            var obj = list[i];
            arlist.push(obj.getElement("gazeteAdi").String);
        }
        gazeteCombo.model = arlist;
    }




    function saveBasin(){

        var insertObj = QBSON.newBSON();

        insertObj.addString("gazete",gazeteCombo.currentText);

        insertObj.addInt64("julianDate",Utility.stringToJulianDay( calender.selectedDate.toDateString() ) );

        var fImg = db.uploadfromUrl( img.source,Utility.uniqueString());

        insertObj.addOid("baski",fImg.Oid);

        insertObj.print();

        if( db.insert_one("basin",insertObj) )
        {
            inserted();
        }else{
            print ("Yüklenemedi");
        }

    }

}
