import QtQuick 2.11
import QtQuick.Controls 2.4

import com.mongodb 0.7

Item {

    id: item
    anchors.fill: parent

    property QBSON karar




    Rectangle {
        width: parent.width
        height: parent.height
        color: "#AA000000"
        MouseArea{
            anchors.fill: parent
        }


        Rectangle {
            id: content
            width: parent.width > 1024 ? 1024 : parent.width
            height: parent.height
            color: "white"
            anchors.centerIn: parent

            Rectangle {

                width: parent.width
                height: 50
                color: "Gray"
                anchors.top: parent.top
                Text {
                    text: karar.getElement("Ay").String + " - "+ parseInt(karar.getElement("Yıl").Double) + " Kararları";
                    font.bold: true
                    font.pointSize: 10
                    font.family: "Tahoma"
                    color: "white"
                    anchors.centerIn: parent
                }
            }

            property int rWidth: width

            onWidthChanged: {

                var inc = 200;

                if( width <= 300 )
                {
                    rWidth = width
                }

                if( width > 300 && width < 500 )
                {
                    rWidth = width/2
                }
                if( width > 500 && width < 700 )
                {
                    rWidth = width/3
                }
                if( width > 700 && width < 900 )
                {
                    rWidth = width/4
                }
                if( width > 900 && width < 1100 )
                {
                    rWidth = width/5
                }
                if( width > 1100 )
                {
                    rWidth = width/6
                }

            }


            ScrollView{
                anchors.fill: parent
                anchors.topMargin: 50
                anchors.bottomMargin: 50
                clip: true

                Flow{
                    width: content.width


                    Repeater{
                        model: karar.getElement("kararlar").Array.count

                        Rectangle {
                            width: content.rWidth
                            height: 100
                            color: "transparent"
                            Rectangle {
                                width: parent.width-5
                                height: parent.height-5
                                color: "steelblue"
                                anchors.centerIn: parent
                                property var oid: karar.getElement("kararlar").Array.getElement(index).Oid
                                Text {
                                    text: "Karar " + index
                                    font.bold: true
                                    font.pointSize: 10
                                    font.family: "Tahoma"
                                    color: "white"
                                    anchors.centerIn: parent
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        var url = db.fileurl(parent.oid);
                                        Qt.openUrlExternally(url);
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
                color: "Gray"
                anchors.bottom: parent.bottom
                Text {
                    text: "Kapat";
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
