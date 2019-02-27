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
    id: beClockPage
    width: childrenRect.width
    height: childrenRect.height

    signal configurationChanged


//     property alias cfg_textcolor: _text1.text
//     property alias cfg_textshadow: _text2.text
//     
//     property alias cfg_mincolor1: _min1.text
//     property alias cfg_mincolor2: _min2.text
//     property alias cfg_horacolor1: _hora1.text
//     property alias cfg_horacolor2: _hora2.text
//     property alias cfg_destello: flash.checked
//     property alias cfg_secondcolor1: _seconds1.text
//     property alias cfg_secondcolor2: _seconds2.text
//     property alias cfg_showsecondsring: secondsring.checked
//     property alias cfg_imagenbackground: imagenes.imagen
// 
//     property var logos: ["" ,"images/arch.png","images/debian.png","images/fedora.png","images/kde.png" ,"images/kubuntu.png","images/neon.png" ,"images/suse.png","images/ubuntu.png" ]
    
    property alias cfg_minsize: minwidthslider.value
    property alias cfg_minradius: minradiusslider.value
    property alias cfg_hoursize: hourwidthslider.value
    property alias cfg_hourradius: hourradiusslider.value
    property alias cfg_secsize: secwidthslider.value
    property alias cfg_secradius: secradiusslider.value
    
    
    QtLayouts.ColumnLayout {
		anchors.left: parent.left
		
		QtControls.GroupBox {
			title: i18n("Minutes:")
	        flat: true
	        QtLayouts.ColumnLayout {
		        QtControls.Label { text: i18n("Width")}
				Slider {
					id:minwidthslider
					minimumValue: 5
					maximumValue: 100
					stepSize: 5
					tickmarksEnabled: true
					
				    value: 10
				}
				QtControls.Label { text: i18n("Radius")}
				Slider {
					id:minradiusslider
					minimumValue: 5
					maximumValue: 100
					stepSize: 5
					tickmarksEnabled: true
					
				    value: 85
				}
			}
		}
		QtControls.GroupBox {
			title: i18n("Hour:")
	        flat: true
	        QtLayouts.ColumnLayout {
		        QtControls.Label { text: i18n("Width")}
				Slider {
					id:hourwidthslider
					minimumValue: 5
					maximumValue: 100
					stepSize: 5
					tickmarksEnabled: true
					
				    value: 10
				}
				QtControls.Label { text: i18n("Radius")}
				Slider {
					id:hourradiusslider
					minimumValue: 5
					maximumValue: 100
					stepSize: 5
					tickmarksEnabled: true
					
				    value: 70
				}
			}
		}
		QtControls.GroupBox {
			title: i18n("Seconds:")
	        flat: true
	        QtLayouts.ColumnLayout {
		        QtControls.Label { text: i18n("Width")}
				Slider {
					id:secwidthslider
					minimumValue: 5
					maximumValue: 100
					stepSize: 5
					tickmarksEnabled: true
					
				    value: 10
				}
				QtControls.Label { text: i18n("Radius")}
				Slider {
					id:secradiusslider
					minimumValue: 5
					maximumValue: 100
					stepSize: 5
					tickmarksEnabled: true
					
				    value: 100
				}
			}
		}
	}



