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


    
    property alias cfg_mincolor1: _min1.text
    property alias cfg_mincolor2: _min2.text
    property alias cfg_horacolor1: _hora1.text
    property alias cfg_horacolor2: _hora2.text
    property alias cfg_destello: flash.checked




    QtLayouts.ColumnLayout {
        anchors.left: parent.left

    ColorDialog {
    id: colorDialog
    title: "Please choose a color"
    //En el orden de los cuatros botones
    property int boton
    onAccepted: {
//         console.log("You chose: " + colorDialog.color)
        switch(boton){
            case 0:
                _min1.text = colorDialog.color
                break
            case 1:
                _min2.text = colorDialog.color
                break
            case 2:
                _hora1.text = colorDialog.color
                break
            case 3:
                _hora2.text = colorDialog.color
                break
            }
//         Qt.quit()
    }
    onRejected: {
//         console.log("Canceled")
//         Qt.quit()
    }
//     Component.onCompleted: visible = true
    }
    QtControls.GroupBox {
    QtLayouts.Layout.fillWidth: true
    title: i18n("Minute rings")
    flat: true
      QtLayouts.RowLayout {
//         QtControls.Label { text: i18n("Color del minutero")}
    Button {
        text: i18n("Main color")
        onClicked: {colorDialog.boton = 0;colorDialog.color = _min1.text;colorDialog.visible = true;}
    }          
        QtControls.TextField {
            id: _min1
        }
        Button {
            text: i18n("Shadow color")
            onClicked: {colorDialog.boton = 1;colorDialog.color = _min2.text;colorDialog.visible = true;}
        }
        QtControls.TextField {
            id: _min2
        }
      } }
    QtControls.GroupBox {
    QtLayouts.Layout.fillWidth: true
    title: i18n("Hour rings")
    flat: true
      QtLayouts.RowLayout {
         Button {
            text: i18n("Main color")
            onClicked: {colorDialog.boton = 2;colorDialog.color = _hora1.text;colorDialog.visible = true;}
        }
        QtControls.TextField {
            id: _hora1
        }
         Button {
            text: i18n("Shadow color")
            onClicked: {colorDialog.boton = 3;colorDialog.color = _hora2.text;colorDialog.visible = true;}
        }
        QtControls.TextField {
            id: _hora2
        }
      }}
      
      QtControls.Label { text: i18n("You can write 'transparent' as the color\n")}
      
      QtControls.CheckBox {
           id: flash
           text: i18n('Show a "flash" every hour')
      }
      
    }
    

}
