script_name("{ff7e14}electrocompany")
script_author("{ff7e14}solodi")

local encoding = require 'encoding'

encoding.default = 'cp1251'
local u8 = encoding.UTF8
local function recode(u8) return encoding.UTF8:decode(u8) end

local sampev = require("lib.samp.events")
local inicfg = require("inicfg")
local inifilename = "contractconfig.ini"
local ini = inicfg.load({
	contracts = {
		cont = "0"
	}
}, inifilename)
inicfg.save(ini, inifilename)

local myc = 0

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end

	sampAddChatMessage('{F48B8C}[INFO] {ffffff}Скрипт {ff7e14}"electrocompany" {ffffff}готов к работе! Автор: {ff7e14}solodi', -1)

	sampRegisterChatCommand("co", function()
		sampAddChatMessage("{DE3163}Contracts: {FFFFFF}" .. ini.contracts.cont, -1)
	end)
	
	while true do
		wait(0)
		
    end    
end

function sampev.onServerMessage(color, text)

	if text:find("%Вы успешно заключили контракт с домом №.+ на предоставление энергетических услуг") then
		ini.contracts.cont = ini.contracts.cont + 1
		inicfg.save(ini, inifilename)
	end

end

function sampev.onShowDialog(id, style, title, button1, button2, text)
    if id == 27012 then
		sampSendDialogResponse(27012, 1)
	    return false
    end
end
