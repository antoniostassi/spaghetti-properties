local nearestproperty = ''
local nearestpropertyprice = nil
local sellprice = nil
local propertyowner = ''
local propertytaxes = 0
local propertytaxduedate = ''
local propertytaxpaid = 0
local available = 0
local inventory = {}
local propertyinv = {}
local propertyoutfits = {}
local StatusFottutoMenu = nil 
local outfits = nil

local properties = { 
	{ name = 'Proprietà 1', price = 9500, x = -821.26, y = 352.88, z = 97.98 }, --Valentine
	{ name = 'Proprietà 2', price = 2225, x = -404.66, y = 662.87, z = 115.46 }, --Valentine
	{ name = 'Proprietà 3', price = 4200, x = -285.35, y = 868.93, z = 121.04 }, --Valentine
	{ name = 'Proprietà 4', price = 2500, x = -260.38, y = 843.7, z = 123.48 }, --Valentine
	{ name = 'Proprietà 5', price = 835, x = -281.02, y = 912.93, z = 127.9 }, --Valentine
	{ name = 'Proprietà 6', price = 730, x = -245.58, y = 958.89, z = 138.53 }, --Valentine
	{ name = 'Proprietà 7', price = 4560, x = -382.76, y = 917.1, z = 118.42 }, --Valentine
	{ name = 'Proprietà 8', price = 2350, x = -2579.98, y = -1381.9, z = 149.15 }, 
	{ name = 'Proprietà 9', price = 1500, x = -762.83, y = -1454.78, z = 55.4 }, 
    { name = 'Proprietà 10', price = 1501, x = -804.91, y = -1501.77, z = 63.4 }, 
    { name = 'Proprietà 11', price = 2000, x = -878.85, y = -1642.75, z = 69.08 }, 
    { name = 'Proprietà 12', price = 1250, x = -1022.62, y = -1626.0, z = 78.92 },
    { name = 'Proprietà 13', price = 600, x = -790.90, y = -1405.85, z = 44.8 }, 
    { name = 'Proprietà 14', price = 601, x = -804.44, y = -1409.03, z = 44.91 }, 
    { name = 'Proprietà 15', price = 602, x = -821.81, y = -1409.97, z = 44.4 },  
    { name = 'Proprietà 16', price = 400, x = -830.54, y = -1412.55, z = 43.96 }, 
    { name = 'Proprietà 17', price = 750, x = -879.13, y = -1417.69, z = 45.04 }, 
    { name = 'Proprietà 18', price = 900, x = -909.51, y = -1366.36, z = 45.31 },
    { name = 'Proprietà 19', price = 603, x = -908.45, y = -1345.92, z = 45.46 },
    { name = 'Proprietà 20', price = 1100, x = -929.57, y = -1271.5, z = 51.34 },
    { name = 'Proprietà 21', price = 1425, x = -965.34, y = -1252.62, z = 53.87 },  
    { name = 'Proprietà 22', price = 825, x = -943.35, y = -1227.52, z = 52.54 },
    { name = 'Proprietà 23', price = 1500, x = -1503.93, y = -792.93, z = 104.34 },
    { name = 'Proprietà 24', price = 1150, x = -860.86, y = -750.17, z = 59.57 }, 
    { name = 'Proprietà 25', price = 8000, x = -615.54, y = -24.05, z = 85.88 },
    { name = 'Proprietà 26', price = 20000, x = -1641.65, y = -1360.56, z = 84.3 },
    { name = 'Proprietà 27', price = 1000, x = -1980.78, y = -1667.92, z = 118.08 }, 
    { name = 'Proprietà 28', price = 3000, x = -1981.97, y = -1619.91, z = 117.98 },
    { name = 'Proprietà 29', price = 4250, x = -1822.95, y = -615.83, z = 154.92 },
    { name = 'Proprietà 30', price = 1225, x = -1679.37, y = -341.1847, z = 173.9739 },
    { name = 'Proprietà 31', price = 750, x = -1724.33, y = -87.06, z = 181.61 },
    { name = 'Proprietà 32', price = 975, x = -2368.57, y = 471.2, z = 132.13 },
    { name = 'Proprietà 33', price = 1285, x = -1818.81, y = 657.6, z = 131.76 }, 
    { name = 'Proprietà 34', price = 4200, x = -2532.28, y = 1175.39, z = 225.84 }, 
	
    { name = 'Proprietà 35', price = 5150, x = -2459.96, y = 842.15, z = 146.28 },
    { name = 'Proprietà 36', price = 2250, x = -687.38, y = 1042.63, z = 134.9 },  
    { name = 'Proprietà 37', price = 4500, x = -68.12, y = 1234.76, z = 170.71 },  
    { name = 'Proprietà 38', price = 1275, x = -157.46, y = 1491.85, z = 116.07 },  
    { name = 'Proprietà 39', price = 7450, x = -422.07, y = 1738.15, z = 216.46 },
    { name = 'Proprietà 40', price = 2670, x = 744.8, y = 1828.17, z = 237.91 }, 
    { name = 'Proprietà 41', price = 8530, x = 1934.77, y = 1944.74, z = 266.0 }, 
    { name = 'Proprietà 42', price = 7340, x = 1701.82, y = 1509.69, z = 147.77 }, 
    { name = 'Proprietà 43', price = 4870, x = 2993.17, y = 2193.08, z = 166.66 },
    { name = 'Proprietà 44', price = 3285, x = 3027.49, y = 1781.23, z = 84.03 }, 
    { name = 'Proprietà 45', price = 3800, x = 2835.14, y = 1687.95, z = 129.6 }, 
    { name = 'Proprietà 46', price = 3800, x = 2624.17, y = 1697.36, z = 115.6 },
    { name = 'Proprietà 47', price = 3460, x = 1981.22, y = 1191.27, z = 171.3 },  
    { name = 'Proprietà 48', price = 3225, x = 2826.6, y = 276.03, z = 48.0 },
    { name = 'Proprietà 49', price = 5200, x = 2237.9, y = -144.42, z = 47.53 },
	
    { name = 'Proprietà 50', price = 600, x = 2119.92, y = -560.03, z = 42.6 },
    { name = 'Proprietà 51', price = 895, x = 2076.08, y = -589.29, z = 43.07 },
    { name = 'Proprietà 52', price = 715, x = 2116.28, y = -595.36, z = 42.51 },
    { name = 'Proprietà 53', price = 900, x = 2138.54, y = -640.77, z = 42.54 }, 
    { name = 'Proprietà 54', price = 1150, x = 2232.81, y = -767.13, z = 43.39 },
    { name = 'Proprietà 55', price = 1275, x = 2253.73, y = -795.19, z = 44.07 },  
    { name = 'Proprietà 56', price = 1325, x = 2369.5, y = -860.25, z = 42.93 },
    { name = 'Proprietà 57', price = 5600, x = 2550.72, y = -917.52, z = 42.9 }, 
    { name = 'Proprietà 58', price = 600, x = 2625.45, y = -909.49, z = 42.91 }, 
    { name = 'Proprietà 59', price = 600, x = 2638.72, y = -924.69, z = 42.98 },
    { name = 'Proprietà 60', price = 655, x = 2634.93, y = -935.9, z = 43.22 },
    { name = 'Proprietà 61', price = 910, x = 2659.82, y = -961.68, z = 44.53 }, 
    { name = 'Proprietà 62', price = 65258, x = 1011.44, y = -1771.9, z = 47.49 },
    { name = 'Proprietà 63', price = 3250, x = 1107.52, y = -1299.76, z = 66.31 },
    { name = 'Proprietà 64', price = 12075, x = 1899.52, y = -1864.54, z = 43.05 }, 
    { name = 'Proprietà 65', price = 13500, x = 1782.81, y = -87.93, z = 56.71 }, 
	
    { name = 'Proprietà 66', price = 11500, x = 1369.17, y = -871.4, z = 70.03 },
    { name = 'Proprietà 67', price = 7825, x = 1132.61, y = -976.55, z = 69.3 }, 
    { name = 'Proprietà 68', price = 3250, x = 900.26, y = 259.04, z = 115.91 }, 
    { name = 'Proprietà 69', price = 13500, x = 1112.8, y = 487.46, z = 97.18 }, 
    { name = 'Proprietà 70', price = 700, x = 1173.67, y = -188.06, z = 100.73 },  
    { name = 'Proprietà 71', price = 700, x = 1172.61, y = -181.21, z = 100.72 }, 
    { name = 'Proprietà 72', price = 5200, x = 1264.55, y = -402.71, z = 97.51 },
    { name = 'Proprietà 73', price = 3250, x = 1624.39, y = -360.54, z = 75.8 },
    { name = 'Proprietà 74', price = 600, x = 1785.07, y = -402.07, z = 47.34 },
    { name = 'Proprietà 75', price = 600, x = 1708.9, y = -408.98, z = 49.37 },
	
    { name = 'Proprietà 76', price = 3250, x = 1887.06, y = 303.61, z = 76.97 }, 
    { name = 'Proprietà 77', price = 3250, x = 1864.8, y = 588.2, z = 113.83 },
    { name = 'Proprietà 78', price = 1700, x = 1251.78, y = 1156.51, z = 151.1 },
    { name = 'Proprietà 79', price = 3250, x = -59.91, y = -391.03, z = 72.11 },
	
    { name = 'Proprietà 80', price = 10250, x = 340.83, y = -666.4, z = 42.72 },
    { name = 'Proprietà 81', price = 600, x = 1389.4, y = -2085.64, z = 52.47 },
    { name = 'Proprietà 82', price = 7250, x = 1319.5, y = -2282.41, z = 50.44 },
    { name = 'Proprietà 83', price = 3250, x = 827.46, y = -1912.28, z = 42.4 },
    { name = 'Proprietà 84', price = 3250, x = 856.99, y = -1906.98, z = 44.45 },
    { name = 'Proprietà 85', price = 2250, x = 862.47, y = -1926.13, z = 44.73 },
    { name = 'Proprietà 86', price = 3250, x = 877.56, y = -1929.79, z = 46.44 },
    { name = 'Proprietà 87', price = 3250, x = 903.74, y = -1923.2, z = 46.2 },
    { name = 'Proprietà 88', price = 3250, x = 881.91, y = -1899.46, z = 45.68 },
    { name = 'Proprietà 89', price = 3250, x = 893.85, y = -1865.73, z = 43.56 },
    { name = 'Proprietà 90', price = 15000, x = 776.23, y = 850.3, z = 118.91 },
    { name = 'Proprietà 91', price = 1000, x = -2022.77, y = -3032.47, z = -9.65 },
    { name = 'Proprietà 92', price = 1500, x = -1412.96, y = -2670.62, z = 42.17 },
    { name = 'Proprietà 93', price = 1500, x = 2498.94, y = -422.66, z = 44.37 },
    { name = 'Proprietà 94', price = 5200, x = -2595.27, y = 460.61, z = 147.0 },
	{ name = 'Proprietà 95', price = 324, x = -554.7385, y = 2698.969, z = 320.4272 },

}

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        for k,v in pairs(properties) do
            if Vdist(coords, v.x, v.y, v.z) < 4.5 then
                Citizen.InvokeNative(0x2A32FAA57B937173, 0x6903B113, v.x, v.y, v.z-0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 100, 1, 1, 190, false, true, 2, false, false, false, false)
                if Vdist(coords, v.x, v.y, v.z) < 1.5 then
                	nearestproperty = v.name
                	nearestpropertyprice = v.price
                	sellprice = math.ceil(v.price / 2)
                    DrawTxt('Premi [E] per aprire [~t6~'..v.name..'~s~] il Menù Proprietà', 0.50, 0.95, 0.6, 0.6, true, 255, 255, 255, 255, true, 10000)
                    if IsControlJustReleased(0, 0xDFF812F9 ) then
                    	TriggerServerEvent('spaghetti_proprieta:loadpropertyinfo', nearestproperty, nearestpropertyprice)
                        TriggerServerEvent('spaghetti_proprieta:getItems', nearestproperty)
                        TriggerServerEvent('spaghetti_proprieta:loadplayerinventory')
                        TriggerServerEvent('spaghetti_proprieta:getOutfits')
                    	Wait(250)
                        WarMenu.OpenMenu('Properties')
                    end
                end
            end
        end
    end
