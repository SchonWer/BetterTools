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

function getToolType()
	local sToolType = DB.getValue(getDatabaseNode(), "tooltype", "");
	if sToolType ~= "" then
		return sToolType;
	end

	local sName = StringManager.trim(name.getValue());
	if sName == "Kochutensilien" then
		return "cooking";
	elseif sName == "Brauerausrüstung" then
		return "brewing";
	elseif sName == "Schmiedewerkzeug" then
		return "smithing";
	elseif sName == "Gerberwerkzeug" then
		return "tanning";
	elseif sName == "Juwelierwerkzeug" then
		return "jeweler";
	elseif sName == "Stoff- & Schusterwerkzeug" then
		return "clothier";
	elseif sName == "Kräuterkundeausrüstung" then
		return "herbalism";
	elseif sName == "Alchemistenausrüstung" then
		return "alchemy";
	elseif sName == "Freizeitset" then
		return "leisure";
	elseif sName == "Angelausrüstung" then
		return "fishing";
	end
	return "";
end

function openToolLink()
	local sToolType = self.getToolType();
	if sToolType == "cooking" then
		self.openCookingToolWindow();
		return;
	end
	if sToolType == "brewing" then
		self.openBrewingToolWindow();
		return;
	end
	if sToolType == "smithing" then
		self.openSmithingToolWindow();
		return;
	end
	if sToolType == "tanning" then
		self.openTanningToolWindow();
		return;
	end
	if sToolType == "jeweler" then
		self.openJewelerToolWindow();
		return;
	end
	if sToolType == "clothier" then
		self.openClothierToolWindow();
		return;
	end
	if sToolType == "herbalism" then
		self.openHerbalismToolWindow();
		return;
	end
	if sToolType == "alchemy" then
		self.openAlchemyToolWindow();
		return;
	end
	if sToolType == "leisure" then
		self.openLeisureToolWindow();
		return;
	end
	if sToolType == "fishing" then
		self.openFishingToolWindow();
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

function openTanningToolWindow()
	local nodeTool = getDatabaseNode();
	local nodeChar = DB.getChild(nodeTool, "...");
	local nodeTanning = DB.createChild(nodeChar, "bettertools.tanning");
	DB.setValue(nodeTanning, "name", "string", "Gerberwerkzeug");
	DB.setValue(nodeTanning, "text", "formattedtext", BetterToolsTanningManager.getToolText());
	Interface.openWindow("ref_ability", nodeTanning);
end

function openJewelerToolWindow()
	local nodeTool = getDatabaseNode();
	local nodeChar = DB.getChild(nodeTool, "...");
	local nodeJeweler = DB.createChild(nodeChar, "bettertools.jeweler");
	DB.setValue(nodeJeweler, "name", "string", "Juwelierwerkzeug");
	DB.setValue(nodeJeweler, "text", "formattedtext", BetterToolsJewelerManager.getToolText());
	Interface.openWindow("ref_ability", nodeJeweler);
end

function openClothierToolWindow()
	local nodeTool = getDatabaseNode();
	local nodeChar = DB.getChild(nodeTool, "...");
	local nodeClothier = DB.createChild(nodeChar, "bettertools.clothier");
	DB.setValue(nodeClothier, "name", "string", "Stoff- & Schusterwerkzeug");
	DB.setValue(nodeClothier, "text", "formattedtext", BetterToolsClothierManager.getToolText());
	Interface.openWindow("ref_ability", nodeClothier);
end

function openHerbalismToolWindow()
	local nodeTool = getDatabaseNode();
	local nodeChar = DB.getChild(nodeTool, "...");
	local nodeHerbalism = DB.createChild(nodeChar, "bettertools.herbalism");
	DB.setValue(nodeHerbalism, "name", "string", "Kräuterkundeausrüstung");
	DB.setValue(nodeHerbalism, "text", "formattedtext", BetterToolsHerbalismManager.getToolText());
	Interface.openWindow("bettertools_herbalism", nodeHerbalism);
end

function openAlchemyToolWindow()
	local nodeTool = getDatabaseNode();
	local nodeChar = DB.getChild(nodeTool, "...");
	local nodeAlchemy = DB.createChild(nodeChar, "bettertools.alchemy");
	DB.setValue(nodeAlchemy, "name", "string", "Alchemistenausrüstung");
	DB.setValue(nodeAlchemy, "text", "formattedtext", BetterToolsAlchemyManager.getToolText());
	BetterToolsAlchemyManager.ensureDefaultRows(nodeAlchemy);
	Interface.openWindow("bettertools_alchemy", nodeAlchemy);
end

function openLeisureToolWindow()
	local nodeTool = getDatabaseNode();
	local nodeChar = DB.getChild(nodeTool, "...");
	local nodeLeisure = DB.createChild(nodeChar, "bettertools.leisure");
	DB.setValue(nodeLeisure, "name", "string", "Freizeitset");
	DB.setValue(nodeLeisure, "text", "formattedtext", BetterToolsLeisureManager.getToolText());
	BetterToolsLeisureManager.ensureDefaultRows(nodeLeisure);
	Interface.openWindow("bettertools_leisure", nodeLeisure);
end

function openFishingToolWindow()
	local nodeTool = getDatabaseNode();
	local nodeChar = DB.getChild(nodeTool, "...");
	local nodeFishing = DB.createChild(nodeChar, "bettertools.fishing");
	DB.setValue(nodeFishing, "name", "string", "Angelausrüstung");
	DB.setValue(nodeFishing, "text", "formattedtext", BetterToolsFishingManager.getToolText());
	Interface.openWindow("ref_ability", nodeFishing);
end

function action(draginfo)
	local nodeTool = getDatabaseNode();
	local nodeChar = DB.getChild(nodeTool, "...");
	local rActor = ActorManager.resolveActor(nodeChar);
	ActionSkill.performRoll(draginfo, rActor, nodeTool);
	return true;
end