//     QtLayouts.ColumnLayout {
//         anchors.left: parent.left
// 
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
//             case 4:
//                 _seconds1.text = colorDialog.color
//                 break
//             case 5:
//                 _seconds2.text = colorDialog.color
//                 break
//             case 6:
//                 _text1.text = colorDialog.color
//                 break
//             case 7:
//                 _text2.text = colorDialog.color
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
// 
//     FileDialog {
//         id: fileDialog
//         title: "Please choose an image"
//         folder: shortcuts.home
//         nameFilters: [ "Image files (*.jpg *.png *.svg)", "All files (*)" ]
//         onAccepted: {
//             //console.log("You chose: " + fileDialog.fileUrls)
//             imageother.text = fileUrl
//             imagenes.imagen = imageother.text
//             print(fileUrl)
//             Qt.quit()
//         }
//         onRejected: {
//             //console.log("Canceled")
//             Qt.quit()
//         }
//         //Component.onCompleted: visible = true
//     }
//     
//     QtControls.GroupBox {
//         QtLayouts.Layout.fillWidth: true
//         title: i18n("Text")
//         flat: true
//         QtLayouts.RowLayout {
//             Button {
//                 text: i18n("Main color")
//                 onClicked: {colorDialog.boton = 6;colorDialog.color = _hora1.text;colorDialog.visible = true;}
//             }
//             QtControls.TextField {
//                 id: _text1
//             }
//             Button {
//                 text: i18n("Shadow color")
//                 onClicked: {colorDialog.boton = 7;colorDialog.color = _hora2.text;colorDialog.visible = true;}
//             }
//             QtControls.TextField {
//                 id: _text2
//             }
//         }
//     }
// 
//     QtControls.GroupBox {
//         QtLayouts.Layout.fillWidth: true
//         title: i18n("Minute rings")
//         flat: true
//         QtLayouts.RowLayout {
//     //         QtControls.Label { text: i18n("Color del minutero")}
//         Button {
//             text: i18n("Main color")
//             onClicked: {colorDialog.boton = 0;colorDialog.color = _min1.text;colorDialog.visible = true;}
//         }          
//             QtControls.TextField {
//                 id: _min1
//             }
//             Button {
//                 text: i18n("Shadow color")
//                 onClicked: {colorDialog.boton = 1;colorDialog.color = _min2.text;colorDialog.visible = true;}
//             }
//             QtControls.TextField {
//                 id: _min2
//             }
//         }
//     }
//       
//     QtControls.GroupBox {
//         QtLayouts.Layout.fillWidth: true
//         title: i18n("Hour rings")
//         flat: true
//         QtLayouts.RowLayout {
//             Button {
//                 text: i18n("Main color")
//                 onClicked: {colorDialog.boton = 2;colorDialog.color = _hora1.text;colorDialog.visible = true;}
//             }
//             QtControls.TextField {
//                 id: _hora1
//             }
//             Button {
//                 text: i18n("Shadow color")
//                 onClicked: {colorDialog.boton = 3;colorDialog.color = _hora2.text;colorDialog.visible = true;}
//             }
//             QtControls.TextField {
//                 id: _hora2
//             }
//         }
//     }
//         
//     QtControls.CheckBox {
//         id: secondsring
//         text: i18n('Show a ring for the seconds')
//     }
//     
//     QtControls.GroupBox {
//         QtLayouts.Layout.fillWidth: true
//         title: i18n("Seconds rings")
//         flat: true
//         visible: secondsring.checked
//         QtLayouts.RowLayout {
//             Button {
//                 text: i18n("Main color")
//                 onClicked: {colorDialog.boton = 4;colorDialog.color = _seconds1.text;colorDialog.visible = true;}
//             }
//             QtControls.TextField {
//                 id: _seconds1
//             }
//             Button {
//                 text: i18n("Shadow color")
//                 onClicked: {colorDialog.boton = 5;colorDialog.color = _seconds2.text;colorDialog.visible = true;}
//             }
//             QtControls.TextField {
//                 id: _seconds2
//             }
//         }
//     }
//     
//     QtControls.Label { text: i18n("You can write 'transparent' as the color\n")}
//     
//     QtControls.CheckBox {
//         id: flash
//         text: i18n('Show a "flash" every hour')
//     }
// 
//       //QtControls.GroupBox {
//       //QtLayouts.Layout.fillWidth: true
//       //title: i18n("Background")
//       //flat: true
//       QtControls.Label { text: i18n("\nBackground")}
//         QtLayouts.ColumnLayout {
// 
//           QtControls.ComboBox {
//               id: imagenes
//               QtLayouts.Layout.fillWidth: true
//               currentIndex: (logos.indexOf(plasmoid.configuration.imagenbackground) >= 0)?logos.indexOf(plasmoid.configuration.imagenbackground):model.indexOf("Other...")
//               //width:100
//               property var imagen//: (currentText == "Other...")?imageother.text:model[currentIndex]["logo"]
//               model: ["No background","Arch logo", "Debian logo","Fedora logo","Kde logo","Kubuntu logo","Neon logo","Suse logo","Ubuntu logo","Other..."]
// 
//               /*onCurrentIndexChanged: {
//                   var current = model.get(currentIndex)
//                   if (current) {
//                       cfg_fontFamily = current.value
//                       appearancePage.configurationChanged()
//                   }
//               }*/
//               //onCurrentIndexChanged: console.debug(imagenesList.get(imagenes.currentIndex).text )
//               onCurrentIndexChanged: {(currentText == "Other...")?imagen = imageother.text:imagen = logos[imagenes.currentIndex]
//               print(imagenes.currentIndex)}
//           }
//           QtLayouts.RowLayout {
//               QtControls.TextField{
//                   id: imageother
//                   QtLayouts.Layout.fillWidth: true
//                   //width:1600
//                   placeholderText: qsTr("Choose a file or use an url")
//                   text : (logos.indexOf(plasmoid.configuration.imagenbackground) >= 0)?"":plasmoid.configuration.imagenbackground
//                   visible: (imagenes.currentText == "Other...")?true:false
//                   onTextChanged: imagenes.imagen = imageother.text
//               }
//               Button {
//                  //QtLayouts.Layout.fillWidth: true
//                  text: "..."
//                  //width: 10
//                  visible: (imagenes.currentText == "Other...")?true:false
//                  onClicked: {fileDialog.visible = true;}
//              }
// 
//           }
//         }
//       //}
//       
//     }
    

}
