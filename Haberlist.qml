import QtQuick 2.11
import QtQuick.Controls 2.4

import com.mongodb 0.7

Item {
    id: item

    anchors.fill: parent


    Rectangle {
        width: parent.width
        height: parent.height
        color: "#99000000"

        MouseArea{
            anchors.fill: parent
        }


        Rectangle {
            id: content
            width: parent.width > 1024 ? 1024 : parent.width
            height: parent.height
            color: "white"
            anchors.centerIn: parent

            property int rWidth: width

            onWidthChanged: {
                if( width <= 300 ){
                    rWidth = width;
                }
                if( width > 300 && width <= 500 )
                {
                    rWidth = width/2;
                }
                if( width > 500 && width <= 700 )
                {
                    rWidth = width/3;
                }
                if( width > 700 && width <= 900 )
                {
                    rWidth = width/4;
                }
                if( width >= 900 ){
                    rWidth = width/5;
                }
            }


            Rectangle {
                width: parent.width
                height: 50
                anchors.top: parent.top
                color: "Gray"
                Text {
                    text: qsTr("Haberler")
                    font.bold: true
                    font.pointSize: 10
                    font.family: "Tahoma"
                    color: "white"
                    anchors.centerIn: parent
                }
            }





            ScrollView{
                anchors.fill: parent
                anchors.topMargin: 55
                anchors.bottomMargin: 50
                clip: true

                Flow{
                    width: content.width


                    Repeater{
                        Component.onCompleted: {

                            var filter = QBSON.newBSON();

                            filter.addString("Yayında","Yayında");

                            var option = QBSON.newBSON();

                            option.addInt("limit",20);

                            var sort = QBSON.newBSON();

                            sort.addInt("_id",-1);

                            option.addBson("sort",sort);

                            model = db.find("Haberler",filter,option);

                        }


                        Rectangle {
                            width: content.rWidth
                            height: 250
                            color: "transparent"
                            Rectangle {
                                width: parent.width - 5
                                height: parent.height - 5
                                color: "white"
                                border.width: 1
                                border.color: "gray"
                                radius: 5
                                clip: true



                                Rectangle {
                                    anchors.fill: parent
                                    radius: 5



                                    anchors.top: parent.top
                                    anchors.topMargin: 20
                                    anchors.leftMargin: 20
                                    anchors.rightMargin: 20
                                    anchors.bottomMargin: 60

                                    Image {
                                        source: db.fileurl(modelData.getElement("icon").Oid);
                                        fillMode: Image.PreserveAspectCrop
                                        anchors.fill: parent

                                    }
                                    clip: true
                                }

                                gradient: Gradient {
                                    GradientStop {
                                        position: 0.00;
                                        color: "#e2dfdf";
                                    }
                                    GradientStop {
                                        position: 1.00;
                                        color: "#ffffff";
                                    }
                                }


                                Text {
                                    text: modelData.getElement("Başlık").String
                                    font.bold: false
                                    font.pointSize: 10
                                    font.family: "Tahoma"
                                    color: "Gray"
                                    anchors.bottom: parent.bottom
                                    width: parent.width
                                    wrapMode: Text.WordWrap
                                    horizontalAlignment: Text.AlignHCenter
                                }


                            }

                        }

                    }
                }
            }

            Rectangle {
                width: parent.width
                height: 50
                color: "Gray"
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



}
