VORP = exports.vorp_core:vorpAPI()
VorpInv = exports.vorp_inventory:vorp_inventoryApi()

RegisterNetEvent("spaghetti_proprieta:loadpropertyinfo")
AddEventHandler("spaghetti_proprieta:loadpropertyinfo", function(result, price)
    local _source = source
    
    TriggerEvent("vorp:getCharacter",source,function(user)
        utente = user.identifier
    exports.ghmattimysql:execute('SELECT * FROM proprieta WHERE price = @price', {['@price'] = price}, function(result, price)

        if result[1] ~= nil then
        
        local disponibile = result[1].bought
        local proprietario = result[1].owner
        local tassa = result[1].taxes
        local datatassa = result[1].taxduedate
        local tassapagata = result[1].paidtaxes
        local cognome = result[1].cognome
        local nome = result[1].nome
        local prezzo = price
        local mese = result[1].taxduemonth
        print(disponibile)
        print("Qualcuno ha aperto il menù di una casa")
            

        TriggerClientEvent("spaghetti_proprieta:loadpropertyinfo", _source, disponibile, proprietario, tassa, datatassa, tassapagata, cognome, nome, mese, utente)
        end
     end)
    end)
end)

local function CreaData()

    local date = os.date('*t')
   
        local nowYeah = date.year
        local nowMonth = date.month+1
        local nowDay = 1
        

        data = (nowYeah..'/'..nowMonth..'/'..nowDay)
        mese = (nowMonth)
end

RegisterNetEvent("spaghetti:tasse")
AddEventHandler("spaghetti:tasse", function(source, proprietario, datatassa, tassapagata, tassa, prezzo, proprieta, datamese)
    Wait(1000)
    local _source = source 
    local proprietario2 = proprietario
    local datatassa2 = datatassa
    local datamese2 = datamese
    local tassapagata2 = tassapagata
    local tassa2 = tassa
    local prezzo2 = prezzo
    local proprieta2 = proprieta
    local datadioggi = os.date('*t')
    local mesedioggi = datadioggi.month
    print('Mese di Oggi: '..mesedioggi)
    if proprietario2 ~= nil then
        if mesedioggi >= datamese2 then  --|| os.date("*t") then || --('2020/10/1') then  datamese2
            print("Mo So Cazzi")
            if tassapagata2 >= tassa2 then
                 CreaData()
                 local datanuova = data
                 print(data)
                 local nuovatassa = (tassapagata2-tassa2)
                 print("Questa somma -"..tassapagata2.."- è maggiore di questa somma -"..tassa2.."-")
                 exports.ghmattimysql:execute('UPDATE proprieta SET taxduedate=@datanuova, paidtaxes=@nuovatassa WHERE price=@prezzo', {['@datanuova'] = datanuova, ['@nuovatassa'] = nuovatassa, ['@prezzo'] = prezzo2}, function()
                end)
                TriggerClientEvent("StatusFottutoMenu", _source)
            else 
                print("Questa somma "..tassapagata2.." è inferiore a "..tassa2)
                local nulla = nil
                local disponibile = 0 
                exports.ghmattimysql:execute('UPDATE proprieta SET owner=@nulla, bought=@disponibile WHERE price = @prezzo2',{['@nulla'] = nulla, ['@disponibile'] = disponibile, ['@prezzo2'] = prezzo2}, function()
               -- print('Owner: '..nulla)
                end)
            end
        end
    end
end)


RegisterNetEvent("spaghetti_proprieta:getItems")
AddEventHandler("spaghetti_proprieta:getItems", function(result)

    local _source = source

    TriggerEvent("vorp:getCharacter",source,function(user)
        local identifier = user.identifier

    exports.ghmattimysql:execute('SELECT * FROM proprieta WHERE owner = @identifier', {['@identifier'] = identifier}, function()
       
        if result[1] ~= nil then
            local storeditems = result[1].items
            local owner = result[1].owner
            print(storeditems)

    TriggerClientEvent('spaghetti_proprieta:getItems', _source, storeditems)
        end
        end)
    end)
end)


RegisterNetEvent("spaghetti_proprieta:loadplayerinventory")
AddEventHandler("spaghetti_proprieta:loadplayerinventory", function()

end)



