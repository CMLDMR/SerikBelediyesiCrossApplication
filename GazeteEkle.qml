import QtQuick 2.11
import QtQuick.Dialogs 1.3

import com.mongodb 0.7

Item {

    id: item
    anchors.fill: parent

    signal inserted();


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


            Rectangle {
                width: parent.width
                height: 200
                color: "white"
                anchors.centerIn: parent

                Column{
                    anchors.fill: parent

                    Rectangle {
                        width: parent.width
                        height: 50
                        color: "DeepPink"
                        Text {
                            text: qsTr("Gazete Ekle")
                            font.bold: true
                            font.pointSize: 10
                            font.family: "Tahoma"
                            color: "white"
                            anchors.centerIn: parent
                        }
                    }

                    Rectangle {
                        width: parent.width
                        height: 50
                        color: "BlueViolet "
                        Row{
                            anchors.fill: parent
                            Rectangle {
                                width: parent.width/5
                                height: parent.height
                                color: "CornflowerBlue"
                                Image {
                                    id: gazetelogo
                                    anchors.fill: parent
                                    fillMode: Image.PreserveAspectFit
                                }
                                Text {
                                    text: qsTr("Logo Seç")
                                    font.bold: true
                                    font.pointSize: 10
                                    font.family: "Tahoma"
                                    color: "white"
                                    horizontalAlignment: Text.AlignHCenter
                                    wrapMode: Text.WordWrap
                                    width: parent.width
                                    visible: !gazetelogo.source
                                }

                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        fileDialog.open();
                                    }
                                }

                                FileDialog {
                                    id: fileDialog
                                    nameFilters: ["*.jpg *.jpeg *.png"]
                                    onAccepted: {
                                        gazetelogo.source = fileUrl
                                        close();
                                    }
                                    onRejected: {
                                        close();
                                    }
                                }
                            }

                            Rectangle {
                                width: parent.width/5*4
                                height: parent.height
                                color: "Crimson "
                                TextInput{
                                    id: gazeteAdi
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    wrapMode: Text.WordWrap
                                    width: parent.width
                                    height: parent.height
                                    font.bold: true
                                    font.pointSize: 10
                                    font.family: "Tahoma"
                                    color: "white"

                                    Text {
                                        text: qsTr("Gazetenin Adını Giriniz")
                                        font.bold: true
                                        font.pointSize: 10
                                        font.family: "Tahoma"
                                        color: "#e6e1e1"
                                        horizontalAlignment: Text.AlignHCenter
                                        wrapMode: Text.WordWrap
                                        width: parent.width
                                        visible: !parent.text
                                        anchors.centerIn: parent
                                    }
                                }


                            }
                        }
                    }

                    Rectangle {
                        width: parent.width
                        height: 50
                        color: "DarkCyan"
                        Text {
                            text: qsTr("Kaydet")
                            font.bold: true
                            font.pointSize: 10
                            font.family: "Tahoma"
                            color: "white"
                            anchors.centerIn: parent
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {

                                saveGazeteLogo();
                            }
                        }
                    }

                    Rectangle {
                        width: parent.width
                        height: 50
                        color: "Black"
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


    function saveGazeteLogo(){

        print("Upload Filee: " + gazetelogo.source.toString());

        var fElement = db.uploadfromUrl(gazetelogo.source.toString(),gazeteAdi.text);

        var insertObj = QBSON.newBSON();

        insertObj.addOid( "iconOid" , fElement.Oid );

        insertObj.addString( "gazeteAdi", gazeteAdi.text );

        insertObj.print();

        if( db.insert_one( "basinGazete" , insertObj ) )
        {
            print ("insert Edildi");
            inserted();
        }else{
            print ("insert Edilemedi");


        }

//        db.uploadfile(gazetelogo.source.toString())

    }


}
