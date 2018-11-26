import QtQuick 2.11
import QtQuick.Controls 2.4

import com.mongodb 0.7

Item {

    id: item

    anchors.fill: parent


    Rectangle {

        width: parent.width
        height: parent.height
        color: "transparent"

        Rectangle {
            id: content
            width: parent.width > 1024 ? 1024 : parent.width
            height: parent.height
            color: "transparent"
            anchors.centerIn: parent

            property int rWidth: width
            onWidthChanged: {
                if( width <= 300 )
                {
                    rWidth = width
                }
                if( width > 300 && width < 500 )
                {
                    rWidth = width/2
                }
                if( width > 500 )
                {
                    rWidth = width/3
                }
            }

            ScrollView{
                anchors.fill: parent
                clip: true


                Flow{
                    width: content.width

                    Repeater{
                        model: db.find("Projeler",QBSON.newBSON(),QBSON.newBSON());

                        Rectangle {
                            width: content.rWidth
                            height: 75
                            color: "transparent"
                            Rectangle {
                                width: parent.width - 5
                                height: parent.height - 5
                                radius: 3
                                gradient: Gradient {
                                    GradientStop {
                                        position: 0.00;
                                        color: "#c6cecf";
                                    }
                                    GradientStop {
                                        position: 0.48;
                                        color: "#ffffff";
                                    }
                                    GradientStop {
                                        position: 1.00;
                                        color: "#d5d2d2";
                                    }
                                }
                                Text {
                                    text: modelData.getElement("Başlık").String
                                    font.bold: true
                                    font.pointSize: 10
                                    font.family: "Tahoma"
                                    color: "#7c7a7a"
                                    anchors.centerIn: parent
                                    width: parent.width
                                    wrapMode: Text.WordWrap
                                    horizontalAlignment: Text.AlignHCenter
                                }
                            }
                        }

                    }

                }
            }


        }

    }


}
