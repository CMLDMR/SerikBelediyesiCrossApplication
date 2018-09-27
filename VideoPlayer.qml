import QtQuick 2.9
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtMultimedia 5.8

import com.mongodb 0.7


Item {

    id: videoplarid
    anchors.fill: parent

    Rectangle{
        id: videomainRect
        anchors.fill: parent
        color: "#80000000"

        property string oid: ""
        property string labeloid: ""




        Rectangle{
            id: videopage
            color: "#b3050505"
            anchors.top: parent.top
            width : parent.width > 1024 ? 1024 : parent.width
            height : parent.height;
            anchors.centerIn: parent


            Flow{
                anchors.fill: parent

                Rectangle{
                    id: videoplayingarea
                    width: videopage.width >= 950 ? 720 : videopage.width
                    height: parent.height*360/720
                    color: "black"


                    Rectangle{
                        id: loadingindicator
                        width: 0
                        height: 50
                        color: "orange"
                        Text {
                            text: qsTr("Yükleniyor...");
                            font.bold: true
                            font.family: "Tahoma"
                            font.pointSize: 12
                            color: "white"
                            width: parent.width
                            wrapMode: Text.WordWrap
                            visible: parent.width
                            anchors.centerIn: parent
                            horizontalAlignment: Text.AlignHCenter
                        }
                        anchors.centerIn: parent
                        z: 10
                        radius: 5
                    }

                    Video {
                        property bool nowplaying: false
                        id: video
                        anchors.fill: parent
                        source: "http://www.serik.bel.tr/download/antalya-serik-master_xvid.avi"
                        anchors.top: parent.top
                        fillMode: Image.PreserveAspectFit
                        Image {
                            id: videolabelid
                            source: "qrc:/img/img/videoWidgetPlay.png"
                            visible: !video.nowplaying
                            anchors.fill: parent
                            fillMode: Image.PreserveAspectCrop
                            Image {
                                id: videoplayimdid
                                source: "qrc:/img/img/videoWidgetPlay.png"
                                visible: !video.nowplaying
                                anchors.centerIn: parent

                            }
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if( video.nowplaying )
                                {
                                    video.stop();
                                    video.nowplaying = !video.nowplaying;
                                }else{
                                    video.play();
                                    video.nowplaying = !video.nowplaying;
                                }
                            }
                        }
                        focus: true
                        Keys.onSpacePressed: video.playbackState == MediaPlayer.PlayingState ? video.pause() : video.play()
                        Keys.onLeftPressed: video.seek(video.position - 5000)
                        Keys.onRightPressed: video.seek(video.position + 5000)

                        Rectangle{
                            width: parent.width
                            height: videoExplanText.height
                            color: "#80000000"
                            Text {
                                id: videoExplanText
                                anchors.centerIn: parent
                                width: parent.width
                                wrapMode: Text.WordWrap
                                horizontalAlignment: Text.AlignHCenter
                                font.bold: true
                                font.pointSize: 11
                                font.family: "Tahoma"
                                color: "white"
                            }
                            anchors.bottom: parent.bottom

                        }
                    }


                }



                Rectangle{
                    width: parent.width < 950 ? parent.width : 1024-720
                    height: videomainRect.height - videoplayingarea.height - 50
                    color: "#80000000"
                    id: videolistrect

                    ScrollView{
                        anchors.fill: parent
                        anchors.topMargin: 5
                        clip: true
                        Column{
                            anchors.fill: parent
                            spacing: 2
                            Repeater{
                                id: videolistrepeater
                                //                                model: 20
                                Rectangle{
                                    width: videolistrect.width
                                    height: 60
                                    color: "orange"

                                    Rectangle{
                                        width: 100
                                        height: 60
                                        anchors.top: parent.top
                                        anchors.left: parent.left
                                        color: "black"
                                        Image {
                                            id: videoicon
                                            source: db.fileurl(modelData.getElement("VideoLabel").Oid);
                                            anchors.fill: parent
                                            fillMode: Image.PreserveAspectFit
                                        }
                                        Rectangle{
                                            anchors.top: parent.top
                                            anchors.left: videoicon.right
                                            width: videolistrect.width-videoicon.width
                                            height: parent.height
                                            color: "white"
                                            Text {
                                                id: videoTitle
                                                text: qsTr(modelData.getElement("Title").String)
                                                anchors.centerIn: parent
                                                font.bold: false
                                                verticalAlignment: Text.AlignVCenter
                                                horizontalAlignment: Text.AlignHCenter
                                                font.family: "Tahoma"
                                                font.pointSize: 10
                                                color: "orange"
                                                width: parent.width
                                                wrapMode: Text.WordWrap
                                            }
                                        }
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked: {
                                            video.stop();
                                            videomainRect.labeloid = modelData.getElement("VideoLabel").Oid;

                                            videolabelid.source = db.fileurl( videomainRect.labeloid );
                                            videomainRect.oid = modelData.getElement("avi").Oid;
                                            openloadingidicator.running = true;
                                            videoExplanText.text = modelData.getElement("Title").String;
                                        }
                                    }
                                }
                            }
                        }


                        Component.onCompleted: {

                            var filter = QBSON.newBSON();

                            var option = QBSON.newBSON();

                            var sort = QBSON.newBSON();

                            sort.addInt("_id",-1);
                            option.addBson("sort",sort);

                            var list = db.find("Videolar",filter,option);

                            videolistrepeater.model = list;

                            print( videolistrepeater.model.length );

                            videomainRect.resizevideoList();

                        }
                    }
                }




            }

            Rectangle{
                id: closePageButton
                width: videoplayingarea.width
                height: 50
                color: "orange"
                z: 20
                anchors.bottom: parent.bottom
//                    radius: 3
                Text {
                    text: qsTr("Ana Sayfa")
                    anchors.centerIn: parent
                    font.bold: true
                    color: "white"
                    font.family: "Tahoma"
                    font.pointSize: 11
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        videoplarid.destroy();
                    }
                }
            }


        }


        onWidthChanged: {
            resizevideoList();
        }

        onHeightChanged: {
            resizevideoList();
        }


        function resizevideoList(){
            print( "onVideo Width Changed");

            if( videomainRect.width > 950 )
            {
                videolistrect.height = videomainRect.height;
//                videolistrect.anchors.top = videomainRect.top;
            }else{
                videolistrect.height = videomainRect.height - videoplayingarea.height - 50;
//                videolistrect.anchors.top = closePageButton.bottom;
            }
        }


        PropertyAnimation{
            id: openloadingidicator
            target: loadingindicator
            property: "width"
            to: 250
            duration: 250
            onStopped: {
                video.source = db.fileurl( videomainRect.oid );
                closeloadingidicator.running = true
            }
        }

        PropertyAnimation{
            id: closeloadingidicator
            target: loadingindicator
            property: "width"
            to: 0
            duration: 250
            onStopped: {
                video.play();
                video.nowplaying = true;
            }
        }
    }
}


