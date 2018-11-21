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
            color: "white"
            anchors.centerIn: parent

            Rectangle {
                width: parent.width
                height: 50
                color: "transparent"
                anchors.top: parent.top
                Text {
                    text: qsTr("Bilgilerim")
                    font.bold: true
                    font.pointSize: 10
                    font.family: "Tahoma"
                    color: "Gray"
                    anchors.centerIn: parent
                }
            }

            Rectangle {
                anchors.fill: parent
                border.color: "gray"
                border.width: 2
                radius: 3
                anchors.topMargin: 50
                anchors.bottomMargin: 50
                color: "white"

                Column{
                    anchors.fill: parent

                    Rectangle {
                        width: parent.width
                        height: 60
                        color: "transparent"
                        Column{
                            anchors.fill: parent
                            Rectangle {
                                width: parent.width
                                height: 30
                                color: "transparent"
                                Text {
                                    text: qsTr("Ad & Soyad")
                                    font.bold: true
                                    font.pointSize: 10
                                    font.family: "Tahoma"
                                    color: "gray"
                                    anchors.centerIn: parent
                                }
                            }

                            Rectangle {
                                width: parent.width
                                height: 30
                                color: "transparent"
                                Text {
                                    text: qsTr(User.nameSurname)
                                    font.bold: true
                                    font.pointSize: 10
                                    font.family: "Tahoma"
                                    color: "black"
                                    anchors.centerIn: parent
                                }
                            }


                            Rectangle {
                                width: parent.width
                                height: 2
                                color: "transparent"
                                Rectangle {
                                    width: parent.width-35
                                    height: 1
                                    color: "black"
                                    anchors.centerIn: parent
                                }
                            }



                        }
                    }

                    Rectangle {
                        width: parent.width
                        height: 60
                        color: "transparent"
                        Column{
                            anchors.fill: parent
                            Rectangle {
                                width: parent.width
                                height: 30
                                color: "transparent"
                                Text {
                                    text: qsTr("Cep Telefonu")
                                    font.bold: true
                                    font.pointSize: 10
                                    font.family: "Tahoma"
                                    color: "gray"
                                    anchors.centerIn: parent
                                }
                            }

                            Rectangle {
                                width: parent.width
                                height: 30
                                color: "transparent"
                                Text {
                                    text: qsTr(User.telefon)
                                    font.bold: true
                                    font.pointSize: 10
                                    font.family: "Tahoma"
                                    color: "black"
                                    anchors.centerIn: parent
                                }
                            }


                            Rectangle {
                                width: parent.width
                                height: 2
                                color: "transparent"
                                Rectangle {
                                    width: parent.width-35
                                    height: 1
                                    color: "black"
                                    anchors.centerIn: parent
                                }
                            }



                        }
                    }


                    Rectangle {
                        width: parent.width
                        height: 60
                        color: "transparent"
                        Column{
                            anchors.fill: parent
                            Rectangle {
                                width: parent.width
                                height: 30
                                color: "transparent"
                                Text {
                                    text: qsTr("Mahalle")
                                    font.bold: true
                                    font.pointSize: 10
                                    font.family: "Tahoma"
                                    color: "gray"
                                    anchors.centerIn: parent
                                }
                            }

                            Rectangle {
                                width: parent.width
                                height: 30
                                color: "transparent"
                                Text {
                                    text: qsTr(User.mahalle)
                                    font.bold: true
                                    font.pointSize: 10
                                    font.family: "Tahoma"
                                    color: "black"
                                    anchors.centerIn: parent
                                }
                            }


                            Rectangle {
                                width: parent.width
                                height: 2
                                color: "transparent"
                                Rectangle {
                                    width: parent.width-35
                                    height: 1
                                    color: "black"
                                    anchors.centerIn: parent
                                }
                            }



                        }
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


}