RegisterNetEvent("spaghetti_proprieta:getOutfits")
AddEventHandler("spaghetti_proprieta:getOutfits", function()

    TriggerEvent("vorp:getCharacter", source, function(user)
    local playerId = user.identifier

        exports.ghmattimysql:execute("SELECT title FROM outfits WHERE identifier=@playerId", {['@playerId'] = playerId}, function(result)

            for k, v in pairs(result) do 
                local outfit = result[k].title
                        print(outfit)
            TriggerClientEvent('spaghetti_proprieta:getOutfits', outfit)
            end
        end)
    end)


end)

RegisterNetEvent("spaghetti_proprieta:purchaseproperty")
AddEventHandler("spaghetti_proprieta:purchaseproperty", function(nearestproperty, price)
    
    TriggerEvent("vorp:getCharacter",source,function(user)
        local _source = source
            if user.money >= price then
                    local proprietario = user.identifier
                    local comprato = 1
                    local cognome = user.lastname
                    local nome = user.firstname
                    CreaData()
                    print(data)
                    exports.ghmattimysql:execute("UPDATE proprieta SET owner=@proprietario, bought=@comprato, nome = @nome, cognome=@cognome, taxduedate=@data, taxduemonth=@mese WHERE price = @price", {['@price'] = price, ['@proprietario'] = proprietario, ['@comprato'] = comprato, ['@cognome'] = cognome, ['@nome'] = nome, ['@data'] = data, ['@mese']=mese}, function()    
                         VORP.removeMoney(_source, 0, price)
                         TriggerClientEvent("vorp:NotifyLeft", _source, "Spaghetti - Proprietà", "Acquisto della proprietà avvenuto con successo", "menu_textures", "tick", 1500)                  
                    end)
            else
                TriggerClientEvent("vorp:NotifyLeft", _source, "Spaghetti - Proprietà", "Non hai abbastanza denaro! Lavora un po' di più", "menu_textures", "cross", 1500) 
            end

     end)
end)

RegisterNetEvent("spaghetti_proprieta:sellproperty")
AddEventHandler("spaghetti_proprieta:sellproperty", function(proprieta, prezzo, prezzovendita)

    TriggerEvent("vorp:getCharacter",source,function(user)
        local _source = source
        local owner = user.identifier
        local nulla = nil
        local disponibile = 0 
        exports.ghmattimysql:execute("UPDATE proprieta SET owner=@nulla, bought=@disponibile, cognome=@nulla, nome=@nulla, paidtaxes=@disponibile WHERE owner=@owner AND price = @price",{['@owner'] = owner, ['@price'] = prezzo, ['@disponibile'] = disponibile, ['@nulla'] = nulla}, function()
        print("ohoh")
        VORP.addMoney(_source, 0, prezzovendita)
        TriggerClientEvent("vorp:NotifyLeft", _source, "Spaghetti - Proprietà", "Hai venduto la casa per la metà del suo prezzo.", "menu_textures", "tick", 1500)
        end)
    end)
end)


RegisterNetEvent("spaghetti_proprieta:deposittaxpayment")
AddEventHandler("spaghetti_proprieta:deposittaxpayment", function(quantita, prezzo)
    TriggerEvent("vorp:getCharacter",source,function(user)
        local owner = user.identifier
        TriggerEvent("vorp:getCharacter",source,function(user)
            local _source = source
            local money = user.money
            if money >= quantita then
                print(quantita..' e '..money)
                VORP.removeMoney(_source, 0, quantita)
                exports.ghmattimysql:execute('UPDATE proprieta SET paidtaxes=@quantita WHERE owner=@owner AND price=@prezzo', {['@owner'] = owner, ['@quantita'] = quantita, ['@prezzo'] = prezzo}, function()
                end)
            else
                TriggerClientEvent("vorp:NotifyLeft", _source, "Spaghetti - Proprietà", "Non hai abbastanza soldi.", "menu_textures", "cross", 1500)
            end
        end)
end)
end)

RegisterNetEvent("spaghetti_proprieta:storeitem")
AddEventHandler("spaghetti_proprieta:storeitem", function (proprieta, amount, oggetto)

end)

RegisterNetEvent("spaghetti_proprieta:removeitem")
AddEventHandler("spaghetti_proprieta:removeitem", function(proprieta, amount, qtoggettocasa, oggettocasa)

end)


RegisterServerEvent("vorp_housing:MoveToHouse")
RegisterServerEvent("vorp_housing:TakeFromHouse")
RegisterServerEvent("house:reloadHouseInventory")


