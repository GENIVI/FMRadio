/* Copyright (C) 2015, Jaguar Land Rover, IoT.bzh. All Rights Reserved.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Window 2.0
//import com.jlr.fmradio 1.0
//import system 1.0

Item {
    id: radioApp
    width: 1840
    height: 1080

    property bool radioIsOn: true
    property int stationFreq: 0
    property string rdsInfo: ""
    property bool seeking: false
    property bool presetUsed: false
    property real fmMin: 87.7
    property real fmMax: 107.9
    property real currentFM: 87.7



    //    FMRadio {
    //        id: radio

    //        onDisabled: {
    //            rdsText.text = "Radio Off"

    //        }
    //        onEnabled: {
    //            rdsText.text = "Radio On"

    //        }
    //        onFrequencyChanged: {
    //            rdsText.text = "Frequency Changed: " + frequency
    //            station.text = frequency / 1000000
    //            stationFreq = frequency

    //        }
    //        onRdsChanged: {
    //            rdsText.text = RdsString
    //            rdsInfo = RdsString
    //        }
    //        onRdsClear: {
    //            rdsText.text = "RDS Clear"
    //            rdsInfo = "No RDS"
    //        }
    //        onRdsComplete: {
    //            rdsText.text = RdsString
    //            rdsInfo = RdsString
    //        }
    //        onStationFound: {
    //            rdsText.text = "Frequency Changed: " + frequency
    //            station.text = frequency / 1000000
    //            stationFreq = frequency
    //            seeking = false
    //        }
    //    }


    Image {
        id: background
        anchors.fill: parent
        source: "images/Hex-Background.jpg"
    }

    Column{
        anchors.rightMargin: 100
        anchors.bottomMargin: 100
        anchors.leftMargin: 100
        anchors.topMargin: 100
        anchors.fill: radioApp
        anchors.margins: 100
        spacing: 40

        Row{
            id: datetimeRow
            anchors.left: parent.left
            anchors.right: parent.right

            spacing: width - (date.width + time.width)
            // Display Date
            Text {
                id: date
                text: Qt.formatDateTime(new Date(), "ddd" + " " + "MMM" + " " + "dd")
                color: "#ffffff"
                font.bold: true
                font.pointSize: 22
                anchors.leftMargin: 0
            }

            // Display Time
            Text {
                id: time
                text: Qt.formatDateTime(new Date(), "h:mm ap")
                color: "#ffffff"
                font.bold: true
                font.pointSize: 22
                anchors.rightMargin: 0
            }
        }
        Row {
            height: parent.height - (parent.spacing + datetimeRow.height)
            width: parent.width
            spacing: 100

            // Sound Visualization
            AnimatedImage {
                id: visualization
                anchors.top: dataColumn.top
                anchors.bottom: dataColumn. bottom
                source: "images/radio/soundbars.gif"
                width: parent.width - (parent.spacing + dataColumn.width)
                playing: radioIsOn
            }


            Column {
                spacing: 40

                id: dataColumn

                // Display Radio Station
                Text {
                    id: station
                    text: radioIsOn? (currentFM).toFixed(1) : qsTr("___._")
                    color: "#ffffff"
                    font.family: "Courier"
                    font.bold: true
                    font.pointSize: 102
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                // RDS Information from Station
                Rectangle {
                    id: rdsContainer
                    width: 400
                    height: 150
                    color: "#000000"
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text {
                        id: rdsText
                        anchors.centerIn: parent
                        color: "#ffffff"
                        text: qsTr("Station Information")
                        font.pointSize: 32
                    }
                }

                // Off/On Button and /Seek Buttons

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 100

                    Image {
                        id: seekDown
                        source: "images/radio/seek-back.png"
                        width: 120
                        height: 120
                        anchors.verticalCenter: parent.verticalCenter
                        MouseArea {
                            enabled: radioIsOn
                            anchors.fill: parent
                            onClicked: {
                                (currentFM > fmMin)? currentFM -= 0.2 : currentFM = fmMax;
                            }
                        }
                    }


                    Image {
                        id: switchButton
                        width: 140
                        height: 140
                        source: radioApp.radioIsOn ? "images/radio/stop.png" : "images/radio/play.png"
                        anchors.verticalCenter: parent.verticalCenter
                        MouseArea {
                            height: 150
                            anchors.fill: parent
                            onClicked: {
                                radioIsOn = !radioIsOn
                            }
                        }
                    }
                    Image {
                        id: seekUp
                        source: "images/radio/seek-forward.png"
                        width: 120
                        height: 120
                        anchors.verticalCenter: parent.verticalCenter
                        MouseArea {
                            enabled: radioIsOn
                            anchors.fill: parent
                            onClicked: {
                                (currentFM < fmMax)? currentFM += 0.2 : currentFM = fmMin;
                            }
                        }
                    }
                }

                // Station Preset Buttons

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 40
                    Image {
                        id: presetButton1
                        source: "images/radio/preset.png"
                        height: sourceSize.height * 2
                        MouseArea {
                            enabled: radioIsOn
                            anchors.fill: parent
                            onClicked: {
                                currentFM = 101.9
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
                        height: sourceSize.height * 2
                        MouseArea {
                            enabled: radioIsOn
                            anchors.fill: parent
                            onClicked: {
                                currentFM = 94.7
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
                        height: sourceSize.height * 2
                        MouseArea {
                            enabled: radioIsOn
                            anchors.fill: parent
                            onClicked: {
                                currentFM = 91.5
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
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 40

                    Image {
                        id: presetButton4
                        source: "images/radio/preset.png"
                        height: sourceSize.height * 2
                        MouseArea {
                            enabled: radioIsOn
                            anchors.fill: parent
                            onClicked: currentFM = 87.7

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
                        height: sourceSize.height * 2
                        MouseArea {
                            enabled: radioIsOn
                            anchors.fill: parent
                            onClicked: currentFM = 87.7

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
                        height: sourceSize.height * 2
                        MouseArea {
                            enabled: radioIsOn
                            anchors.fill: parent
                            onClicked: currentFM = 87.7

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
        }
    }
}
