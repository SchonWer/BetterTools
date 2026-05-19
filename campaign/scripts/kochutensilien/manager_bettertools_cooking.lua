local ROLL_TYPE = "bettertools_cooking_effect";
local TEMP_HP_ROLL_TYPE = "bettertools_cooking_temphp";
local RECORD_CATEGORY = "BetterTools";

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
		{ text = "Du würfelst deinen nächsten Attributswurf mit Vorteil (Initiative ausgenommen)", code = "Cooking; ADVCHK; Next attribute check, no init" },
		{ text = "Du bekommst Durchfall und musst dringend auf die Toilette", code = "Cooking; Durchfall" },
		{ text = "Du hast gut gegessen und bist daher glücklich und zufrieden", code = "Cooking; Glücklich und zufrieden" },
		{ text = "Die Mahlzeit war schmackhaft, hinterlässt aber ordentlichen Mundgeruch", code = "Cooking; Ordentlicher Mundgeruch" },
		{ text = "Du erhältst einen Stufe 1-Zauberslot zurück", code = "Cooking; 1st spell slot restored" },
	},
	rare = {
		{ text = "Bonus auf Rüstungsklasse von +1", code = "Cooking; AC: 1" },
		{ text = "Bonus auf Angriffswürfe von +1", code = "Cooking; ATK: 1" },
		{ text = "Du kannst unterwasser atmen", code = "Cooking; Breathe underwater" },
		{ text = "Flugbewegungsrate von 10 ft.", code = "Cooking; Fly Speed 10" },
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
		{ text = "Du erhältst Dunkelsicht bis zu 60 ft. (120 ft., wenn deine Spezies schon 60 ft. besitzt)", code = "Cooking; VISION: 60 darkvision" },
		{ text = "Bewegungsrate von +10 ft.", code = "Cooking; Speed +10" },
		{ text = "Du erhältst einen Zauberslot der Stufe 3 oder niedriger zurück", code = "Cooking; spell slot level 3 or lower restored" },
	},
	veryrare = {
		{ text = "Bonus auf Rüstungsklasse von +2", code = "Cooking; AC: 2" },
		{ text = "Bonus auf Angriffswürfe von +2", code = "Cooking; ATK: 2" },
		{ text = "Du provozierst keine Gelegenheitsangriffe", code = "Cooking; no opportunity attacks" },
		{ text = "Resistenz gegen nichtmagischen Hieb-, Stich- und Wuchtschaden", code = "Cooking; RESIST: bludgeoning, piercing, slashing, !magic" },
		{ text = "Du erfährst den Effekt des Vergrößern/Verkleinern-Zaubers ohne Konzentration", code = "Cooking; Enlarge/Reduce, no concentration" },
		{ text = "4W4 + 16 temporäre TP", code = "Cooking; 4d4 + 16 temp HP" },
		{ text = "Wenn du zum ersten Mal auf 0 TP fällst, fällst du stattdessen auf 1 TP und der Angreifer erhält 5W10 Energieschaden", code = "Cooking; 1st down = 1HP, 5d10 force DMG" },
		{ text = "Bonus auf Initiative von +2 und Vorteil bei Initiativewürfen", code = "Cooking; ADVINIT; INIT: 2" },
		{ text = "Du kannst ein Mal einen fehlgeschlagenen Angriffs-, Attributs- oder Rettungswurf wiederholen", code = "Cooking; 1x reroll failed atk/Attribute/save" },
		{ text = "Du regenerierst 5 TP zu Beginn deiner Runde, außer du beginnst sie mit 0 TP", code = "Cooking; REGEN: 5" },
		{ text = "Du erhältst eine zusätzliche Reaktion pro Runde", code = "Cooking; additional reaction" },
		{ text = "Du erhältst die Effekte einer kurzen Rast", code = "Cooking; short rest effects" },
		{ text = "Schwimm-/Kletterbewegungsrate +20 ft.", code = "Cooking; +20ft. fly/swim/burrow" },
		{ text = "Bonus auf Schadenswürfe in Höhe des Übungsbonus", code = "Cooking; DMG: [PRF]" },
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
	ActionsManager.registerResultHandler(TEMP_HP_ROLL_TYPE, BetterToolsCookingManager.onTempHPRoll);
	BetterToolsCookingManager.ensureEffectTables();
end

function encodeXML(s)
	if UtilityManager and UtilityManager.encodeXML then
		return UtilityManager.encodeXML(s or "");
	end
	return (s or ""):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub("\"", "&quot;");
end

function getEffectTableLinks()
	local tRarities = { "common", "rare", "veryrare" };
	local tLines = {
		"<h>Effekttabellen</h>",
	};

	BetterToolsCookingManager.ensureEffectTables();

	local bHasAnyLink = false;
	for _, sRarity in ipairs(tRarities) do
		local sTableName = BetterToolsCookingManager.getEffectTableName(sRarity);
		local nodeTable = BetterToolsCookingManager.findEffectTable(sRarity);
		if nodeTable then
			if not bHasAnyLink then
				table.insert(tLines, "<linklist>");
				bHasAnyLink = true;
			end
			table.insert(tLines, string.format("<link class=\"table\" recordname=\"%s\">%s</link>", BetterToolsCookingManager.encodeXML(DB.getPath(nodeTable)), BetterToolsCookingManager.encodeXML(sTableName)));
		end
	end

	if bHasAnyLink then
		table.insert(tLines, "</linklist>");
	else
		table.insert(tLines, "<list>");
		for _, sRarity in ipairs(tRarities) do
			table.insert(tLines, "<li><b>Table:</b> " .. BetterToolsCookingManager.encodeXML(BetterToolsCookingManager.getEffectTableName(sRarity)) .. "</li>");
		end
		table.insert(tLines, "</list>");
	end

	return table.concat(tLines, "\n");
end

function getToolText()
	return [[<formattedtext>
<h>Kochutensilien</h>
<p><i>Genutztes Attribut: Keines</i></p>
<p>Kochutensilien werden verwendet, um Mahlzeiten für Abenteurer, Edelleute und alle anderen zuzubereiten, die mehr als einfach nur Nahrung wollen. Die so kreierten Rezepte sind die Erkennungsmerkmale ihrer Köche und mitunter auch mit einer Prise Magie versehen.</p>
<p>Kochutensilien beinhalten einen Metalltopf, Messer, Gabeln und Löffel und eine Kelle, ebenso wie mehrere kleinere Behälter zur Aufbewahrung von Gewürzen, Flüssigkeiten und dergleichen. Sie wiegen 8 Pfund und kosten 1 Gold.</p>
<h>Fertigkeiten</h>
<p><b>Naturkunde, Überleben.</b> Als Koch bist du mit so einigen Zutaten in Kontakt gekommen und weißt daher so einiges über die Verträglichkeit verschiedener Pflanzen und Pilze. Ebenso weißt du, wie du dir Zutaten beschaffen kannst, seien sie nun tierischer oder pflanzlicher Natur.</p>
<p><b>Nachforschungen.</b> Man ist was man isst und daher lassen sich viele Aussagen über eine Person anhand ihres Essens machen. Wie reich ist sie, woher kommt sie, war sie in Eile, war sie hungrig oder nicht? Diese und weitere Fragen kannst du beantworten, indem du andere beim Essen beobachtest oder den Ort der Mahlzeit im Nachhinein untersuchst.</p>
<p><b>Heilkunde.</b> Wenn du auch kein Apotheker bist, so kennst du doch das eine oder andere Hausmittel gegen diverse Beschwerden und Krankheiten. Ebenso kannst du erkennen, ob einem Mahl womöglich Stoffe hinzugefügt wurden, die sich normalerweise nicht darin finden, sei es ein Gift oder etwas anderes.</p>
<h>Kochen</h>
<p>Im Folgenden werden Gerichte im Sinne von Essen beschrieben, das so meisterhaft gekocht wurde, dass es besondere Effekte hervorruft. Wenn du normal kochen willst, ohne einen Effekt zu erzielen, kannst du dies tun, ohne diese Regeln zu beachten.</p>
<h>Zutaten</h>
<p>Ein Gericht besteht der Einfachheit halber aus minimal zwei und maximal drei verschiedenen Zutaten. Was genau als eigenstehende Zutat zählt und was nicht, obliegt dem Ermessen des SLs.</p>
<p>Jede Zutat gehört einem Seltenheitsgrad an: Gewöhnlich, Selten oder Sehr Selten. Jedes Mal, wenn du eine Zutat zum ersten Mal zum Kochen verwendest, würfelst du einen W20 auf der zu der Seltenheit gehörenden Effekttabelle. Der Effekt einer Zutat bleibt immer derselbe, egal in welcher Kombination mit anderen Zutaten sie verwendet wird.</p>
<p>Du kannst maximal zwei Zutaten desselben Seltenheitsgrades in einem Gericht verwenden. Kochst du mit einer dritten Zutat, muss diese einen anderen Seltenheitsgrad haben. Würfelst du mit zwei Zutaten in einem Gericht denselben Effekt, so wird dieser nicht verstärkt.</p>
<p>Du kannst pro Langer Rast nur den Effekt einer neuen Zutat erfahren. In Downtime entscheidet der SL, wie viele neue Zutaten du verarbeiten kannst.</p>
<h>Zutaten besorgen</h>
<p>Gewöhnliche Zutaten findest du meist auf Märkten, bei Jägern, Bäckern, Metzgern, Bauern und ähnlichen Personen. Seltene Zutaten werden eher von besonderen Köchen, Magiern oder anderen Personen aufbewahrt. Sehr seltene Materialien stammen fast ausschließlich von Monstern und sind in der Regel schwer zu bekommen.</p>
<h>Zeitdauer und Portionen</h>
<p>Ein Gericht zu kochen dauert 1 Stunde. Du kannst auch während einer kurzen Rast kochen, ohne ihre Effekte zu verlieren.</p>
<p>Ein Gericht reicht für dich und deine Gruppe, unabhängig von ihrer Größe. Alternativ kannst du bis zu vier andere mittelgroße Kreaturen ernähren. Sind es große Kreaturen, reicht es für zwei von ihnen oder für eine einzelne riesige Kreatur.</p>
<p>Ein Gericht muss innerhalb von 24 Stunden verzehrt werden, ansonsten wird es zu gewöhnlichen Rationen. Wurde ein Gericht verzehrt, hält der Effekt 24 Stunden oder bis zur nächsten Langen Rast an. Eine Kreatur kann nur einmal pro Kurzer Rast von einem Gericht profitieren und auch nur von einem Gericht gleichzeitig.</p>
]] .. BetterToolsCookingManager.getEffectTableLinks() .. [[
</formattedtext>]];
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

function cookSelectedIngredients(wCooking)
	if not wCooking or not wCooking.list then
		return;
	end

	local tIngredients = {};
	local tRarityCount = {};

	for _, w in pairs(wCooking.list.getWindows()) do
		if w.use and w.use.getValue() == 1 then
			local sName = StringManager.trim(w.name.getValue());
			local sRarity = w.rarity.getValue();
			local nEffectNo = w.effectno.getValue();
			local nQuantity = w.quantity.getValue();

			if sName == "" then
				ChatManager.SystemMessage("BetterTools: Eine ausgewählte Zutat hat keinen Namen.");
				return;
			end
			if sRarity == "" then
				ChatManager.SystemMessage("BetterTools: " .. sName .. " hat keine Seltenheit.");
				return;
			end
			if nQuantity <= 0 then
				ChatManager.SystemMessage("BetterTools: " .. sName .. " ist nicht mehr vorhanden.");
				return;
			end
			if nEffectNo <= 0 then
				ChatManager.SystemMessage("BetterTools: " .. sName .. " hat noch keinen bekannten Effekt.");
				return;
			end

			local tEffect = BetterToolsCookingManager.getEffectData(sRarity, nEffectNo);
			local sEffectText = StringManager.trim(tEffect.text or "");
			local sEffectCode = StringManager.trim(tEffect.code or "");
			if sEffectText == "" then
				ChatManager.SystemMessage("BetterTools: Für " .. sName .. " wurde in der passenden Effekt-Tabelle kein Effekt gefunden.");
				return;
			end

			tRarityCount[sRarity] = (tRarityCount[sRarity] or 0) + 1;
			table.insert(tIngredients, {
				window = w,
				name = sName,
				rarity = sRarity,
				effectno = nEffectNo,
				quantity = nQuantity,
				effecttext = sEffectText,
				effectcode = sEffectCode,
			});
		end
	end

	if #tIngredients < 2 or #tIngredients > 3 then
		ChatManager.SystemMessage("BetterTools: Wähle 2 bis 3 Zutaten zum Kochen aus.");
		return;
	end
	for _, nCount in pairs(tRarityCount) do
		if nCount > 2 then
			ChatManager.SystemMessage("BetterTools: Maximal zwei Zutaten desselben Seltenheitsgrades sind erlaubt.");
			return;
		end
	end

	local nodeChar = DB.getChild(wCooking.getDatabaseNode(), "...");
	local rActor = ActorManager.resolveActor(nodeChar);
	local tTargets = TargetingManager.getFullTargets(rActor) or {};
	if #tTargets <= 0 then
		ChatManager.SystemMessage("BetterTools: Visiere mindestens ein Ziel an, bevor das Gericht gekocht und verbraucht wird.");
		return;
	end

	for _, tIngredient in ipairs(tIngredients) do
		tIngredient.window.effecttext.setValue(tIngredient.effecttext);
		tIngredient.window.effectcode.setValue(tIngredient.effectcode);
		tIngredient.window.quantity.setValue(tIngredient.quantity - 1);
		tIngredient.window.use.setValue(0);
	end

	local tLines = {};
	table.insert(tLines, "kocht ein Gericht mit:");
	for _, tIngredient in ipairs(tIngredients) do
		local sLine = "- " .. tIngredient.name .. " (" .. (BetterToolsCookingManager.getRarityLabel(tIngredient.rarity) or tIngredient.rarity);
		if tIngredient.effectno > 0 then
			sLine = sLine .. ", Effekt " .. tIngredient.effectno;
		end
		sLine = sLine .. ")";
		if tIngredient.effecttext ~= "" then
			sLine = sLine .. ": " .. tIngredient.effecttext;
		else
			sLine = sLine .. ": Effekt noch nicht notiert.";
		end
		if tIngredient.effectcode ~= "" then
			sLine = sLine .. "\r  FG-Code: " .. tIngredient.effectcode;
		end
		table.insert(tLines, sLine);
	end
	table.insert(tLines, "");
	table.insert(tLines, "Dauer: 24 Stunden oder bis zur nächsten Langen Rast.");
	table.insert(tLines, "Eine Kreatur kann nur von einem Gericht gleichzeitig profitieren.");

	local nApplied = 0;
	local nTempHPRolls = 0;
	for _, rTarget in ipairs(tTargets) do
		for _, tIngredient in ipairs(tIngredients) do
			if not BetterToolsCookingManager.getTempHPFormula(tIngredient.effectcode) and tIngredient.effectcode ~= "" then
				EffectManager.addEffectByTable(rTarget, {
					sName = tIngredient.effectcode,
					sSource = ActorManager.getCTNodeName(rActor),
					sExpiration = "restlong",
				});
				nApplied = nApplied + 1;
			end
		end
	end
	for _, tIngredient in ipairs(tIngredients) do
		if BetterToolsCookingManager.performTempHPRoll(rActor, tTargets, tIngredient.name, tIngredient.effectcode) then
			nTempHPRolls = nTempHPRolls + 1;
		end
	end

	table.insert(tLines, "");
	local sAppliedLine = "Angewendete Effekte: " .. nApplied .. " auf " .. #tTargets .. " Ziel(e).";
	if nTempHPRolls > 0 then
		sAppliedLine = sAppliedLine .. " Temp-TP-Würfe: " .. nTempHPRolls .. ".";
	end
	table.insert(tLines, sAppliedLine);

	local msg = ChatManager.createBaseMessage(rActor);
	msg.text = table.concat(tLines, "\r");
	Comm.deliverChatMessage(msg);
end

function getTempHPFormula(sEffectCode)
	local sCode = string.lower(StringManager.trim(sEffectCode or ""));
	if sCode == "" then
		return nil;
	end

	local sDiceCount, sDiceSides, sSign, sMod = sCode:match("(%d*)d(%d+)%s*([%+%-])%s*(%d+)%s*temp%s*hp");
	if sDiceSides then
		local nDiceCount = tonumber(sDiceCount);
		if not nDiceCount or nDiceCount <= 0 then
			nDiceCount = 1;
		end
		local nMod = tonumber(sMod) or 0;
		if sSign == "-" then
			nMod = -nMod;
		end
		return { dice = nDiceCount, sides = tonumber(sDiceSides) or 0, mod = nMod };
	end

	sDiceCount, sDiceSides = sCode:match("(%d*)d(%d+)%s*temp%s*hp");
	if sDiceSides then
		local nDiceCount = tonumber(sDiceCount);
		if not nDiceCount or nDiceCount <= 0 then
			nDiceCount = 1;
		end
		return { dice = nDiceCount, sides = tonumber(sDiceSides) or 0, mod = 0 };
	end

	local sFlat = sCode:match("(%d+)%s*temp%s*hp");
	if sFlat then
		return { dice = 0, sides = 0, mod = tonumber(sFlat) or 0 };
	end

	return nil;
end

function rollTempHP(sEffectCode)
	local tFormula = BetterToolsCookingManager.getTempHPFormula(sEffectCode);
	if not tFormula then
		return nil;
	end

	local nTotal = tFormula.mod or 0;
	local tRolls = {};
	for _ = 1, tFormula.dice or 0 do
		local nRoll = math.random(tFormula.sides or 1);
		table.insert(tRolls, nRoll);
		nTotal = nTotal + nRoll;
	end

	local sFormula;
	if (tFormula.dice or 0) > 0 then
		sFormula = string.format("%dd%d", tFormula.dice, tFormula.sides);
		if (tFormula.mod or 0) > 0 then
			sFormula = sFormula .. " + " .. tFormula.mod;
		elseif (tFormula.mod or 0) < 0 then
			sFormula = sFormula .. " - " .. math.abs(tFormula.mod);
		end
	else
		sFormula = tostring(tFormula.mod or 0);
	end

	return {
		total = math.max(nTotal, 0),
		formula = sFormula,
		rolls = table.concat(tRolls, ", "),
	};
end

function getActorNodePath(rActor)
	if not rActor then
		return "";
	end

	local nodeActor = ActorManager.getCreatureNode(rActor);
	if nodeActor then
		return DB.getPath(nodeActor);
	end

	if ActorManager.getCTNode then
		local nodeCT = ActorManager.getCTNode(rActor);
		if nodeCT then
			return DB.getPath(nodeCT);
		end
	end

	return "";
end

function performTempHPRoll(rActor, tTargets, sIngredientName, sEffectCode)
	local tFormula = BetterToolsCookingManager.getTempHPFormula(sEffectCode);
	if not tFormula then
		return false;
	end

	local tTargetPaths = {};
	for _, rTarget in ipairs(tTargets or {}) do
		local sTargetPath = BetterToolsCookingManager.getActorNodePath(rTarget);
		if sTargetPath ~= "" then
			table.insert(tTargetPaths, sTargetPath);
		end
	end
	if #tTargetPaths == 0 then
		return false;
	end

	local aDice = {};
	for _ = 1, tFormula.dice or 0 do
		table.insert(aDice, "d" .. (tFormula.sides or 1));
	end

	local rRoll = {
		sType = TEMP_HP_ROLL_TYPE,
		sDesc = "[BetterTools] Temporäre TP: " .. (sIngredientName or "Kochutensilien"),
		aDice = aDice,
		nMod = tFormula.mod or 0,
		sTargetPaths = table.concat(tTargetPaths, "|"),
	};
	ActionsManager.performAction(nil, rActor, rRoll);
	return true;
end

function applyTempHP(rActor, nTempHP)
	if not rActor then
		return false, 0;
	end

	local nCurrentTempHP = tonumber(GameManager.getRecordFieldValue(rActor, "hptemp", 0)) or 0;
	if nTempHP > nCurrentTempHP then
		GameManager.setRecordFieldValue(rActor, "hptemp", "number", nTempHP);
		return true, nCurrentTempHP;
	end
	return false, nCurrentTempHP;
end

function getActorDisplayName(rActor)
	local sName = "";
	if ActorManager then
		if ActorManager.getDisplayName then
			sName = ActorManager.getDisplayName(rActor) or "";
		end
		if sName == "" and ActorManager.getActorName then
			sName = ActorManager.getActorName(rActor) or "";
		end
	end
	if sName == "" then
		sName = (rActor and rActor.sName) or "Ziel";
	end
	return sName;
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
	end
end

function ensureEffectTable(sRarity)
	local nodeExisting = BetterToolsCookingManager.findEffectTable(sRarity);
	if nodeExisting then
		BetterToolsCookingManager.setRecordCategory(nodeExisting);
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
	BetterToolsCookingManager.setRecordCategory(nodeTable);
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

function setRecordCategory(nodeRecord)
	if nodeRecord then
		if DB.setCategory then
			DB.setCategory(DB.getPath(nodeRecord), RECORD_CATEGORY);
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

function onTempHPRoll(rSource, _, rRoll)
	local nTempHP = math.max(ActionsManager.total(rRoll), 0);
	local tLines = {};

	for sTargetPath in string.gmatch(rRoll.sTargetPaths or "", "([^|]+)") do
		local nodeTarget = DB.findNode(sTargetPath);
		local rTarget = ActorManager.resolveActor(nodeTarget);
		if rTarget then
			local bTempHPSet, nCurrentTempHP = BetterToolsCookingManager.applyTempHP(rTarget, nTempHP);
			local sTargetName = BetterToolsCookingManager.getActorDisplayName(rTarget);
			if bTempHPSet then
				table.insert(tLines, "Temporäre TP für " .. sTargetName .. " gesetzt: " .. nTempHP .. ".");
			else
				table.insert(tLines, "Temporäre TP für " .. sTargetName .. " bleiben bei " .. nCurrentTempHP .. "; " .. nTempHP .. " wäre niedriger oder gleich.");
			end
		else
			table.insert(tLines, "BetterTools: Ein Ziel wurde für temporäre TP nicht gefunden.");
		end
	end

	local rMessage = ActionsManager.createActionMessage(rSource, rRoll);
	if #tLines > 0 then
		rMessage.text = rMessage.text .. "\r" .. table.concat(tLines, "\r");
	end
	Comm.deliverChatMessage(rMessage);
end
