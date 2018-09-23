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
        anchors.fill: parent
        color: "red";


        Rectangle{
            color: "green"
            anchors.left: parent.left
            anchors.top: parent.top
            width : parent.width
            height : parent.width/4*3;
            Video {
                property bool playing: false
                id: video
                width: parent.width
                height: parent.height*480/720
                source: "http://serik.bel.tr/download/1.avi"
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if( video.playing )
                        {
                            video.stop();
                            video.playing = !video.playing;
                        }else{
                            video.play();
                            video.playing = !video.playing;
                        }
                    }
                }
                focus: true
                Keys.onSpacePressed: video.playbackState == MediaPlayer.PlayingState ? video.pause() : video.play()
                Keys.onLeftPressed: video.seek(video.position - 5000)
                Keys.onRightPressed: video.seek(video.position + 5000)
            }
        }
    }
}


