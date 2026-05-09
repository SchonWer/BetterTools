function onInit()
	if DB.getValue(getDatabaseNode(), "quantity", nil) == nil then
		quantity.setValue(1);
	end
	self.syncEffectFromTable();
	self.updateSortFields();
	self.onLockModeChanged(WindowManager.getWindowReadOnlyState(self));
end

function onLockModeChanged(bReadOnly)
	WindowManager.callSafeControlsSetLockMode(self, { "rarity", "effectno", "name", "effecttext", "effectcode" }, bReadOnly);
	idelete.setVisible(not bReadOnly);
	idelete_spacer.setVisible(bReadOnly);
end

function updateSortFields()
	local tOrder = {
		common = 1,
		rare = 2,
		veryrare = 3,
	};
	sort_rarity.setValue(tOrder[rarity.getValue()] or 9);
	sort_effectno.setValue(effectno.getValue());
	sort_name.setValue(StringManager.trim(name.getValue()):lower());
end

function onRarityChanged()
	self.syncEffectFromTable();
end

function onEffectNoChanged()
	self.syncEffectFromTable();
end

function syncEffectFromTable()
	local nEffectNo = effectno.getValue();
	local sRarity = rarity.getValue();
	if nEffectNo <= 0 or sRarity == "" then
		effecttext.setValue("");
		effectcode.setValue("");
		return;
	end

	local tEffect = BetterToolsCookingManager.getEffectData(sRarity, nEffectNo);
	effecttext.setValue(tEffect.text or "");
	effectcode.setValue(tEffect.code or "");
end

function rollEffect()
	local sName = StringManager.trim(name.getValue());
	if sName == "" then
		ChatManager.SystemMessage("BetterTools: Benenne die Zutat, bevor du ihren Effekt auswürfelst.");
		return;
	end

	local sRarity = rarity.getValue();
	if sRarity == "" then
		ChatManager.SystemMessage("BetterTools: Wähle eine Seltenheit für " .. sName .. ".");
		return;
	end

	if effectno.getValue() > 0 or StringManager.trim(effecttext.getValue()) ~= "" then
		ChatManager.SystemMessage("BetterTools: " .. sName .. " hat bereits einen bekannten Effekt.");
		return;
	end

	if BetterToolsCookingManager.getEffect(sRarity, 1) == "" then
		ChatManager.SystemMessage("BetterTools: Unbekannte Seltenheit für " .. sName .. ".");
		return;
	end

	BetterToolsCookingManager.performEffectRoll(getDatabaseNode());
end
