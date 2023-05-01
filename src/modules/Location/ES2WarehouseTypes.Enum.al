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
enum 95100 ES2WarehouseTypes
{
    Extensible = false;

    value(0; Standard)
    {
        Caption = 'Standard';
    }
    value(1; Customer)
    {
        Caption = 'Customer';
    }
    value(2; Vendor)
    {
        Caption = 'Vendor';
    }
    value(3; External)
    {
        Caption = 'External';
    }
}
