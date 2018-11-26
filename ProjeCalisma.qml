import QtQuick 2.11
import QtQuick.Controls 2.4

import com.mongodb 0.7

Item {

    id: item

    anchors.fill: parent

    Rectangle {
        width: parent.width
        height: parent.height
        color: "#AA000000"

        MouseArea{
            anchors.fill: parent
        }

        Rectangle {
            width: parent.width > 1024 ? 1024 : parent.width
            height: parent.height
            color: "white"
            anchors.centerIn: parent


            Rectangle {
                width: parent.width
                height: 50
                color: "Gray"
                anchors.top: parent.top
                Row{
                    anchors.fill: parent

                    Rectangle {
                        width: parent.width/2
                        height: parent.height
                        color: "transparent"
                        Text {
                            text: qsTr("Projeler")
                            font.bold: true
                            font.pointSize: 10
                            font.family: "Tahoma"
                            color: "white"
                            anchors.centerIn: parent
                        }
                    }

                    Rectangle {
                        width: parent.width/2
                        height: parent.height
                        color: "transparent"
                        Text {
                            text: qsTr("Çalışmalar")
                            font.bold: true
                            font.pointSize: 10
                            font.family: "Tahoma"
                            color: "white"
                            anchors.centerIn: parent
                        }
                    }

                }


            }


            Rectangle {
                anchors.fill: parent
                color: "transparent"
                anchors.topMargin: 50
                anchors.bottomMargin: 50
                Row{
                    anchors.fill: parent
                    Rectangle {
                        width: parent.width/2
                        height: parent.height
                        gradient: Gradient {
                            GradientStop {
                                position: 0.00;
                                color: "#e8f4f5";
                            }
                            GradientStop {
                                position: 0.50;
                                color: "#ffffff";
                            }
                            GradientStop {
                                position: 1.00;
                                color: "#daf1f1";
                            }
                        }

                        Projeler{

                        }


                    }
                    Rectangle {
                        width: parent.width/2
                        height: parent.height
                        gradient: Gradient {
                            GradientStop {
                                position: 0.00;
                                color: "#83b1bb";
                            }
                            GradientStop {
                                position: 0.52;
                                color: "#ffffff";
                            }
                            GradientStop {
                                position: 1.00;
                                color: "#97b2c0";
                            }
                        }
                        Calismalar{

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
