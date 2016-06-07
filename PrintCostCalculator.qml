// Copyright (c) 2015 Jaime van Kessel.
// PrintCostCalculator is released under the terms of the AGPLv3 or higher.

import QtQuick 2.2
import QtQuick.Window 2.2
import QtQuick.Controls 1.2

import UM 1.0 as UM

UM.Dialog
{
    modality: Qt.NonModal
    id: base;
    width: 250 * Screen.devicePixelRatio;
    height: 110 * Screen.devicePixelRatio;
    visible: true;
    title:  qsTr("Calculate print cost")
    property real material_amount_length: manager.materialAmountLength == -1 ? 0 : manager.materialAmountLength
    property real pi: 3.1415 
    property real material_radius:  0.5 * manager.materialDiameter
    property real material_amount_volume:  pi * material_radius * material_radius * material_amount_length / 1000000 
    property real density: manager.density
    property real kg_material: material_amount_volume * density
    property real price_per_kg : manager.pricePerKg 
   
    Column
    {
        anchors.fill: parent;
        Row
        {
            Text 
            {
                text: "Density: "
            }
            TextField 
            { 
                id: density_field
                text: density
                Keys.onReleased:
                {
                    manager.setDensity(density_field.text)
                }
            }
        }
        Row 
        {
            Text 
            {
                text: "Cost per kg: "
            }
            TextField 
            { 
                id: cost_field
                text: price_per_kg
                Keys.onReleased:
                {
                    manager.setPricePerKG(cost_field.text)
                }
            }
        }
        Text
        {
            text: "Weight of print " + Math.round(kg_material * 100 ) / 100 + " kg"
        }
        
        Text
        {
            text: "Print cost: " +  Math.round(price_per_kg * kg_material * 100) / 100
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
