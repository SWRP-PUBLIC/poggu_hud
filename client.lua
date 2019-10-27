ESX = nil
local lastJob = nil
local isAmmoboxShown = false
local PlayerData = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(10)
  end
  Citizen.Wait(3000)
  if PlayerData == nil or PlayerData.job == nil then
	  	PlayerData = ESX.GetPlayerData()
	end
	SendNUIMessage({
		action = 'initGUI',
		data = { whiteMode = Config.enableWhiteBackgroundMode, enableAmmo = Config.enableAmmoBox, colorInvert = Config.disableIconColorInvert }
	})
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('poggu_hud:retrieveData')
AddEventHandler('poggu_hud:retrieveData', function(data)
	SendNUIMessage({
		action = 'setMoney',
		cash = data.cash,
		bank = data.bank,
		black_money = data.black_money,
		society = data.society
	})
end)

function showAlert(message, time, color)
	SendNUIMessage({
		action = 'showAlert',
		message = message,
		time = time,
		color = color
	})
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		TriggerServerEvent('poggu_hud:retrieveData')

		--[[
		ESX.TriggerServerCallback('poggu_hud:retrieveData', function(data)
				SendNUIMessage({
					action = 'setMoney',
					cash = data.cash,
					bank = data.bank,
					black_money = data.black_money,
					society = data.society
				})
		end)
		]]--
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(9000)
		if(PlayerData ~= nil) then
			local jobName = PlayerData.job.label..' - '..PlayerData.job.grade_label
			if(lastJob ~= jobName) then
				lastJob = jobName
				SendNUIMessage({
					action = 'setJob',
					data = jobName
				})
			end
		end
	end
end)

Citizen.CreateThread(function()
 while true do
		Citizen.Wait(200)
		if Config.enableAmmoBox then
			local playerPed = GetPlayerPed(-1)
			local weapon, hash = GetCurrentPedWeapon(playerPed, 1)
			if(weapon) then
				isAmmoboxShown = true
				local _,ammoInClip = GetAmmoInClip(playerPed, hash)
				SendNUIMessage({
						action = 'setAmmo',
						data = ammoInClip..'/'.. GetAmmoInPedWeapon(playerPed, hash) - ammoInClip
				})
			else
				if isAmmoboxShown then
					isAmmoboxShown = false
					SendNUIMessage({
						action = 'hideAmmobox'
					})
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsControlJustPressed(1, 56) then
			SendNUIMessage({
				action = 'showAdvanced'
			})
		end
	end
end)