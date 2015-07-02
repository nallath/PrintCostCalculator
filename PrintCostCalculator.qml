// Copyright (c) 2015 Jaime van Kessel.
// PrintCostCalculator is released under the terms of the AGPLv3 or higher.

import QtQuick 2.2
import QtQuick.Window 2.2
import QtQuick.Controls 1.2

import UM 1.0 as UM

UM.Dialog
{
    id: base;
    width: 500 * Screen.devicePixelRatio;
    height: 100 * Screen.devicePixelRatio;
    visible: true;
    title:  qsTr("Calculate print cost")
   
    Column
    {
        anchors.fill: parent;

        Text
        { 
            text: manager.materialAmount == -1 ? 0 : manager.materialAmount
            onTextChanged: 
            {
                price_text.text = "Price: " + manager.materialAmount * cost_field.text
            }
        }
        TextField 
        { 
            id: cost_field
            text: "12"
            onAccepted: 
            {
                price_text.text = "Price: " + manager.materialAmount * cost_field.text
            }
        }
        
        Text
        {
            id: price_text
            text: "Price:"
        }
 
        Button
        {
            
            //: Add Printer wizarad button
            text: qsTr("Cancel");
            onClicked: 
            {
                base.visible = false;
            }
        }
    }
}
