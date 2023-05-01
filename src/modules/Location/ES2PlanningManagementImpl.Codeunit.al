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
codeunit 95111 ES2PlanningManagementImpl
{
    Access = Internal;

    var
        Item: Record Item;
        Location: Record Location;

    internal procedure GetPlanningParamFromItem(var SKU: Record "Stockkeeping Unit"; var GlobalSKU: Record "Stockkeeping Unit");
    var
        SKU2: Record "Stockkeeping Unit";
    begin
        // Is this a bug? : Planning parameters are not taken over in case of no SKU and "Reordering Policy"::"Lot for Lot" from the Item
        // The documentation calls it "minimal alternative" Reordering Policy = Lot-for-Lot ( Order remains Order), Include Inventory = Yes, all other planning parameters = Empty.
        // https://docs.microsoft.com/en-us/dynamics365/business-central/production-planning-with-without-locations#demand-at-blank-location
        if GetLocation(SKU."Location Code") then
            if Location.ES2UsePlanningParamFromItem then begin
                SKU2.SetRange(SKU2."Item No.", SKU."Item No.");
                SKU2.SetRange(SKU2."Variant Code", SKU."Variant Code");
                SKU2.SetRange(SKU2."Location Code", SKU."Location Code");
                if SKU2.IsEmpty() then
                    if GetLocation(SKU."Location Code") then begin
                        GetItem(SKU."Item No.");
                        if (Item."Reordering Policy" = Item."Reordering Policy"::"Lot-for-Lot") then begin
                            SKU."Minimum Order Quantity" := Item."Minimum Order Quantity";
                            SKU."Maximum Order Quantity" := Item."Maximum Order Quantity";
                            SKU."Safety Stock Quantity" := Item."Safety Stock Quantity";
                            SKU."Order Multiple" := Item."Order Multiple";
                            SKU."Overflow Level" := Item."Overflow Level";

                            GlobalSKU."Minimum Order Quantity" := Item."Minimum Order Quantity";
                            GlobalSKU."Maximum Order Quantity" := Item."Maximum Order Quantity";
                            GlobalSKU."Safety Stock Quantity" := Item."Safety Stock Quantity";
                            GlobalSKU."Order Multiple" := Item."Order Multiple";
                            GlobalSKU."Overflow Level" := Item."Overflow Level";
                        end;
                    end;
            end;
    end;

    internal procedure OnBeforeStockkeepingUnitInsert(var StockkeepingUnit: Record "Stockkeeping Unit"; Item: Record Item)
    begin
        // Default Repleshiment based at Warehouse Type of Location
        if (StockkeepingUnit."Location Code" <> '') then begin
            GetLocation(StockkeepingUnit."Location Code");
            if (Location.ES2WarehouseType = Location.ES2WarehouseType::External) then
                StockkeepingUnit."Safety Stock Quantity" := 0
            else
                StockkeepingUnit."Safety Stock Quantity" := Item."Safety Stock Quantity";

            if (TransferFromExternalWarehouse(Item) and (Location.ES2WarehouseType = Location.ES2WarehouseType::Standard)) or
               (Location.ES2WarehouseType in [Location.ES2WarehouseType::Customer, Location.ES2WarehouseType::Vendor]) then begin
                StockkeepingUnit."Replenishment System" := StockkeepingUnit."Replenishment System"::Transfer;
                StockkeepingUnit."Transfer-from Code" := Location.ES2PreferredTransferFromCode;
                Evaluate(StockkeepingUnit."Lead Time Calculation", '');
            end
            else
                StockkeepingUnit."Replenishment System" := Item."Replenishment System";
        end;
    end;

    local procedure TransferFromExternalWarehouse(Item2: Record Item): Boolean
    var
        Vendor: Record Vendor;
    begin
        // Verify based at Default Location Of Item Vendor if a Transfer is required
        if Item2."Vendor No." = '' then exit(false);

        if Vendor.Get(Item2."Vendor No.") then begin
            if Vendor."Location Code" = '' then exit(false);
            GetLocation(Vendor."Location Code");
            exit((Location.ES2WarehouseType = Location.ES2WarehouseType::External) and (Location.ES2PreferredTransferFromCode = ''));
        end;
    end;

    local procedure GetItem(ItemNo: Code[20])
    begin
        if Item."No." <> ItemNo then
            Item.Get(ItemNo);
    end;

    local procedure GetLocation(LocationCode: Code[10]) Found: Boolean
    begin
        if (LocationCode = '') then begin
            Found := false;
            exit;
        end;

        Found := true;
        if (Location.Code <> LocationCode) and (LocationCode <> '') then
            Found := Location.Get(LocationCode);
    end;
}