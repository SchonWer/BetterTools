function onInit()
	if DB.getValue(getDatabaseNode(), "quantity", nil) == nil then
		quantity.setValue(1);
	end
	BetterToolsBrewingManager.ensureDefaultChoices(getDatabaseNode());
	self.updateDC();
	self.onLockModeChanged(WindowManager.getWindowReadOnlyState(self));
end

function onLockModeChanged(bReadOnly)
	WindowManager.callSafeControlsSetLockMode(self, {
		"name",
		"b2_str", "b2_resist", "b2_cha", "b4_str", "b4_con", "b4_cha",
		"m2_init", "m2_atk", "m2_ac", "m4_dex", "m4_int", "m4_wis",
		"bonuslevel", "maluslevel",
	}, bReadOnly);
	idelete.setVisible(not bReadOnly);
	idelete_spacer.setVisible(bReadOnly);
end

function updateDC()
	if dc then
		dc.setValue(BetterToolsBrewingManager.getDrinkDC(getDatabaseNode()));
	end
end

function onChoiceChanged()
	self.updateDC();
end

function drink()
	local sName = StringManager.trim(name.getValue());
	if sName == "" then
		ChatManager.SystemMessage("BetterTools: Benenne das Getraenk, bevor davon getrunken wird.");
		return;
	end
	if quantity.getValue() <= 0 then
		ChatManager.SystemMessage("BetterTools: " .. sName .. " ist nicht mehr vorhanden.");
		return;
	end
	BetterToolsBrewingManager.performDrinkRoll(getDatabaseNode());
end

function finishDrink()
	local sName = StringManager.trim(name.getValue());
	if quantity.getValue() > 0 then
		quantity.setValue(quantity.getValue() - 1);
	end
	bonuslevel.setValue(0);
	maluslevel.setValue(0);
	ChatManager.SystemMessage("BetterTools: " .. (sName ~= "" and sName or "Getraenk") .. " verbraucht; Trinkstatus zurueckgesetzt.");
end
