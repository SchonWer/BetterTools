local ROLL_TYPE = "bettertools_cooking_effect";

local _tRarityLabels = {
	common = "Gewöhnlich",
	rare = "Selten",
	veryrare = "Sehr selten",
};

local _tTableNames = {
	common = "BetterTools - Kochutensilien - Gewöhnlich",
	rare = "BetterTools - Kochutensilien - Selten",
	veryrare = "BetterTools - Kochutensilien - Sehr selten",
};

local _tEffects = {
	common = {
		{ text = "Bonus auf Akrobatik und Athletik von +2", code = "Cooking; SKILL: 2 athletics, acrobatics" },
		{ text = "Bonus auf Arkane Kunde und Geschichte von +2", code = "Cooking; SKILL: 2 arcana, history" },
		{ text = "Bonus auf Auftreten und Einschüchtern von +2", code = "Cooking; SKILL: 2 performance, intimidation" },
		{ text = "Bonus auf Naturkunde und Überleben von +2", code = "Cooking; SKILL: 2 nature, survival" },
		{ text = "Bonus auf Wahrnehmung und Nachforschungen von +2", code = "Cooking; SKILL: 2 perception, investigation" },
		{ text = "Bonus auf Überzeugen und Täuschen von +2", code = "Cooking; SKILL: 2 persuasion, deception" },
		{ text = "Bonus auf Heilkunde und Religion von +2", code = "Cooking; SKILL: 2 medicine, religion" },
		{ text = "Bonus auf Motiv erkennen und Mit Tieren umgehen von +2", code = "Cooking; SKILL: 2 insight, animal handling" },
		{ text = "Bonus auf Heimlichkeit und Fingerfertigkeit von +2", code = "Cooking; SKILL: 2 stealth, sleight of hand" },
		{ text = "1W4 + 4 temporäre TP", code = "Cooking; 1d4 + 4 temp HP" },
		{ text = "Vorteil auf Todesrettungswürfe", code = "Cooking; ADVDEATH" },
		{ text = "Wenn du zum ersten Mal auf 0 TP fällst, erhält der Angreifer 3W10 Energieschaden", code = "Cooking; 1st down = 3d10 force DMG" },
		{ text = "Bonus auf Initiative von +2", code = "Cooking; INIT: 2" },
		{ text = "Schadensgrenze von 5", code = "Cooking; DT: 5" },
		{ text = "Du würfelst deinen nächsten Angriffswurf mit Vorteil", code = "Cooking; ADVATK; Next roll" },
		{ text = "Du würfelst deinen nächsten Attributswurf mit Vorteil (Initiative ausgenommen)", code = "Cooking; ADV on Attributes, next roll, no init" },
		{ text = "Du bekommst Durchfall und musst dringend auf die Toilette", code = "Cooking; Durchfall" },
		{ text = "Du hast gut gegessen und bist daher glücklich und zufrieden", code = "Cooking; Glücklich und zufrieden" },
		{ text = "Die Mahlzeit war schmackhaft, hinterlässt aber ordentlichen Mundgeruch", code = "Cooking; Ordentlicher Mundgeruch" },
		{ text = "Du erhältst einen Stufe 1-Zauberslot zurück", code = "Cooking; 1st spell slot restored" },
	},
	rare = {
		{ text = "Bonus auf Rüstungsklasse von +1", code = "Cooking; AC: 1" },
		{ text = "Bonus auf Angriffswürfe von +1", code = "Cooking; ATK: 1" },
		{ text = "Du kannst unterwasser atmen", code = "Cooking; underwater breathing" },
		{ text = "Flugbewegungsrate von 10 ft.", code = "Cooking; +10ft. flying" },
		{ text = "Schwimm- und Kletterbewegungsrate von +10 ft.", code = "Cooking; +10ft. swim/climb" },
		{ text = "Du kannst dein Geschlecht ändern", code = "Cooking; Geschlecht ändern" },
		{ text = "Du kannst einmal den Zauber Nebelschritt wirken", code = "Cooking; 1x Misty Step" },
		{ text = "2W4 + 8 temporäre TP", code = "Cooking; 2d4 + 8 temp HP" },
		{ text = "Die Dauer einer Langen Rast wird um 4h reduziert (Minimum 4h)", code = "Cooking; -4h Long rest" },
		{ text = "Wenn du zum ersten Mal auf 0 TP fällst, erhält der Angreifer 5W10 Energieschaden", code = "Cooking; 1st down = 5d10 force DMG" },
		{ text = "Bonus auf Initiative von +5", code = "Cooking; INIT: 5" },
		{ text = "Bonus auf Stärkerettungswürfe von +2", code = "Cooking; SAVE: 2 strength" },
		{ text = "Bonus auf Geschicklichkeitsrettungswürfe von +2", code = "Cooking; SAVE: 2 dexterity" },
		{ text = "Bonus auf Konstitutionsrettungswürfe von +2", code = "Cooking; SAVE: 2 constitution" },
		{ text = "Bonus auf Intelligenzrettungswürfe von +2", code = "Cooking; SAVE: 2 intelligence" },
		{ text = "Bonus auf Weisheitsrettungswürfe von +2", code = "Cooking; SAVE: 2 wisdom" },
		{ text = "Bonus auf Charismarettungswürfe von +2", code = "Cooking; SAVE: 2 charisma" },
		{ text = "Du erhältst Dunkelsicht bis zu 60 ft. (120 ft., wenn deine Spezies schon 60 ft. besitzt)", code = "Cooking; Darkvision +60ft." },
		{ text = "Bewegungsrate von +10 ft.", code = "Cooking; +10ft. movement" },
		{ text = "Du erhältst einen Zauberslot der Stufe 3 oder niedriger zurück", code = "Cooking; spell slot level 3 or lower restored" },
	},
	veryrare = {
		{ text = "Bonus auf Rüstungsklasse von +2", code = "Cooking; AC: 2" },
		{ text = "Bonus auf Angriffswürfe von +2", code = "Cooking; ATK: 2" },
		{ text = "Du provozierst keine Gelegenheitsangriffe", code = "Cooking; no opportunity attacks" },
		{ text = "Resistenz gegen nichtmagischen Hieb-, Stich- und Wuchtschaden", code = "Cooking; RESIST: slashing, piercing, bludgeoning" },
		{ text = "Du erfährst den Effekt des Vergrößern/Verkleinern-Zaubers ohne Konzentration", code = "Cooking; Enlarge/Reduce, no concentration" },
		{ text = "4W4 + 16 temporäre TP", code = "Cooking; 4d4 + 16 temp HP" },
		{ text = "Wenn du zum ersten Mal auf 0 TP fällst, fällst du stattdessen auf 1 TP und der Angreifer erhält 5W10 Energieschaden", code = "Cooking; 1st down = 1HP, 5d10 force DMG" },
		{ text = "Bonus auf Initiative von +2 und Vorteil bei Initiativewürfen", code = "Cooking; ADVINIT; INIT: 2" },
		{ text = "Du kannst ein Mal einen fehlgeschlagenen Angriffs-, Attributs- oder Rettungswurf wiederholen", code = "Cooking; 1x reroll failed atk/Attribute/save" },
		{ text = "Du regenerierst 5 TP zu Beginn deiner Runde, außer du beginnst sie mit 0 TP", code = "Cooking; REGEN: 5" },
		{ text = "Du erhältst eine zusätzliche Reaktion pro Runde", code = "Cooking; additional reaction" },
		{ text = "Du erhältst die Effekte einer kurzen Rast", code = "Cooking; short rest effects" },
		{ text = "Schwimm-/Kletterbewegungsrate +20 ft.", code = "Cooking; +20ft. fly/swim/burrow" },
		{ text = "Bonus auf Schadenswürfe in Höhe des Übungsbonus", code = "Cooking; damage rolls +PB" },
		{ text = "Du kannst einmal Dimensionstür als Bonusaktion wirken", code = "Cooking; 1x Dimension Door" },
		{ text = "Angreifer, die dich mit einem Angriffswurf treffen, erhalten 5 Punkte Schaden", code = "Cooking; enemy takes 5 DMG on hit" },
		{ text = "Stärkewert steigt auf mindestens 20", code = "Cooking; STR = 20" },
		{ text = "Geschicklichkeitswert steigt auf mindestens 20", code = "Cooking; DEX = 20" },
		{ text = "Jeder erfolgreiche Angriff bewegt das Ziel um 5 ft. nach hinten, sofern es nicht Riesig oder größer ist", code = "Cooking; successful attacks push target 5ft." },
		{ text = "Du erhältst einen Zauberslot der Stufe 5 oder niedriger zurück", code = "Cooking; spell slot level 5 or lower restored" },
	},
};

