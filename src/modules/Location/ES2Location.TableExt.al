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
tableextension 95110 ES2Location extends Location
{
    fields
    {
        field(95110; ES2WarehouseType; Enum ES2WarehouseTypes)
        {
            Caption = 'Warehouse Type';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if ES2WarehouseType <> xRec.ES2WarehouseType then
                    ES2WarehouseTypeNo := '';
            end;
        }
        field(95111; ES2WarehouseTypeNo; Code[20])
        {
            Caption = 'Warehouse Type No.';
            DataClassification = CustomerContent;
            TableRelation = if (ES2WarehouseType = const(Customer)) Customer
            else
            if (ES2WarehouseType = const(Vendor)) Vendor;
        }
        field(95112; ES2PreferredTransferFromCode; Code[10])
        {
            Caption = 'Preferred Transfer-from Code';
            DataClassification = CustomerContent;
            TableRelation = Location where("Use As In-Transit" = const(false));
        }
        field(95120; ES2UsePlanningParamFromItem; Boolean)
        {
            Caption = 'Use planning parameters from Item with no SKU.';
            DataClassification = CustomerContent;
        }
    }
}