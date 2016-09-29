/* Copyright (C) 2015, Jaguar Land Rover, IoT.bzh. All Rights Reserved.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import QtQuick 2.0
import QtQuick.Controls 1.2
import com.jlr.fmradio 1.0
import system 1.0

Item {
    id: radioApp
    width: 1080
    height: 1920

    property bool radioIsOn: true
    property int stationFreq: 0
    property string rdsInfo: ""
    property bool seeking: false
    property bool presetUsed: false

    function flipSwitch() {
        if (radioIsOn === false) {
            radio.disable();
        } else {
            radio.enable();
        }
    }

    FMRadio {
        id: radio

        onDisabled: {
            rdsText.text = "Radio Off"
            
        }
        onEnabled: {
            rdsText.text = "Radio On"
            
        }
        onFrequencyChanged: {
            rdsText.text = "Frequency Changed: " + frequency
            station.text = frequency / 1000000
            stationFreq = frequency
            
        }
        onRdsChanged: {
            rdsText.text = RdsString
            rdsInfo = RdsString
        }
        onRdsClear: {
            rdsText.text = "RDS Clear"
            rdsInfo = "No RDS"
        }
        onRdsComplete: {
            rdsText.text = RdsString
            rdsInfo = RdsString
        }
        onStationFound: {
            rdsText.text = "Frequency Changed: " + frequency
            station.text = frequency / 1000000
            stationFreq = frequency
            seeking = false
        }
    }

    Image {
        id: background
        anchors.verticalCenterOffset: 0
        anchors.horizontalCenterOffset: 0
        anchors.centerIn: parent
        source: "images/Hex-Background.jpg"
    }

    // Display Date

    Text {
        id: date
        color: "#ffffff"
        anchors.centerIn: parent
        text: Qt.formatDateTime(new Date(), "ddd" + " " + "MMM" + " " + "dd")
        font.bold: true
        font.pointSize: 22
        anchors.verticalCenterOffset: -860
        anchors.horizontalCenterOffset: -421
    }

    // Display Time

    Text {
        id: time
        color: "#ffffff"
        anchors.centerIn: parent
        text: Qt.formatDateTime(new Date(), "h:m ap")
        font.bold: true
        font.pointSize: 22
        anchors.verticalCenterOffset: -860
        anchors.horizontalCenterOffset: 445
    }

    // Display Radio Station

    Text {
        id: station
        color: "#ffffff"
        anchors.centerIn: parent
        text: qsTr("___._")
        font.family: "Courier"
        anchors.verticalCenterOffset: -573
        anchors.horizontalCenterOffset: 1
        font.bold: true
        font.pointSize: 102
    }

    // RDS Information from Station

    Rectangle {
        id: rdsContainer
        width: 400
        height: 150
        color: "#000000"
        x: 340
        y: 573

        Text {
            id: rdsText
            anchors.centerIn: parent
            color: "#ffffff"
            text: qsTr("Station Information")
            font.pointSize: 32
        }
    }

    // Off/On Button

    Image {
        id: switchButton
        x: 42
        y: 835
        anchors.centerIn: parent
        width: 140
        height: 140
        anchors.verticalCenterOffset: -70
        anchors.horizontalCenterOffset: 1
        anchors.topMargin: 18
        source: radioApp.radioIsOn ? "images/radio/stop.png" : "images/radio/play.png"

        MouseArea {
            x: 0
            y: 0
            height: 150
            anchors.fill: parent
            onClicked: {
                radioApp.radioIsOn ? radioApp.radioIsOn = false : radioApp.radioIsOn = true;
                flipSwitch();
            }
        }
    }

    // Seek Buttons

    Row {
        x: 50
        y: 700
        anchors.verticalCenterOffset: -70
        anchors.horizontalCenterOffset: 0
        anchors.centerIn: parent
        spacing: 200

        Image {
            id: seekDown
            source: "images/radio/seek-back.png"
            width: 120
            height: 120
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    radio.seek(false);
                    seeking = true;
                    presetUsed = false;
                }
            }
        }

        Image {
            id: seekUp
            source: "images/radio/seek-forward.png"
            width: 120
            height: 120
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    radio.seek(true);
                    seeking = true;
                    presetUsed = false;
                }
            }
        }
    }

    // Sound Visualization

    AnimatedImage {
        anchors.centerIn: parent
        id: visualization
        x: 290
        y: 880
        anchors.verticalCenterOffset: 171
        anchors.horizontalCenterOffset: 1
        scale: 3.5
        playing: radioApp.radioIsOn ? true : false
        source: "images/radio/soundbars.gif"
    }

    // Station Preset Buttons

    Row {
        anchors.verticalCenterOffset: 443
        anchors.horizontalCenterOffset: 1
        anchors.centerIn: parent
        spacing: 40

        Image {
            id: presetButton1
            source: "images/radio/preset.png"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    station.text = qsTr("101.9")
                    radio.setFrequency(101.9)
                    presetUsed = true
                }

                Text {
                    id: presetText1
                    anchors.centerIn: parent
                    color: "#ffffff"
                    text: qsTr("101.9")
                    font.bold: true
                    font.pixelSize: 28
                }
            }
        }

        Image {
            id: presetButton2
            source: "images/radio/preset.png"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    station.text = qsTr("94.7")
                    radio.setFrequency(94.7)
                    presetUsed = true
                }

                Text {
                    id: presetText2
                    anchors.centerIn: parent
                    color: "#ffffff"
                    text: qsTr("94.7")
                    font.bold: true
                    font.pixelSize: 28
                }
            }
        }

        Image {
            id: presetButton3
            source: "images/radio/preset.png"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    station.text = qsTr("91.5")
                    radio.setFrequency(91.5)
                    presetUsed = true
                }

                Text {
                    id: presetText3
                    anchors.centerIn: parent
                    color: "#ffffff"
                    text: qsTr("91.5")
                    font.bold: true
                    font.pixelSize: 28
                }
            }
        }
    }

    Row {
        anchors.verticalCenterOffset: 532
        anchors.horizontalCenterOffset: 1
        anchors.centerIn: parent
        spacing: 40

        Image {
            id: presetButton4
            source: "images/radio/preset.png"
            MouseArea {
                anchors.fill: parent
                onClicked: radio.setFrequency(101.9);

                Text {
                    id: presetText4
                    anchors.centerIn: parent
                    color: "#ffffff"
                    text: qsTr("")
                    font.bold: true
                    font.pixelSize: 28
                }
            }
        }

        Image {
            id: presetButton5
            source: "images/radio/preset.png"
            MouseArea {
                anchors.fill: parent
                onClicked: radio.setFrequency(94.7);

                Text {
                    id: presetText5
                    anchors.centerIn: parent
                    color: "#ffffff"
                    text: qsTr("")
                    font.bold: true
                    font.pixelSize: 28
                }
            }
        }

        Image {
            id: presetButton6
            source: "images/radio/preset.png"
            MouseArea {
                anchors.fill: parent
                onClicked: radio.setFrequency(91.5);

                Text {
                    id: presetText6
                    anchors.centerIn: parent
                    color: "#ffffff"
                    text: qsTr("")
                    font.bold: true
                    font.pixelSize: 28
                }
            }
        }
    }
}