function onInit()
	ActionsManager.registerResultHandler(ROLL_TYPE, BetterToolsCookingManager.onEffectRoll);
	BetterToolsCookingManager.ensureEffectTables();
end

function getEffect(sRarity, nEffectNo)
	return BetterToolsCookingManager.getEffectData(sRarity, nEffectNo).text or "";
end

function getEffectCode(sRarity, nEffectNo)
	return BetterToolsCookingManager.getEffectData(sRarity, nEffectNo).code or "";
end

function getEffectData(sRarity, nEffectNo)
	nEffectNo = tonumber(nEffectNo) or 0;
	if nEffectNo <= 0 then
		return { text = "", code = "" };
	end

	local nodeTable = BetterToolsCookingManager.findEffectTable(sRarity);
	if nodeTable then
		local tEffect = BetterToolsCookingManager.getEffectDataFromTable(nodeTable, nEffectNo);
		if tEffect.text ~= "" or tEffect.code ~= "" then
			return tEffect;
		end
	end

	local tEffects = _tEffects[sRarity];
	if not tEffects then
		return { text = "", code = "" };
	end
	local tEffect = tEffects[nEffectNo];
	if type(tEffect) == "table" then
		return { text = tEffect.text or "", code = tEffect.code or "" };
	end
	return { text = tEffect or "", code = "" };