AddEventHandler("vorp_housing:MoveToHouse", function(jsonData)
    local _source = source
	local data = json.decode(jsonData)
	local houseId = tonumber(data["house"])
	local item = data["item"]
	local itemCount = tonumber(data["number"])
	local itemType = data["type"]
	if itemType ~= "item_standard" then
		TriggerClientEvent("vorp:TipBottom", _source, "Puoi depositare solo oggetti!", 2000)
		return
	end

	
	if item.count < itemCount then
		TriggerClientEvent("vorp:TipBottom", _source, "Quantità non valida!", 2000)
		return
	end	
	exports["ghmattimysql"]:execute("SELECT items FROM proprieta WHERE price = @price", { ["@price"] = houseId }, function(result)
        if result[1] ~= nil then
            local items = {}

            local inv = json.decode(result[1]["items"])
			local foundItem = nil
            for k,v in pairs(inv) do 
				if v.name == item.name then
					foundItem = v
				end
			end
			
			if foundItem then
				foundItem.count = foundItem.count + itemCount
			else
				foundItem = {name = item.name, count = itemCount, label = item.label, type = item.type, limit = item.limit }
				table.insert(inv, foundItem)
			end
			items["itemList"] = inv
            items["action"] = "setSecondInventoryItems"
			VorpInv.subItem(_source, item.name, itemCount)
			TriggerClientEvent("vorp_inventory:ReloadHouseInventory", _source, json.encode(items))
			exports["ghmattimysql"]:execute("UPDATE proprieta SET items = @inv WHERE price = @price",{["@inv"] = json.encode(inv), ["@price"] = houseId})			
        end
    end)	
end)

AddEventHandler("vorp_housing:TakeFromHouse", function(jsonData)
    local _source = source
	local data = json.decode(jsonData)
	local houseId = tonumber(data["house"])
	local item = data["item"]
	local itemCount = tonumber(data["number"])
	local itemType = data["type"]
	if itemType ~= "item_standard" then
		TriggerClientEvent("vorp:TipBottom", _source, "Puoi depositare solo oggetti!", 2000)
		return
	end

	if item.count < itemCount then
		TriggerClientEvent("vorp:TipBottom", _source, "Quantità non valida!", 2000)
		return
	end

	local count = VorpInv.getItemCount(_source, item.name)
	
	if (count + itemCount) > item.limit then
		TriggerClientEvent("vorp:TipBottom", _source, "Hai raggiunto il limite per questo oggetto!", 2000)
		return
	end
	
	TriggerEvent("vorpCore:canCarryItems", tonumber(_source), itemCount, function(canCarry)
		if canCarry then
			exports["ghmattimysql"]:execute("SELECT items FROM proprieta WHERE price = @price", { ["@price"] = houseId }, function(result)
				if result[1] ~= nil then
					local items = {}

					local inv = json.decode(result[1]["items"])
					local foundItem, foundIndex = nil, nil
					for k,v in pairs(inv) do 
						if v.name == item.name then
							foundItem = v
						end
					end
				--	TriggerClientEvent("vorp:TipBottom", _source, "Okkk!", 2000)
					if foundItem then
						foundItem.count = foundItem.count - itemCount
						if foundItem.count == 0 then
							table.remove(inv, foundIndex)
						end
						items["itemList"] = inv
						items["action"] = "setSecondInventoryItems"
						VorpInv.addItem(_source, item.name, itemCount)
						TriggerClientEvent("vorp_inventory:ReloadHouseInventory", _source, json.encode(items))
						exports["ghmattimysql"]:execute("UPDATE proprieta SET items = @inv WHERE price = @price",{["@inv"] = json.encode(inv), ["@price"] = houseId})
					else
						print("Errore script casa, item preso ma non presente nel database?")
					end		
				end
			end)
		else
			TriggerClientEvent("vorp:TipBottom", _source, "Non puoi trasportare altri oggetti!", 2000)
		end
	end)
end)

AddEventHandler("house:reloadHouseInventory", function(houseId)
    local _source = source
    exports["ghmattimysql"]:execute("SELECT items FROM proprieta WHERE price = @price", { ["@price"] = houseId }, function(result)
        if result[1] ~= nil then
            local items = {}
            print("Arrivo qui")
            local inv = json.decode(result[1]["items"])
            if not inv then
                print("Arrivo qui2")
                items["itemList"] = {}
                items["action"] = "setSecondInventoryItems"
                TriggerClientEvent("vorp_inventory:ReloadHouseInventory", _source, json.encode(items))
            else 
                print("Arrivo qui3")
                items["itemList"] = inv
                items["action"] = "setSecondInventoryItems"

                TriggerClientEvent("vorp_inventory:ReloadHouseInventory", _source, json.encode(items));
            end
        end
    end)
end)
