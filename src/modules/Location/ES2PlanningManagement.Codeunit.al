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
codeunit 95110 ES2PlanningManagement
{
    Access = Internal;

    var
        PlanningManagementImpl: Codeunit ES2PlanningManagementImpl;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Planning-Get Parameters", 'OnAfterAtSKU', '', true, false)]
    local procedure OnAfterAtSKU(var SKU: Record "Stockkeeping Unit"; var GlobalSKU: Record "Stockkeeping Unit");
    begin
        PlanningManagementImpl.GetPlanningParamFromItem(SKU, GlobalSKU);
    end;

    [EventSubscriber(ObjectType::Report, Report::"Create Stockkeeping Unit", 'OnBeforeStockkeepingUnitInsert', '', true, false)]
    local procedure OnBeforeStockkeepingUnitInsert(var StockkeepingUnit: Record "Stockkeeping Unit"; Item: Record Item)
    begin
        // Default Repleshiment based at Warehouse Type of Location
        PlanningManagementImpl.OnBeforeStockkeepingUnitInsert(StockkeepingUnit, Item);
    end;
}