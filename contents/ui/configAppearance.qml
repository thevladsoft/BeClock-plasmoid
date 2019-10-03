/*
 * Copyright 2013  Bhushan Shah <bhush94@gmail.com>
 * Copyright 2013 Sebastian Kügler <sebas@kde.org>
 * Copyright 2015 Kai Uwe Broulik <kde@privat.broulik.de>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License or (at your option) version 3 or any later version
 * accepted by the membership of KDE e.V. (or its successor approved
 * by the membership of KDE e.V.), which shall act as a proxy
 * defined in Section 14 of version 3 of the license.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>
 */

import QtQuick 2.0
import QtQuick.Controls 1.0 as QtControls
import QtQuick.Layouts 1.0 as QtLayouts
import org.kde.plasma.calendar 2.0 as PlasmaCalendar

import QtQuick.Dialogs 1.0
import QtQuick.Controls 1.4

Item {
    id: appearancePage
    width: childrenRect.width
    height: childrenRect.height

    signal configurationChanged

    property string cfg_fontFamily
    property alias cfg_boldText: boldCheckBox.checked
    property string cfg_timeFormat: ""
    property alias cfg_italicText: italicCheckBox.checked
    
    property alias cfg_datefontsize: datefontsize.value

    property alias cfg_showLocalTimezone: showLocalTimezone.checked
    property alias cfg_displayTimezoneAsCode: timezoneCodeRadio.checked
    property alias cfg_showSeconds: showSeconds.checked

    property alias cfg_showDate: showDate.checked
    property string cfg_dateFormat: "shortDate"
    property alias cfg_use24hFormat: use24hFormat.checkedState
    
    property alias cfg_timesize: timefontsize.value
    property alias cfg_timeproport: timeproport.checked
    
//     property alias cfg_mincolor1: _min1.text
//     property alias cfg_mincolor2: _min2.text
//     property alias cfg_horacolor1: _hora1.text
//     property alias cfg_horacolor2: _hora2.text

    onCfg_fontFamilyChanged: {
        // HACK by the time we populate our model and/or the ComboBox is finished the value is still undefined
        if (cfg_fontFamily) {
            for (var i = 0, j = fontsModel.count; i < j; ++i) {
                if (fontsModel.get(i).value == cfg_fontFamily) {
                    fontFamilyComboBox.currentIndex = i
                    break
                }
            }
        }
    }

    ListModel {
        id: fontsModel
        Component.onCompleted: {
            var arr = [] // use temp array to avoid constant binding stuff
            arr.push({text: i18nc("Use default font", "Default"), value: ""})

            var fonts = Qt.fontFamilies()
            var foundIndex = 0
            for (var i = 0, j = fonts.length; i < j; ++i) {
                arr.push({text: fonts[i], value: fonts[i]})
            }
            append(arr)
        }
    }

    QtLayouts.ColumnLayout {
        anchors.left: parent.left
        QtControls.GroupBox {
            QtLayouts.Layout.fillWidth: true
            title: i18n("Font")
            flat: true

            QtLayouts.GridLayout { // there's no FormLayout :(
                columns: 2
                QtLayouts.Layout.fillWidth: true

                QtControls.Label {
                    QtLayouts.Layout.fillWidth: true
                    horizontalAlignment: Text.AlignRight
                    text: i18n("Font style:")
                }

                QtControls.ComboBox {
                    id: fontFamilyComboBox
                    QtLayouts.Layout.fillWidth: true
                    // ComboBox's sizing is just utterly broken
                    QtLayouts.Layout.minimumWidth: units.gridUnit * 10
                    model: fontsModel
                    // doesn't autodeduce from model because we manually populate it
                    textRole: "text"

                    onCurrentIndexChanged: {
                        var current = model.get(currentIndex)
                        if (current) {
                            cfg_fontFamily = current.value
                            appearancePage.configurationChanged()
                        }
                    }
                }

                // spacer, cannot do Qt.AlignTop on the font style label + rowSpan 3, otherwise looks odd
                Item {
                    QtLayouts.Layout.fillWidth: true
                    QtLayouts.Layout.rowSpan: 2
                }
QtLayouts.RowLayout {
                QtControls.CheckBox {
                    id: boldCheckBox
                    text: i18n("Bold text")
                }

                QtControls.CheckBox {
                    id: italicCheckBox
                    text: i18n("Italic text")
                }}
                 QtLayouts.RowLayout {
						QtControls.Label {
		                        text: i18n("Time font size:")
	                    }
	                    QtControls.CheckBox {
		                    id: timeproport
		                    text: i18n("Proportional")
		                }
	                    SpinBox {
		                    id: timefontsize
							visible:! timeproport.checked
		                    suffix: i18n("pt")
		                    minimumValue: 2
// 		                    maximumValue: 1000000
		                }
				}
            }
        }

        QtControls.GroupBox {
            QtLayouts.Layout.fillWidth: true
            title: i18n("Information")
            flat: true

            QtLayouts.ColumnLayout {
QtLayouts.RowLayout {
                QtControls.CheckBox {
                    id: showDate
                    text: i18n("Show date")
                }
                QtControls.Label {
                        text: i18n("Date format:")
						visible:showDate.checked
                    }

                    QtControls.ComboBox {
                        id: dateFormat
                        enabled: showDate.checked
                        visible:showDate.checked
                        textRole: "label"
                        model: [
                            {
                                'label': i18n("Long Date"),
                                'name': "longDate"
                            },
                            {
                                'label': i18n("Short Date"),
                                'name': "shortDate"
                            },
                            {
                                'label': i18n("ISO Date"),
                                'name': "isoDate"
                            }
                        ]
                        onCurrentIndexChanged: cfg_dateFormat = model[currentIndex]["name"]

                        Component.onCompleted: {
                            for (var i = 0; i < model.length; i++) {
                                if (model[i]["name"] == plasmoid.configuration.dateFormat) {
                                    dateFormat.currentIndex = i;
                                }
                            }
                        }
                    } }
                    
                    QtLayouts.RowLayout {
						visible:showDate.checked
						QtControls.Label {
		                        text: i18n("Date font size:")
	                    }
	                    SpinBox {
		                    id: datefontsize
		                    
		                    suffix: i18n("pt")
		                    minimumValue: 2
// 		                    maximumValue: 1000000
		                }
					}

                QtControls.CheckBox {
                    id: showSeconds
                    text: i18n("Show seconds")
                }

                QtControls.CheckBox {
                    id: use24hFormat
                    text: i18nc("Checkbox label; means 24h clock format, without am/pm", "Use 24-hour Clock")
                }
// QtLayouts.RowLayout {
                QtControls.CheckBox {
                    id: showLocalTimezone
                    text: i18n("Show local time zone")
                }
QtLayouts.RowLayout {
                QtControls.Label {
                    text: i18n("Display time zone as:")
                }

                QtControls.GroupBox {
                    QtLayouts.Layout.fillWidth: true
                    flat: true
                    QtLayouts.ColumnLayout {

                        QtControls.ExclusiveGroup { id: timezoneDisplayType }
QtLayouts.RowLayout {
                        QtControls.RadioButton {
                            id: timezoneCityRadio
                            text: i18n("Time zone city")
                            exclusiveGroup: timezoneDisplayType
                        }

                        QtControls.RadioButton {
                            id: timezoneCodeRadio
                            text: i18n("Time zone code")
                            exclusiveGroup: timezoneDisplayType
                        }
                    }}
                } }

                QtLayouts.RowLayout {
//                     QtControls.Label {
//                         text: i18n("Date format:")
//                     }
// 
//                     QtControls.ComboBox {
//                         id: dateFormat
//                         enabled: showDate.checked
//                         textRole: "label"
//                         model: [
//                             {
//                                 'label': i18n("Long Date"),
//                                 'name': "longDate"
//                             },
//                             {
//                                 'label': i18n("Short Date"),
//                                 'name': "shortDate"
//                             },
//                             {
//                                 'label': i18n("ISO Date"),
//                                 'name': "isoDate"
//                             }
//                         ]
//                         onCurrentIndexChanged: cfg_dateFormat = model[currentIndex]["name"]
// 
//                         Component.onCompleted: {
//                             for (var i = 0; i < model.length; i++) {
//                                 if (model[i]["name"] == plasmoid.configuration.dateFormat) {
//                                     dateFormat.currentIndex = i;
//                                 }
//                             }
//                         }
//                     }
                }
            }
        }
//       QtControls.Label { text: i18n("Para ver los siguientes cambios debe forzar la actualización del reloj\n (cambie el tamaño o espere que cambie la hora/minuto).")}
//     ColorDialog {
//     id: colorDialog
//     title: "Please choose a color"
//     //En el orden de los cuatros botones
//     property int boton
//     onAccepted: {
// //         console.log("You chose: " + colorDialog.color)
//         switch(boton){
//             case 0:
//                 _min1.text = colorDialog.color
//                 break
//             case 1:
//                 _min2.text = colorDialog.color
//                 break
//             case 2:
//                 _hora1.text = colorDialog.color
//                 break
//             case 3:
//                 _hora2.text = colorDialog.color
//                 break
//             }
// //         Qt.quit()
//     }
//     onRejected: {
// //         console.log("Canceled")
// //         Qt.quit()
//     }
// //     Component.onCompleted: visible = true
//     }
//     QtControls.GroupBox {
//     QtLayouts.Layout.fillWidth: true
//     title: i18n("Disco de los minutos")
//     flat: true
//       QtLayouts.RowLayout {
// //         QtControls.Label { text: i18n("Color del minutero")}
//     Button {
//         text: "Color primario"
//         onClicked: {colorDialog.boton = 0;colorDialog.color = _min1.text;colorDialog.visible = true;}
//     }          
//         QtControls.TextField {
//             id: _min1
//         }
//         Button {
//             text: "Color secundario"
//             onClicked: {colorDialog.boton = 1;colorDialog.color = _min2.text;colorDialog.visible = true;}
//         }
//         QtControls.TextField {
//             id: _min2
//         }
//       } }
//     QtControls.GroupBox {
//     QtLayouts.Layout.fillWidth: true
//     title: i18n("Disco de la hora")
//     flat: true
//       QtLayouts.RowLayout {
//          Button {
//             text: "Color primario"
//             onClicked: {colorDialog.boton = 2;colorDialog.color = _hora1.text;colorDialog.visible = true;}
//         }
//         QtControls.TextField {
//             id: _hora1
//         }
//          Button {
//             text: "Color secundario"
//             onClicked: {colorDialog.boton = 3;colorDialog.color = _hora2.text;colorDialog.visible = true;}
//         }
//         QtControls.TextField {
//             id: _hora2
//         }
//       }}
    }
    


    Component.onCompleted: {
        if (plasmoid.configuration.displayTimezoneAsCode) {
            timezoneCodeRadio.checked = true;
        } else {
            timezoneCityRadio.checked = true;
        }
    }
}
