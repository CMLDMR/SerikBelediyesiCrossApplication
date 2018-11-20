import QtQuick 2.11
import QtQuick.Controls 2.4

import com.mongodb 0.7

Item {

    id: item
    anchors.fill: parent

    property QBSON person

    anchors.topMargin: 10

    property int w: width

    onWidthChanged: {

        if( width > 1024 )
        {
            w = 1024;
        }else{
            w = width;
        }



        if( width > 512 )
        {
            anchors.topMargin = 25
        }else{
            anchors.topMargin = 10
        }
    }


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

            ScrollView{
                id: scroller
                width: w
                height: parent.height
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                clip: true
                anchors.bottomMargin: 100

                Flow{
                    width: w
                    height: parent.contentHeight

                    Rectangle {
                        id: fotorect
                        width: 120
                        height: 140
                        color: "white"
                        radius: 3
                        clip: true
                        Rectangle {
                            width: 105
                            height: 130
                            color: "transparent"
                            Image {
                                id: personelimg
                                source: db.fileurl(person.getElement("fotooid").Oid);
                                anchors.fill: parent
                                fillMode: Image.PreserveAspectFit
                            }
                            anchors.centerIn: parent
                        }
                    }

                    Rectangle {
                        width: w - fotorect.width
                        height: fotorect.height
                        color: "steelblue"

                        Column{
                            anchors.fill: parent
                            Rectangle {
                                width: parent.width
                                height: 20
                                color: "transparent"
                                Text {
                                    text: qsTr(person.getElement("ad soyad").String)
                                    font.bold: true
                                    font.pointSize: 10
                                    font.family: "Tahoma"
                                    color: "white"
                                    anchors.centerIn: parent
                                    width: parent.width
                                    wrapMode: Text.WordWrap
                                }
                            }
                            Rectangle {
                                width: parent.width
                                height: 20
                                color: "transparent"
                                Text {
                                    text: qsTr(person.getElement("Birimi").String)
                                    font.bold: true
                                    font.pointSize: 10
                                    font.family: "Tahoma"
                                    color: "white"
                                    anchors.centerIn: parent
                                    width: parent.width
                                    wrapMode: Text.WordWrap
                                }
                            }
                            Rectangle {
                                width: parent.width
                                height: 20
                                color: "transparent"
                                Text {
                                    text: qsTr(person.getElement("Statü").String)
                                    font.bold: true
                                    font.pointSize: 10
                                    font.family: "Tahoma"
                                    color: "white"
                                    anchors.centerIn: parent
                                    width: parent.width
                                    wrapMode: Text.WordWrap
                                }
                            }
                            Rectangle {
                                width: parent.width
                                height: 20
                                color: "transparent"
                                Text {
                                    text: qsTr(person.getElement("telefon").String)
                                    font.bold: true
                                    font.pointSize: 10
                                    font.family: "Tahoma"
                                    color: "white"
                                    anchors.centerIn: parent
                                    width: parent.width
                                    wrapMode: Text.WordWrap
                                }
                            }
                        }
                    }


                    Rectangle {
                        width: w
                        height: 550
                        color: "white"

                        Column{
                            anchors.fill: parent

                            Rectangle {
                                width: parent.width
                                height: 50
                                color: "white"
                                clip: true
                                Row{
                                    anchors.fill: parent

                                    ComboBox{
                                        id: yetkilistesi
                                        width: parent.width/2
                                        height: parent.height
                                        font.bold: true
                                        font.pointSize: 12
                                        font.family: "Tahoma"
                                        Component.onCompleted: {

                                            var _list = db.find("PersonelYetki",QBSON.newBSON(),QBSON.newBSON());

                                            var list = new Array;

                                            for( var i = 0 ; i < _list.length ; i++ )
                                            {
                                                list[i] = _list[i].getElement("Yetki").String
                                            }

                                            model = list;


                                        }
                                    }
                                    Rectangle {
                                        width: parent.width/2
                                        height: parent.height
                                        color: "transparent"
                                        Text {
                                            id: ekleText
                                            text: qsTr("Ekle+")
                                            font.bold: true
                                            font.pointSize: 15
                                            font.family: "Tahoma"
                                            color: "Gray"
                                            anchors.centerIn: parent
                                        }
                                        MouseArea{
                                            anchors.fill: parent
                                            onPressed: {
                                                parent.color = "black";
                                            }
                                            onReleased: {
                                                parent.color = "transparent"
                                                addYetki(yetkilistesi.currentText);
                                            }
                                            onExited: {
                                                parent.color = "transparent"
                                            }
                                        }
                                    }


                                }
                            }


                            Rectangle {
                                width: w
                                height: 550
                                color: "transparent"

                                Rectangle {
                                    width: parent.width
                                    anchors.top: parent.top
                                    height: 50
                                    color: "Gray"
                                    Text {
                                        text: qsTr("Sahip Olduğu Yetkiler")
                                        font.bold: true
                                        font.pointSize: 10
                                        font.family: "Tahoma"
                                        color: "white"
                                        anchors.centerIn: parent
                                    }
                                }
                                Rectangle {
                                    id: yetkiRect
                                    anchors.fill: parent
                                    anchors.topMargin: 50
                                    color: "DarkGray"


                                    ScrollView{
                                        anchors.fill: parent
                                        clip: true

                                        Column{
                                            anchors.fill: parent
                                            spacing: 2

                                            Repeater{
                                                id: yetkirepeater
                                                model: 10
                                                Rectangle {
                                                    width: yetkiRect.width
                                                    height: 50
                                                    color: "DarkSlateGray"
                                                    Row{
                                                        anchors.fill: parent

                                                        Rectangle {
                                                            width: parent.width - 50
                                                            height: parent.height
                                                            color: "transparent"
                                                            Text {
                                                                text: modelData
                                                                font.bold: true
                                                                font.pointSize: 10
                                                                font.family: "Tahoma"
                                                                color: "white"
                                                                anchors.centerIn: parent
                                                            }
                                                        }

                                                        Rectangle {
                                                            width: 50
                                                            height: parent.height
                                                            color: "#CC000000"
                                                            Text {
                                                                text: qsTr("X")
                                                                font.bold: true
                                                                font.pointSize: 12
                                                                font.family: "Tahoma"
                                                                color: "white"
                                                                anchors.centerIn: parent
                                                            }

                                                            MouseArea{
                                                                anchors.fill: parent
                                                                onClicked: {
                                                                    deleteYetki(modelData);
                                                                }
                                                            }


                                                        }


                                                    }


                                                }

                                                Component.onCompleted: {
                                                    loadYetkiler();
                                                }
                                            }
                                        }
                                    }


                                }
                            }
                        }
                    }
                }
            }


            Rectangle {
                width: parent.width
                height: 50
                color: "DarkSlateBlue"
                Text {
                    text: qsTr("Kaydet")
                    font.bold: true
                    font.pointSize: 10
                    font.family: "Tahoma"
                    color: "white"
                    anchors.centerIn: parent
                }
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 50
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        item.destroy();
                    }
                }

            }


            Rectangle {
                width: parent.width
                height: 50
                color: "orange"
                Text {
                    text: qsTr("Kapat")
                    font.bold: true
                    font.pointSize: 10
                    font.family: "Tahoma"
                    color: "white"
                    anchors.centerIn: parent
                }
                anchors.bottom: parent.bottom
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        item.destroy();
                    }
                }

            }

        }

    }




    function loadYetkiler(){


        var filter = QBSON.newBSON();

        filter.addOid("_id",person.getElement("_id").Oid);

        person = db.find_one("Personel",filter,QBSON.newBSON());



        var yetkiList = new Array;

        var yetki = person.getElement("Yetkiler").Array;

        for( var i = 0 ; i < yetki.count ; i++ )
        {
            yetkiList[i] = yetki.getElement(i).String;
        }

        yetkirepeater.model = yetkiList;
    }



    function addYetki(yetkiname)
    {


        var existYetki = person.getElement("Yetkiler").Array;

        var exist = false;


        for( var i = 0 ; i < existYetki.count ; i++ )
        {

            if( yetkiname === existYetki.getElement(i).String )
            {
                exist = true;
                break;
            }

        }



        if( exist ) return;




        var filter = QBSON.newBSON();

        filter.addOid("_id",person.getElement("_id").Oid);

        var pushObj = QBSON.newBSON();

        pushObj.addString("Yetkiler",yetkiname);

        var push = QBSON.newBSON();

        push.addBson("$push",pushObj);


        if( db.update_one("Personel",filter,push) )
        {
            loadYetkiler();
        }else{
            print ("no update yetki");
        }
    }


    function deleteYetki(yetkiname)
    {


        print ( "modelData: " + yetkiname );


        var filter = QBSON.newBSON();

        filter.addOid("_id",person.getElement("_id").Oid);


        var pull = QBSON.newBSON();

        var pullObj = QBSON.newBSON();

        pullObj.addString("Yetkiler",yetkiname);

        pull.addBson("$pull",pullObj);

        filter.print();

        pull.print();

        if( db.update_one("Personel",filter,pull) )
        {
            print ("Updaated");
            loadYetkiler();
        }else{
            print ("Can Not Updated");
        }


    }



}