end)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    Citizen.InvokeNative(0xADA9255D, 10);
    DisplayText(str, x, y)
end

local loadblips = false

--[[Citizen.CreateThread(function()
	if not loadblips then
		for _, info in pairs(properties) do
	        local blip = N_0x554d9d53f696d002(1664425300, info.x, info.y, info.z)
	        SetBlipSprite(blip, 1586273744, 1)
			SetBlipScale(blip, 0.2)
			Citizen.InvokeNative(0x9CB1A1623062F402, blip, info.name)
	    end  
	    loadblips = true
	end
end)--]]

Citizen.CreateThread(function()
    WarMenu.CreateMenu('Properties', "Spaghetti: Proprietà")
    WarMenu.SetSubTitle('Properties', 'Benvenuto a casa')
    WarMenu.CreateSubMenu('sellproperty', 'Properties', 'Vendi Proprietà')
    WarMenu.CreateSubMenu('outfits', 'Properties', 'Vestiti Salvati')
    while true do
        local coords = GetEntityCoords(PlayerPedId())

        if WarMenu.IsMenuOpened('Properties') then

            if available == 0 then
        		if WarMenu.MenuButton(nearestproperty..' [Tasse: ~t6~$'..math.ceil(propertytaxes)..' ~s~Mensile]', 'Properties') then
	            end
	            if WarMenu.MenuButton('Acquista [~t6~$'..nearestpropertyprice..'~s~]', 'Properties') then
	            	TriggerServerEvent('spaghetti_proprieta:purchaseproperty', nearestproperty, nearestpropertyprice)
	            	print(nearestproperty)
	            	WarMenu.CloseMenu('Properties')
	            end
	            --if WarMenu.MenuButton('Proprietà Tasse: ~t6~$'..math.ceil(propertytaxes), 'Properties') then
                --end
            elseif available == 1 then
                if actualclient ~= propertyowner then
                    if WarMenu.MenuButton("~t2~*Un cartello è affisso in questa casa:*", 'Properties') then
                    end
                    if WarMenu.MenuButton("~t8~! STA LONTANO DA CASA MIA !", 'Properties') then
                    end
                 print("Devo scrivere")
                else

 	       		if WarMenu.MenuButton(nearestproperty..' [Tasse: ~t6~$'..math.ceil(propertytaxes)..' ~s~Mensile]', 'Properties') then
	            end
	        	if WarMenu.MenuButton('Proprietario: ~t6~'..propertyfirstname..' '..propertylastname, 'Properties') then
	            end
	            if WarMenu.MenuButton('Tassa Mensile: ~t6~'..propertytaxduedate, 'Properties') then
	            end
	            --if WarMenu.MenuButton('Proprietà Tasse: ~t6~$'..math.ceil(propertytaxes), 'Properties') then
                --end
	            if WarMenu.MenuButton('Paga in Anticipo (Tassa+1$) [~t6~$'..propertytaxpaid..'~s~]', 'Properties') then
        	        AddTextEntry("FMMC_MPM_TYP8", "NON SCRIVERE LETTERE O BUGGI TUTTO :")
                    DisplayOnscreenKeyboard(1, "FMMC_MPM_TYP8", "", "1", "", "", "", 30)
                    while (UpdateOnscreenKeyboard() == 0) do
                        DisableAllControlActions(0);
                        Citizen.Wait(0);
                    end
                    if (GetOnscreenKeyboardResult()) then
                        Amount = GetOnscreenKeyboardResult()
                        if tonumber(Amount) ~= tonumber(0) and nil then
	            			TriggerServerEvent('spaghetti_proprieta:deposittaxpayment', tonumber(Amount), nearestpropertyprice)
	            			WarMenu.CloseMenu('Properties')
                        else
                            local _source = source
	            			TriggerEvent("vorp:TipBottom", _source, "Quantità invalida!", 2000)
	            			WarMenu.CloseMenu('Properties')
	            		end
	            	end
	            end
	          --  if WarMenu.MenuButton('Vestiti Salvati', 'outfits') then
	          --  end
                if WarMenu.MenuButton('Magazzino', 'Properties') then
                    TriggerServerEvent("house:reloadHouseInventory", nearestpropertyprice)
                    TriggerEvent("vorp_inventory:OpenHouseInventory", "Deposito", nearestpropertyprice)
                    WarMenu.CloseMenu("Properties")
                    
	            end
	          --  if WarMenu.MenuButton('Prendi Item', 'remove') then
	          --  end
	            if WarMenu.MenuButton('Vendi Proprietà', 'sellproperty') then
                end 
            end
	        else
	        	if WarMenu.MenuButton(nearestproperty, 'Properties') then
	            end
	        	if WarMenu.MenuButton('Owner: ~t6~'..propertyowner, 'Properties') then
	            end
	        end
            if WarMenu.MenuButton('Chiudi Menù', 'Properties') then
                WarMenu.CloseMenu('Properties')
            end
        elseif WarMenu.IsMenuOpened('sellproperty') then
	    	if WarMenu.Button('Vendi la Proprietà per [~t6~$'..sellprice..'~s~]') then
        		TriggerServerEvent('spaghetti_proprieta:sellproperty', nearestproperty, nearestpropertyprice, sellprice)
        		WarMenu.CloseMenu('Properties')
    		end
        elseif WarMenu.IsMenuOpened('outfits') then
                TriggerEvent('spaghetti_proprieta:putOutfitsInTable', outfits)
                if WarMenu.Button(propertyoutfits[k].name) then
                	WarMenu.CloseMenu('Properties')
                end
	    end
	    WarMenu.Display()
        Citizen.Wait(0)
    end
end)


