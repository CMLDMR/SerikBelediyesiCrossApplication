import QtQuick 2.9
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

import com.mongodb 0.7
//import Utility 0.7


Item {


    id: projectslideitem
    property string oid: ""
    anchors.fill: parent


    Rectangle{
        anchors.fill: parent
        color: "#805a5858"

        Rectangle{
            id: projectContentid
            width: 0
            height: parent.height
            color: "#AA000000"
            anchors.centerIn: parent

            Rectangle{
                id: titleRect
                width: parent.width
                height: 150
                Image {
                    id: titleimg
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    Rectangle{
                        color: "#90000000"
                        anchors.fill: parent

                        Column{
                            anchors.topMargin: 20
                            anchors.fill: parent


                            Text{
                                id: titletext
                                text: "Yükleniyor..."
                                width: titleRect.width
                                font.bold: true
                                font.pointSize: 11
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                color: "white"
                            }
                            Text{
                                id: durumtext
                                text: "Yükleniyor..."
                                width: titleRect.width
                                font.bold: true
                                font.pointSize: 11
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                color: "orange"
                            }
                        }


                    }

                }



            }


            ScrollView{
                anchors.fill: parent
                anchors.topMargin: titleRect.height
                anchors.bottomMargin:  backbutton.height

                Column{
                    anchors.fill: parent
                    spacing: 4

                    Repeater{
                        id: projeslideitem
                        property var elementlist

                        Rectangle{
                            width: projectContentid.width
                            height: projectContentid.width > 360 ? projectContentid.width*2/3 : 250
                            color: "transparent"
                            Image {
                                id: slideitemimg
                                source: db.fileurl(projeslideitem.elementlist.getElement(index).Bson.getElement("img").Oid);
                                anchors.fill: parent
                                fillMode: Image.PreserveAspectFit
                                width: parent.width
                                Rectangle{
                                    color: "transparent"
                                    Rectangle{
                                        gradient: Gradient {
                                            GradientStop {
                                                position: 0.35;
                                                color: "#00ffffff";
                                            }
                                            GradientStop {
                                                position: 1.00;
                                                color: "#FF000000";
                                            }
                                        }
                                        anchors.fill: parent
                                        anchors.topMargin: parent.height/2
                                    }
                                    anchors.fill: parent
                                    Text {
                                        text: projeslideitem.elementlist.getElement(index).Bson.getElement("text").String
                                        font.bold: true
                                        verticalAlignment: Text.AlignBottom
                                        horizontalAlignment: Text.AlignHCenter
                                        font.pointSize: 10
                                        color: "white"
                                        width: parent.width
                                        wrapMode: Text.WordWrap
                                        anchors.bottom: parent.bottom
                                        opacity: 1
                                    }
                                }
                            }

                        }
                    }

                }
            }

            Rectangle{
                id: backbutton
                width: parent.width
                height: 50
                anchors.bottom: parent.bottom
                color: "steelblue"
                Text {
                    text: qsTr("Geri")
                    font.bold: true
                    color: "white"
                    anchors.centerIn: parent
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        projectContentidclose.running = true
                    }
                }
            }


        }

    }


    Component.onCompleted: {

        projectContentidopen.running = true

        var filter = QBSON.newBSON();

        filter.addOid("_id",oid);

        var option = QBSON.newBSON();

        var item = db.find_one( "Projeler" , filter , option );

        titleimg.source = db.fileurl( item.getElement("icon").Oid );

        projeslideitem.elementlist = item.getElement("slide").Array;

        titletext.text = item.getElement("Başlık").String

        durumtext.text = item.getElement("durum").String

        projeslideitem.model = projeslideitem.elementlist.count;


    }


    PropertyAnimation{
        id: projectContentidopen
        target: projectContentid
        property: "width"
        from: 0
        to: parent.width > 900 ? 900 : parent.width
        duration: 250
    }

    PropertyAnimation{
        id: projectContentidclose
        target: projectContentid
        property: "width"
        to: 0
        duration: 250
        onStopped: {
            projectslideitem.destroy();
        }
    }
}