end

function getRarityLabel(sRarity)
	return _tRarityLabels[sRarity] or sRarity or "";
end

function getEffectTableName(sRarity)
	return _tTableNames[sRarity] or "";
end

function findEffectTable(sRarity)
	local sTableName = BetterToolsCookingManager.getEffectTableName(sRarity);
	if sTableName == "" then
		return nil;
	end

	if TableManager and TableManager.findTable then
		local nodeTable = TableManager.findTable(sTableName);
		if nodeTable then
			return nodeTable;
		end
	end

	for _, nodeTable in ipairs(DB.getChildList("tables")) do
		if DB.getValue(nodeTable, "name", "") == sTableName then
			return nodeTable;
		end
	end
	return nil;
end

function ensureEffectTables()
	if not Session.IsHost then
		return;
	end

	for sRarity, _ in pairs(_tTableNames) do
		BetterToolsCookingManager.ensureEffectTable(sRarity);
		BetterToolsCookingManager.migrateEffectTablePrefix(sRarity);
	end
end

function ensureEffectTable(sRarity)
	if BetterToolsCookingManager.findEffectTable(sRarity) then
		return;
	end

	local tEffects = _tEffects[sRarity];
	if not tEffects then
		return;
	end

	local sTableRoot = "tables";
	if RecordDataManager and RecordDataManager.getDataPathRoot then
		sTableRoot = RecordDataManager.getDataPathRoot("table") or sTableRoot;
	end
	local nodeTable = DB.createChild(sTableRoot);
	if not nodeTable then
		return;
	end

	DB.setValue(nodeTable, "name", "string", BetterToolsCookingManager.getEffectTableName(sRarity));
	DB.setValue(nodeTable, "dice", "dice", { "d20" });
	DB.setValue(nodeTable, "mod", "number", 0);
	DB.setValue(nodeTable, "resultscols", "number", 2);
	DB.setValue(nodeTable, "labelcol1", "string", "Effekt");
	DB.setValue(nodeTable, "labelcol2", "string", "FG-Code");
	DB.setValue(nodeTable, "description", "string", "BetterTools Kochutensilien: " .. BetterToolsCookingManager.getRarityLabel(sRarity));
	DB.setValue(nodeTable, "notes", "formattedtext", "<p>Diese Tabelle darf angepasst werden. Kochutensilien lesen beim Kochen anhand von Seltenheit und Effektnummer live aus Effekt und FG-Code.</p>");

	local nodeRows = DB.createChild(nodeTable, "tablerows");
	if not nodeRows then
		return;
	end

	for nEffectNo, tEffect in ipairs(tEffects) do
		local nodeRow = DB.createChild(nodeRows);
		DB.setValue(nodeRow, "fromrange", "number", nEffectNo);
		DB.setValue(nodeRow, "torange", "number", nEffectNo);

		local nodeResults = DB.createChild(nodeRow, "results");
		local nodeResultText = DB.createChild(nodeResults);
		DB.setValue(nodeResultText, "result", "string", tEffect.text or "");

		local nodeResultCode = DB.createChild(nodeResults);
		DB.setValue(nodeResultCode, "result", "string", tEffect.code or "");
	end
end

