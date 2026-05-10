function onInit()
	self.onLockModeChanged(WindowManager.getWindowReadOnlyState(self));
end

function onLockModeChanged(bReadOnly)
	local tFields = { "prof", "stat", "misc", };
	WindowManager.callSafeControlsSetLockMode(self, tFields, bReadOnly);
	if self.isCustom() then
		name.setReadOnly(bReadOnly);
	end
	idelete.setVisible(not bReadOnly and self.isCustom());
	idelete_spacer.setVisible(not bReadOnly and not self.isCustom());
end

local _bCustom = true;
function setCustom(state)
	_bCustom = state;

	if _bCustom then
		name.setEnabled(true);
		name.setLine(true);
	else
		name.setEnabled(false);
		name.setLine(false);
	end
	self.onLockModeChanged(WindowManager.getWindowReadOnlyState(self));
end

function isCustom()
	return _bCustom;
end

function openToolLink()
	if StringManager.trim(name.getValue()) == "Kochutensilien" then
		self.openCookingToolWindow();
		return;
	end
	if StringManager.trim(name.getValue()) == "Brauerausrüstung" then
		self.openBrewingToolWindow();
		return;
	end
	if StringManager.trim(name.getValue()) == "Schmiedewerkzeug" then
		self.openSmithingToolWindow();
		return;
	end

	local nodeItem = RecordManager.findRecordByStringI("item", "name", name.getValue());
	if nodeItem then
		Interface.openWindow(LibraryData.getRecordDisplayClass("item"), nodeItem);
	else
		Interface.openWindow("ref_ability", getDatabaseNode());
	end
end

function openCookingToolWindow()
	local nodeTool = getDatabaseNode();
	local nodeChar = DB.getChild(nodeTool, "...");
	local nodeCooking = DB.createChild(nodeChar, "bettertools.cooking");
	DB.setValue(nodeCooking, "name", "string", "Kochutensilien");
	DB.setValue(nodeCooking, "text", "formattedtext", BetterToolsCookingManager.getToolText());
	Interface.openWindow("bettertools_cooking", nodeCooking);
end

function openBrewingToolWindow()
	local nodeTool = getDatabaseNode();
	local nodeChar = DB.getChild(nodeTool, "...");
	local nodeBrewing = DB.createChild(nodeChar, "bettertools.brewing");
	DB.setValue(nodeBrewing, "name", "string", "Brauerausrüstung");
	DB.setValue(nodeBrewing, "text", "formattedtext", BetterToolsBrewingManager.getToolText());
	Interface.openWindow("bettertools_brewing", nodeBrewing);
end

function openSmithingToolWindow()
	local nodeTool = getDatabaseNode();
	local nodeChar = DB.getChild(nodeTool, "...");
	local nodeSmithing = DB.createChild(nodeChar, "bettertools.smithing");
	DB.setValue(nodeSmithing, "name", "string", "Schmiedewerkzeug");
	DB.setValue(nodeSmithing, "text", "formattedtext", BetterToolsSmithingManager.getToolText());
	Interface.openWindow("ref_ability", nodeSmithing);
end

function action(draginfo)
	local nodeTool = getDatabaseNode();
	local nodeChar = DB.getChild(nodeTool, "...");
	local rActor = ActorManager.resolveActor(nodeChar);
	ActionSkill.performRoll(draginfo, rActor, nodeTool);
	return true;
end

