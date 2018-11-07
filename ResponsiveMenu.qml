import QtQuick 2.9
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3


Item {


    anchors.fill: parent
    id: responsiveitemid
    signal triggered();
//    z: 1

    Rectangle
    {
        id: responsivemenurect
        width: parent.width/2 > 200 ? 200 : parent.width/2
        height: 350
        x: 0
        y: -height
        color: "#AA115544"

        ScrollView{
            anchors.fill: parent

            Column{
                anchors.fill: parent
                property int w: responsivemenurect.width

//                Rectangle{
//                    width: parent.w;
//                    height: 50
//                    color: "transparent"
//                    Text{
//                        anchors.centerIn: parent
//                        text: "Meclis"
//                        color: "white"
//                        font.bold: true
//                        font.pointSize: 10
//                    }
//                }

                Rectangle{
                    width: parent.w;
                    height: 50
                    color: "transparent"
                    id: cekgonderbuttonid
                    Text{
                        anchors.centerIn: parent
                        text: "Çek Gönder"
                        color: "white"
                        font.bold: true
                        font.pointSize: 10
                        id: cekgondertextid
                    }

                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            responsiveitemid.triggered();
                            closeup();
                            loadCekGonder();
                        }

                        onPressed: {
                            cekgonderbuttonid.color = "white";
                            cekgondertextid.color = "black";
                        }
                        onReleased: {
                            cekgonderbuttonid.color = "transparent";
                            cekgondertextid.color = "white";
                        }
                    }
                }

                Rectangle{
                    width: parent.w;
                    height: 50
                    color: "#aa4682b4"
                    Text{
                        anchors.centerIn: parent
                        text: "Giriş"
                        color: "white"
                        font.bold: true
                        font.pointSize: 10
                    }
                    radius: 5

                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            var component = Qt.createComponent("qrc:/Personel/Giris.qml");

                            if( component.status === Component.Ready )
                            {
                                var girisitem = component.createObject( mainRectid );
                                if( girisitem === null )
                                {
                                    print( "Giris item Can Not Successfully" );
                                }else{
                                    print( "Giris Successfully" );
                                    closeup();
                                }
                            }else{
                                print( "Giris Component Can Not Ready" );
                            }
                        }
                    }
                }

//                Rectangle{
//                    width: parent.w;
//                    height: 50
//                    color: "orange"
//                    Text{
//                        anchors.centerIn: parent
//                        text: "Serik"
//                        color: "white"
//                        font.bold: true
//                        font.pointSize: 10
//                    }
//                    radius: 5
//                }

            }


        }

    }


    DropShadow {
        anchors.fill: responsivemenurect
        horizontalOffset: 0
        verticalOffset: 3
        radius: 8.0
        samples: 17
        color: "#80000000"
        source: responsivemenurect
        z: 2
    }


    PropertyAnimation{
        id: responsivemenurectopen
        target: responsivemenurect
        property: "y"
        to: 150
        duration: 250
    }

    PropertyAnimation{
        id: responsivemenurectclose
        target: responsivemenurect
        property: "y"
        to: -350
        duration: 250
    }


    function openup(){
        responsivemenurectopen.running = true;
    }

    function closeup(){
        responsivemenurectclose.running = true;
    }



    function loadCekGonder(){
        var component = Qt.createComponent("qrc:/Main/CekGonder.qml");
        if( component.status === Component.Ready )
        {
            var sprite = component.createObject( mainRectid );
            if (sprite === null) {
                // Error Handling
                console.log("CekGonder Error creating object");
            }else{
                console.log(" CekGonder Success init");
            }
        }else{
            print( "CekGonder.qml Component Not Ready");
        }
    }

}