function migrateEffectTablePrefix(sRarity)
	local nodeTable = BetterToolsCookingManager.findEffectTable(sRarity);
	if not nodeTable then
		return;
	end

	for _, nodeRow in ipairs(DB.getChildList(nodeTable, "tablerows")) do
		local nodeResults = DB.getChild(nodeRow, "results");
		if nodeResults then
			local tKeys = {};
			local tChildren = DB.getChildren(nodeResults);
			for sKey, _ in pairs(tChildren) do
				table.insert(tKeys, sKey);
			end
			table.sort(tKeys);

			if tKeys[2] then
				local nodeCode = tChildren[tKeys[2]];
				local sCode = DB.getValue(nodeCode, "result", "");
				if sCode:match("^Note:") then
					DB.setValue(nodeCode, "result", "string", "Cooking;" .. sCode:sub(6));
				elseif sCode:match("^Cooking:") then
					DB.setValue(nodeCode, "result", "string", "Cooking;" .. sCode:sub(9));
				elseif not sCode:match("^Cooking;") and StringManager.trim(sCode) ~= "" then
					DB.setValue(nodeCode, "result", "string", "Cooking; " .. sCode);
				end
			end
		end
	end
end

function getEffectDataFromTable(nodeTable, nEffectNo)
	local nodeResults = nil;
	for _, nodeRow in ipairs(DB.getChildList(nodeTable, "tablerows")) do
		local nFrom = DB.getValue(nodeRow, "fromrange", 0);
		local nTo = DB.getValue(nodeRow, "torange", 0);
		if nTo == 0 then
			nTo = nFrom;
		end
		if nEffectNo >= nFrom and nEffectNo <= nTo then
			nodeResults = DB.getChild(nodeRow, "results");
			break;
		end
	end

	if not nodeResults then
		return { text = "", code = "" };
	end

	local tKeys = {};
	local tChildren = DB.getChildren(nodeResults);
	for sKey, _ in pairs(tChildren) do
		table.insert(tKeys, sKey);
	end
	table.sort(tKeys);

	local sText = "";
	local sCode = "";
	if tKeys[1] then
		sText = StringManager.trim(DB.getValue(tChildren[tKeys[1]], "result", ""));
	end
	if tKeys[2] then
		sCode = StringManager.trim(DB.getValue(tChildren[tKeys[2]], "result", ""));
	end

	if sCode == "" and sText ~= "" then
		local sParsedText, sParsedCode = sText:match("^(.-)%s*FG%-Code:%s*(.+)$");
		if not sParsedText then
			sParsedText, sParsedCode = sText:match("^(.-)%s*FG:%s*(.+)$");
		end
		if sParsedText and sParsedCode then
			sText = StringManager.trim(sParsedText);
			sCode = StringManager.trim(sParsedCode);
		end
	end

	return { text = sText, code = sCode };
end

function performEffectRoll(nodeIngredient)
	if not nodeIngredient then
		return;
	end

	local sName = DB.getValue(nodeIngredient, "name", "");
	local sRarity = DB.getValue(nodeIngredient, "rarity", "");
	local nodeChar = DB.getChild(nodeIngredient, ".....");
	local rActor = ActorManager.resolveActor(nodeChar);
	local rRoll = {
		sType = ROLL_TYPE,
		sDesc = "[BetterTools] Effekt auswürfeln: " .. sName .. " (" .. BetterToolsCookingManager.getRarityLabel(sRarity) .. ")",
		aDice = { "d20" },
		nMod = 0,
		sIngredientPath = DB.getPath(nodeIngredient),
	};

	ActionsManager.performAction(nil, rActor, rRoll);
end

function onEffectRoll(rSource, _, rRoll)
	local nodeIngredient = DB.findNode(rRoll.sIngredientPath or "");
	if not nodeIngredient then
		local rMessageMissing = ActionsManager.createActionMessage(rSource, rRoll);
		rMessageMissing.text = rMessageMissing.text .. "\rBetterTools: Die Zutat wurde nicht gefunden.";
		Comm.deliverChatMessage(rMessageMissing);
		return;
	end

	local sRarity = DB.getValue(nodeIngredient, "rarity", "");
	local nRoll = math.max(math.min(ActionsManager.total(rRoll), 20), 1);
	local tEffect = BetterToolsCookingManager.getEffectData(sRarity, nRoll);
	local sEffect = tEffect.text or "";
	local sEffectCode = tEffect.code or "";

	DB.setValue(nodeIngredient, "effectno", "number", nRoll);
	DB.setValue(nodeIngredient, "effecttext", "string", sEffect);
	DB.setValue(nodeIngredient, "effectcode", "string", sEffectCode);

	local rMessage = ActionsManager.createActionMessage(rSource, rRoll);
	rMessage.text = rMessage.text .. string.format("\r%s Zutat, W20 = %d:\r%s\rFG-Code: %s", BetterToolsCookingManager.getRarityLabel(sRarity), nRoll, sEffect, sEffectCode);
	Comm.deliverChatMessage(rMessage);
end
