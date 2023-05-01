// ------------------------------------------------------------------------------------------------
// Copyright 2019 (c) EasyStep2 BV. All rights reserved.
// This file is part of EasyStep2 Open Source Base App extension.
//
//  EasyStep2 Open Source Base App is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  EasyStep2 Open Source Base App is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with EasyStep2 Open Source Base App. If not, see <https://www.gnu.org/licenses/>.
// ------------------------------------------------------------------------------------------------
pageextension 95110 ES2LocationCard extends "Location Card"
{
    layout
    {
        addafter("Cross-Dock Due Date Calc.")
        {
            field(ES2WarehouseType; Rec.ES2WarehouseType)
            {
                ApplicationArea = Warehouse;
                Caption = 'Warehouse Type';
                ToolTip = 'Specifies if the warehouse location is a consignment warehouse or just an external warehouse.';
            }
            field(ES2WarehouseTypeNo; Rec.ES2WarehouseTypeNo)
            {
                ApplicationArea = Warehouse;
                Caption = 'Warehouse Type No.';
                ToolTip = 'Specifies the vendor or customer of the warehouse location when consignment warehouse or just an external warehouse.';
            }

            field(ES2PreferredTransferfromCode; Rec.ES2PreferredTransferFromCode)
            {
                ApplicationArea = Warehouse;
                Caption = 'Preferred Transfer-from Code';
                ToolTip = 'In case of replenishment of this warehouse the replenishment should take place from defined Location Code.';
            }
            field(ES2UsePlanningParamFromItem; Rec.ES2UsePlanningParamFromItem)
            {
                ApplicationArea = Planning;
                Caption = 'Use planning parameters from Item with no SKU.';
                ToolTip = 'In case of replenishment of this warehouse and no SKU''s exist, the plannings parameters should be taken from the Item card in case of Lot for Lot.';
            }
        }
    }
}