RegisterNetEvent('spaghetti_proprieta:loadpropertyinfo')
AddEventHandler('spaghetti_proprieta:loadpropertyinfo', function(buy, owner, taxes, taxduedate, paidtaxes, lastname, firstname, month,cliente)
local _source = source
    propertyowner = owner
    propertylastname = lastname
    propertyfirstname = firstname
	propertytaxes = taxes
	propertytaxduedate = taxduedate
	propertytaxpaid = paidtaxes
    available = buy
    propertymonth = month
    actualclient = cliente

    TriggerServerEvent("spaghetti:tasse", _source, propertyowner, propertytaxduedate, propertytaxpaid, propertytaxes, nearestpropertyprice, nearestproperty, propertymonth)
    print('Tassa Proprietà:'..propertytaxes)
end)

RegisterNetEvent('spaghetti_proprieta:getplayerItems')
AddEventHandler('spaghetti_proprieta:getplayerItems', function(playeritems)
    --inventory = exports.redemrp_inventory:getItems()
    --print(json.encode(exports.redemrp_inventory:getItems()))
end)

RegisterNetEvent('spaghetti_proprieta:getItems')
AddEventHandler('spaghetti_proprieta:getItems', function(storeditems)
    propertyinv = storeditems
    print(propertyinv)
end)

RegisterNetEvent("spaghetti_proprieta:getOutfits")
AddEventHandler("spaghetti_proprieta:getOutfits", function(outfit)

    outfits = outfit

end)

RegisterNetEvent('spaghetti_proprieta:putOutfitsInTable')
AddEventHandler('spaghetti_proprieta:putOutfitsInTable', function(outfit)
    propertyoutfits = outfit
        table.insert(Outfits, {propertyoutfits})
end)

RegisterNetEvent('StatusFottutoMenu')
AddEventHandler('StatusFottutoMenu', function(source)
    
    WarMenu.CloseMenu()

end)