function onInit()
	if DB.getValue(getDatabaseNode(), "quantity", nil) == nil then
		quantity.setValue(1);
	end
	self.syncEffectFromTable();
	self.updateSortRarity();
	self.onLockModeChanged(WindowManager.getWindowReadOnlyState(self));
end

function onLockModeChanged(bReadOnly)
	WindowManager.callSafeControlsSetLockMode(self, { "rarity", "effectno", "name", "effecttext", "effectcode" }, bReadOnly);
	idelete.setVisible(not bReadOnly);
	idelete_spacer.setVisible(bReadOnly);
end

function updateSortRarity()
	local tOrder = {
		common = 1,
		rare = 2,
		veryrare = 3,
	};
	sort_rarity.setValue(tOrder[rarity.getValue()] or 9);
end

function onRarityChanged()
	self.updateSortRarity();
	self.syncEffectFromTable();
end

function onEffectNoChanged()
	self.syncEffectFromTable();
end

function syncEffectFromTable()
	local nEffectNo = effectno.getValue();
	local sRarity = rarity.getValue();
	if nEffectNo <= 0 or sRarity == "" then
		return;
	end

	local tEffect = BetterToolsCookingManager.getEffectData(sRarity, nEffectNo);
	if (tEffect.text or "") ~= "" then
		effecttext.setValue(tEffect.text);
	end
	if (tEffect.code or "") ~= "" then
		effectcode.setValue(tEffect.code);
	end
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
