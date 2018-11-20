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

        MouseArea{
            anchors.fill: parent
        }

        Rectangle {
            width: parent.width > 1024 ? 1024 : parent.width
            height: parent.height
            color: "transparent"
            anchors.centerIn: parent
            anchors.topMargin: 60

            Rectangle {
                width: parent.width
                height: 50
                color: "white"
                anchors.top: parent.top
                anchors.topMargin: 25
                Row{
                    anchors.fill: parent
                    Rectangle {
                        width: parent.width/4
                        height: parent.height
                        color: "white"
                        Text {
                            text: qsTr("Birim")
                            font.bold: true
                            font.pointSize: 10
                            font.family: "Tahoma"
                            color: "black"
                            anchors.centerIn: parent
                        }
                    }

                    Rectangle {
                        width: parent.width/4*3
                        height: parent.height
                        color: "white"
                        ComboBox{
                            id: birimComboBox
                            anchors.fill: parent
                            onCurrentTextChanged: {
                                loadPersonel();
                            }
                            Component.onCompleted: {
                                var list = db.find("Müdürlükler",QBSON.newBSON(),QBSON.newBSON());
                                var _model = new Array;
                                for( var i = 0 ; i < list.length ; i++ ){
                                    if( list[i].getElement("Haberleşme Kodu").String !== "-1" & list[i].getElement("Haberleşme Kodu").String !== "0" )
                                    {
                                        _model.push(list[i].getElement("Birim").String);
                                    }
                                }
                                model = _model;
                            }
                        }
                    }

                }
            }



            ScrollView{
                id: scroller
                anchors.fill: parent
                anchors.bottomMargin: 100
                anchors.topMargin: 75
                clip: true

                Flow{
                    id: flowid
                    width: parent.contentWidth
                    height: parent.contentHeight
                    spacing: 5
                    Repeater{
                        id: personelRepeater

                        Rectangle {
                            id: rItem
                            width: 330
                            height: 150
                            color: "orange"
                            radius: 3
                            clip: true
                            property QBSON person : modelData

                            Row{
                                anchors.fill: parent

                                Rectangle {
                                    id: fotorect
                                    width: 120
                                    height: 150
                                    color: "transparent"
                                    Rectangle {
                                        width: 105
                                        height: 130
                                        color: "white"
                                        radius: 3
                                        anchors.centerIn: parent
                                        clip: true
                                        Image {
                                            id: personelimg
//                                            source: db.fileurl(modelData.getElement("fotooid").Oid);
                                            source: db.fileurl(rItem.person.getElement("fotooid").Oid);
                                            anchors.fill: parent
                                            fillMode: Image.PreserveAspectFit
                                        }
                                    }

                                }

                                Rectangle {
                                    width: parent.width - fotorect.width
                                    height: 150
                                    color: "steelblue"
                                    radius: 3
                                    Column{
                                        anchors.fill: parent
                                        Rectangle {
                                            width: parent.width
                                            height: 25
                                            color: "transparent"
                                            Text {
                                                text: qsTr(person.getElement("ad soyad").String);
                                                font.bold: true
                                                font.pointSize: 10
                                                font.family: "Tahoma"
                                                color: "white"
                                                anchors.centerIn: parent
                                            }
                                        }
                                        Rectangle {
                                            width: parent.width
                                            height: 25
                                            color: "transparent"
                                            Text {
                                                text: qsTr(person.getElement("telefon").String);
                                                font.bold: true
                                                font.pointSize: 10
                                                font.family: "Tahoma"
                                                color: "white"
                                                anchors.centerIn: parent
                                            }
                                        }

                                        Rectangle {
                                            width: parent.width
                                            height: 25
                                            color: "transparent"
                                            Text {
                                                text: qsTr(person.getElement("Statü").String);
                                                font.bold: true
                                                font.pointSize: 10
                                                font.family: "Tahoma"
                                                color: "white"
                                                anchors.centerIn: parent
                                            }
                                        }

                                        Rectangle {
                                            width: parent.width
                                            height: 25
                                            color: "transparent"
                                            Text {
                                                text: qsTr(person.getElement("Birimi").String);
                                                font.bold: true
                                                font.pointSize: 10
                                                font.family: "Tahoma"
                                                color: "white"
                                                anchors.centerIn: parent
                                                width: parent.width
                                                wrapMode: Text.WordWrap
                                                horizontalAlignment: Text.AlignHCenter
                                            }
                                        }

                                    }
                                }

                            }


                            MouseArea {
                                anchors.fill: parent
                                onClicked: {

                                    loadPerson(parent.person);

                                }
                            }

                        }

                        Component.onCompleted: {
                            loadPersonel();
                        }

                    }
                }

                onWidthChanged: {
                    flowid.width = width;
                }


            }




            Rectangle {
                width: parent.width
                height: 50
                color: "FireBrick"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 50

                Text {
                    text: qsTr("Yeni Personel Ekle+")
                    font.bold: true
                    font.pointSize: 10
                    font.family: "Tahoma"
                    color: "white"
                    anchors.centerIn: parent
                }

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        print ("Yeni Personel Ekle+");
                    }
                }
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


    function loadPersonel(){

        var filter = QBSON.newBSON();

        filter.addString("Birimi",birimComboBox.currentText);

        personelRepeater.model = db.find( "Personel" , filter , QBSON.newBSON() );

    }




    function loadPerson(person)
    {
        var com = Qt.createComponent("qrc:/Personel/PersonDetail.qml");

        if( com.status === Component.Ready )
        {
            var e = com.createObject(item,{"person":person});

            if( e === null )
            {
                print ("object can not load");
            }
        }
    }

}
