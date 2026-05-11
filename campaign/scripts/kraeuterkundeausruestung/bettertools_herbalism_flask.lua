function onInit()
	self.syncFields();
	self.onLockModeChanged(WindowManager.getWindowReadOnlyState(self));
end

function onLockModeChanged(bReadOnly)
	WindowManager.callSafeControlsSetLockMode(self, { "herb_button", "herb", "portions" }, bReadOnly);
	idelete.setVisible(false);
	idelete_spacer.setVisible(true);
	self.updateHerbButtonVisibility();
end

function onHerbChanged()
	self.syncFields();
end

function onPortionsChanged()
	self.syncFields();
end

function syncFields()
	local sHerb = herb.getValue();
	herblabel.setValue(BetterToolsHerbalismManager.getHerbLabel(sHerb));
	local nPortions = portions.getValue();
	local nLevel = BetterToolsHerbalismManager.getLevel(nPortions);
	level.setValue(nLevel);

	local nNext = BetterToolsHerbalismManager.getNextPortionGoal(nPortions);
	if nNext > 0 then
		nextgoal.setValue(nNext);
	else
		nextgoal.setValue(0);
	end

	effecttext.setValue(BetterToolsHerbalismManager.getEffect(sHerb, nLevel));
	effectcode.setValue(BetterToolsHerbalismManager.getEffectCode(sHerb, nLevel));
	self.updateHerbButtonVisibility();
end

function updateHerbButtonVisibility()
	local bHasLockedHerb = portions.getValue() > 0 and herb.getValue() ~= "";
	herb_button.setVisible(not bHasLockedHerb);
end

function drink()
	BetterToolsHerbalismManager.drinkFlask(getDatabaseNode());
end

function empty()
	herb.setValue("");
	herblabel.setValue("");
	portions.setValue(0);
	self.syncFields();
end

function openHerbPicker()
	BetterToolsHerbalismManager.openHerbPicker(getDatabaseNode(), "herb");
end
