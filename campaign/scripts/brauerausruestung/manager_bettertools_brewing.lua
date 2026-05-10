local ROLL_TYPE = "bettertools_brewing_drink";

local _tBonusEffects = {
	[1] = {
		{ key = "b1", text = "Temporäre TP in Höhe deines Übungsbonus x 5", code = "" },
	},
	[2] = {
		{ key = "b2_str", text = "Vorteil auf Stärkewürfe", code = "ADVCHK: strength" },
		{ key = "b2_resist", text = "Resistenz gegen Wuchtschaden", code = "RESIST: bludgeoning" },
		{ key = "b2_cha", text = "Vorteil auf Charismawürfe", code = "ADVCHK: charisma" },
	},
	[3] = {
		{ key = "b3", text = "Kritische Treffer geschehen ab einem Würfelergebnis von 18", code = "CRIT: 18" },
	},
	[4] = {
		{ key = "b4_str", text = "Vorteil auf Stärkerettungswürfe", code = "ADVSAV: strength" },
		{ key = "b4_con", text = "Vorteil auf Konstitutionsrettungswürfe", code = "ADVSAV: constitution" },
		{ key = "b4_cha", text = "Vorteil auf Charismarettungswürfe", code = "ADVSAV: charisma" },
	},
	[5] = {
		{ key = "b5", text = "Vorteil auf Angriffswürfe", code = "ADVATK" },
	},
};

local _tMalusEffects = {
	[1] = {
		{ key = "m1", text = "Die Hemmschwelle deines Charakters sinkt", code = "Note: Hemmschwelle sinkt" },
	},
	[2] = {
		{ key = "m2_init", text = "Malus von -5 auf Initiativewürfe", code = "INIT: -5" },
		{ key = "m2_atk", text = "Malus von -1 auf Angriffswürfe", code = "ATK: -1" },
		{ key = "m2_ac", text = "Malus von -1 auf Rüstungsklasse", code = "AC: -1" },
	},
	[3] = {
		{ key = "m3", text = "Nachteil auf Geschicklichkeits-, Intelligenz- und Weisheitswürfe", code = "DISCHK: dexterity, intelligence, wisdom" },
	},
	[4] = {
		{ key = "m4_dex", text = "Nachteil auf Geschicklichkeitsrettungswürfe", code = "DISSAV: dexterity" },
		{ key = "m4_int", text = "Nachteil auf Intelligenzrettungswürfe", code = "DISSAV: intelligence" },
		{ key = "m4_wis", text = "Nachteil auf Weisheitsrettungswürfe", code = "DISSAV: wisdom" },
	},
	[5] = {
		{ key = "m5", text = "Malus auf Bewegungsrate von -10", code = "Note: Bewegungsrate -10" },
	},
	[6] = {
		{ key = "m6", text = "Bewusstlos für 1W4 Stunden; danach Malus 2 und kein Bonus", code = "Unconscious" },
	},
};

function onInit()
	ActionsManager.registerModHandler(ROLL_TYPE, BetterToolsBrewingManager.modDrinkSave);
	ActionsManager.registerResultHandler(ROLL_TYPE, BetterToolsBrewingManager.onDrinkRoll);
end

function getToolText()
	return [[<formattedtext>
<h>Brauerausrüstung</h>
<p><i>Genutztes Attribut: Keines</i></p>
<p>Mit Brauerausrüstung kannst du Bier, Wein, Met und andere alkoholische Getränke und Spirituosen zubereiten. Jeder Becher verleiht dem Trinker bestimmte Vorteile, aber womöglich auch Nachteile. Je mehr getrunken wird, umso höher die Chance auf Boni, aber gleichzeitig steigt das Risiko, negative Effekte zu erhalten.</p>
<p>Brauerausrüstung enthält einige große Krüge, einen Siphon und mehrere Meter Schlauch, außerdem Hopfen, Trauben oder andere Fermentierungsgrundlagen deiner Wahl. Sie wiegt 9 Pfund und kostet 20 Gold.</p>
<h>Fertigkeiten</h>
<p><b>Geschichte.</b> Übung mit Brauerausrüstung gibt zusätzliche Informationen bei Geschichtswürfen bezüglich historischen Ereignissen, bei denen Alkohol eine tragende Rolle gespielt hat.</p>
<p><b>Heilkunde.</b> Du weißt, wie man mit Alkoholvergiftungen umgeht und kannst Alkohol benutzen, um Schmerzen zu lindern.</p>
<p><b>Überzeugen.</b> Ein gutes Getränk macht auch die härtesten Herzen weicher. Übung mit Brauerausrüstung erlaubt es dir, dein Gegenüber mittels eines Getränks zu bearbeiten, sodass sie gerade so viel Alkohol zu sich nimmt, um ihre Laune zu heben.</p>
<h>Brauen</h>
<p>Jedes Getränk braucht 2 Pfund an Rohstoffen, die zu Maische verarbeitet werden. Diese Rohstoffe kannst du in den meisten Läden und jeder Taverne für jeweils 5 Silber kaufen.</p>
<p>Für jedes Getränk, das du brauen möchtest, benötigst du mindestens 1 Stunde Zeit. Brauen zählt nicht als anstrengende Aktivität, weswegen du es auch während einer Kurzen Rast tun und trotzdem deren Effekte erhalten kannst.</p>
<h>Trinken</h>
<p>Jedes Mal wenn ein Charakter trinkt, legt er einen Konstitutionsrettungswurf ab. Der Grund-SG ist 10. Zusätzliche ausgewählte Effekte auf Stufe 2 oder 4 erhöhen den SG jeweils um +5.</p>
<table>
<tr><td><b>Kritischer Erfolg</b></td><td>3 Boni, 1 Malus</td></tr>
<tr><td><b>Erfolg</b></td><td>2 Boni, 1 Malus</td></tr>
<tr><td><b>Misserfolg</b></td><td>1 Bonus, 2 Mali</td></tr>
<tr><td><b>Kritischer Misserfolg</b></td><td>1 Bonus, 3 Mali</td></tr>
</table>
<p>Wenn der Charakter aufhört, bewusstlos wird oder anderweitig am Trinken gehindert wird, gilt das Getränk als verbraucht. Ein Getränk zu trinken, ernährt den Charakter für einen Tag.</p>
<h>Effektstufen</h>
<table>
	<thead>
		<tr>
			<td><b>Boni / Mali</b></td>
			<td colspan="3"><b>Effekte</b></td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><b>Bonus 5</b></td>
			<td colspan="3">Vorteil auf Angriffswürfe</td>
		</tr>
		<tr>
			<td><b>Bonus 4</b></td>
			<td>Vorteil auf Stärkerettungswürfe</td>
			<td>Vorteil auf Konstitutionsrettungswürfe</td>
			<td>Vorteil auf Charismarettungswürfe</td>
		</tr>
		<tr>
			<td><b>Bonus 3</b></td>
			<td colspan="3">Kritische Treffer geschehen ab einem Würfelergebnis von 18</td>
		</tr>
		<tr>
			<td><b>Bonus 2</b></td>
			<td>Vorteil auf Stärkewürfe</td>
			<td>Resistenz gegen Wuchtschaden</td>
			<td>Vorteil auf Charismawürfe</td>
		</tr>
		<tr>
			<td><b>Bonus 1</b></td>
			<td colspan="3">Temporäre TP in Höhe deines Übungsbonus x 5</td>
		</tr>
		<tr>
			<td><b>Neutral</b></td>
			<td colspan="3"></td>
		</tr>
		<tr>
			<td><b>Malus 1</b></td>
			<td colspan="3">Die Hemmschwelle deines Charakters sinkt (hat lediglich Auswirkungen auf das Roleplay)</td>
		</tr>
		<tr>
			<td><b>Malus 2</b></td>
			<td>Malus von -5 auf Initiativewürfe</td>
			<td>Malus von -1 auf Angriffswürfe</td>
			<td>Malus von -1 auf Rüstungsklasse</td>
		</tr>
		<tr>
			<td><b>Malus 3</b></td>
			<td colspan="3">Nachteil auf Geschicklichkeits-, Intelligenz- und Weisheitswürfe.</td>
		</tr>
		<tr>
			<td><b>Malus 4</b></td>
			<td>Nachteil auf Geschicklichkeitsrettungswürfe</td>
			<td>Nachteil auf Intelligenzrettungswürfe</td>
			<td>Nachteil auf Weisheitsrettungswürfe</td>
		</tr>
		<tr>
			<td><b>Malus 5</b></td>
			<td colspan="3">Malus auf Bewegungsrate von -10</td>
		</tr>
		<tr>
			<td><b>Malus 6</b></td>
			<td colspan="3">Dein Charakter wird für 1W4 Stunden bewusstlos und startet danach bei Malus 2 und ohne Bonus</td>
		</tr>
	</tbody>
</table>
</formattedtext>]];
end

function modDrinkSave(rSource, rTarget, rRoll)
	local sType = rRoll.sType;

	ActionsManager2.setupD20RollMod(rRoll);
	rRoll.sSave = "constitution";
	rRoll.sAbility = "constitution";
	rRoll.tSaveFilter = { "constitution" };
	rRoll.sType = "save";
	ActionSave.applyEffectsToRollMod(rRoll, rSource, rTarget);
	ActionsManager2.finalizeEffectsToD20RollMod(rRoll);
	ActionSave.finalizeRollMod(rRoll);
	ActionsManager2.finalizeD20RollMod(rRoll);

	rRoll.sType = sType;
	rRoll.sSave = "constitution";
	rRoll.sAbility = "constitution";
end

function getDrinkDC(nodeDrink)
	return 10 + (BetterToolsBrewingManager.getExtraEffectCount(nodeDrink) * 5);
end

function getExtraEffectCount(nodeDrink)
	local nExtra = 0;
	for _, nStage in ipairs({ 2, 4 }) do
		nExtra = nExtra + math.max(BetterToolsBrewingManager.getSelectedCount(nodeDrink, _tBonusEffects[nStage]) - 1, 0);
		nExtra = nExtra + math.max(BetterToolsBrewingManager.getSelectedCount(nodeDrink, _tMalusEffects[nStage]) - 1, 0);
	end
	return nExtra;
end

function getSelectedCount(nodeDrink, tEffects)
	local nCount = 0;
	for _, tEffect in ipairs(tEffects or {}) do
		if DB.getValue(nodeDrink, tEffect.key, 0) == 1 then
			nCount = nCount + 1;
		end
	end
	return nCount;
end

function ensureDefaultChoices(nodeDrink)
	for _, sKey in ipairs({ "b2_str", "b4_str", "m2_init", "m4_dex" }) do
		if DB.getValue(nodeDrink, sKey, nil) == nil then
			DB.setValue(nodeDrink, sKey, "number", 1);
		end
	end
end

function validateDrinkChoices(nodeDrink)
	if DB.getValue(nodeDrink, "bonuslevel", 0) >= 5 then
		ChatManager.SystemMessage("BetterTools: Dieses Getraenk hat bereits Bonus 5 erreicht. Weiteres Trinken ist nicht moeglich.");
		return false;
	end
	if DB.getValue(nodeDrink, "maluslevel", 0) >= 6 then
		ChatManager.SystemMessage("BetterTools: Dieses Getraenk hat bereits Malus 6 erreicht. Weiteres Trinken ist nicht moeglich.");
		return false;
	end

	local tMissing = {};
	if BetterToolsBrewingManager.getSelectedCount(nodeDrink, _tBonusEffects[2]) <= 0 then
		table.insert(tMissing, "Bonus 2");
	end
	if BetterToolsBrewingManager.getSelectedCount(nodeDrink, _tBonusEffects[4]) <= 0 then
		table.insert(tMissing, "Bonus 4");
	end
	if BetterToolsBrewingManager.getSelectedCount(nodeDrink, _tMalusEffects[2]) <= 0 then
		table.insert(tMissing, "Malus 2");
	end
	if BetterToolsBrewingManager.getSelectedCount(nodeDrink, _tMalusEffects[4]) <= 0 then
		table.insert(tMissing, "Malus 4");
	end

	if #tMissing > 0 then
		ChatManager.SystemMessage("BetterTools: Waehle vor dem Trinken mindestens eine Option fuer " .. table.concat(tMissing, ", ") .. ".");
		return false;
	end
	return true;
end

function performDrinkRoll(nodeDrink)
	if not nodeDrink then
		return;
	end

	BetterToolsBrewingManager.ensureDefaultChoices(nodeDrink);
	if not BetterToolsBrewingManager.validateDrinkChoices(nodeDrink) then
		return;
	end

	local nodeChar = DB.getChild(nodeDrink, ".....");
	local rBrewer = ActorManager.resolveActor(nodeChar);
	local rDrinker = BetterToolsBrewingManager.getDrinkTarget(rBrewer);
	if not rDrinker then
		return;
	end

	local rRoll = ActionSave.getRoll(rDrinker, "constitution");
	rRoll.sType = ROLL_TYPE;
	rRoll.sSave = "constitution";
	rRoll.sAbility = "constitution";
	rRoll.nTarget = BetterToolsBrewingManager.getDrinkDC(nodeDrink);
	rRoll.sDesc = "[BetterTools] Brauerausrüstung: " .. DB.getValue(nodeDrink, "name", "Getränk") .. " [DC " .. rRoll.nTarget .. "]";
	rRoll.sDrinkPath = DB.getPath(nodeDrink);

	ActionsManager.performAction(nil, rDrinker, rRoll);
end

function getDrinkTarget(rBrewer)
	if not rBrewer then
		return nil;
	end

	local tTargets = TargetingManager.getFullTargets(rBrewer);
	if #tTargets == 0 then
		return rBrewer;
	end
	if #tTargets > 1 then
		ChatManager.SystemMessage("BetterTools: Bitte visiere genau eine Kreatur an, die das Getraenk trinkt.");
		return nil;
	end
	return tTargets[1];
end

function onDrinkRoll(rSource, _, rRoll)
	local nodeDrink = DB.findNode(rRoll.sDrinkPath or "");
	if not nodeDrink then
		local rMessageMissing = ActionsManager.createActionMessage(rSource, rRoll);
		rMessageMissing.text = rMessageMissing.text .. "\rBetterTools: Das Getränk wurde nicht gefunden.";
		Comm.deliverChatMessage(rMessageMissing);
		return;
	end

	ActionsManager2.setupD20RollResolve(rRoll, rSource);

	local nTotal = rRoll.nTotal or ActionsManager.total(rRoll);
	local nDie = 0;
	if rRoll.aDice and rRoll.aDice[1] then
		nDie = tonumber(rRoll.aDice[1].result) or tonumber(rRoll.aDice[1].value) or 0;
	end

	local nBonusGain = 1;
	local nMalusGain = 2;
	local sResult = "Misserfolg";
	if nDie == 20 then
		nBonusGain = 3;
		nMalusGain = 1;
		sResult = "Kritischer Erfolg";
	elseif nDie == 1 then
		nBonusGain = 1;
		nMalusGain = 3;
		sResult = "Kritischer Misserfolg";
	elseif nTotal >= (tonumber(rRoll.nTarget) or 10) then
		nBonusGain = 2;
		nMalusGain = 1;
		sResult = "Erfolg";
	end

	local nOldBonus = DB.getValue(nodeDrink, "bonuslevel", 0);
	local nOldMalus = DB.getValue(nodeDrink, "maluslevel", 0);
	local nNewBonus = math.min(nOldBonus + nBonusGain, 5);
	local nNewMalus = math.min(nOldMalus + nMalusGain, 6);
	DB.setValue(nodeDrink, "bonuslevel", "number", nNewBonus);
	DB.setValue(nodeDrink, "maluslevel", "number", nNewMalus);

	local tLines = {};
	table.insert(tLines, string.format("%s gegen DC %d: %d", sResult, tonumber(rRoll.nTarget) or 10, nTotal));
	table.insert(tLines, string.format("Neue Stufen: Bonus %d, Malus %d", nNewBonus, nNewMalus));
	BetterToolsBrewingManager.applyNewStages(rSource, nodeDrink, _tBonusEffects, nOldBonus + 1, nNewBonus, "Bonus", tLines);
	BetterToolsBrewingManager.applyNewStages(rSource, nodeDrink, _tMalusEffects, nOldMalus + 1, nNewMalus, "Malus", tLines);

	if nNewMalus >= 6 then
		DB.setValue(nodeDrink, "bonuslevel", "number", 0);
		DB.setValue(nodeDrink, "maluslevel", "number", 2);
		table.insert(tLines, "Nach Malus 6 wird der Trinkstatus auf Bonus 0 / Malus 2 gesetzt.");
	end

	local rMessage = ActionsManager.createActionMessage(rSource, rRoll);
	rMessage.text = rMessage.text .. "\r" .. table.concat(tLines, "\r");
	Comm.deliverChatMessage(rMessage);
end

function applyNewStages(rActor, nodeDrink, tEffectSet, nFrom, nTo, sLabel, tLines)
	for nStage = nFrom, nTo do
		local tEffects = BetterToolsBrewingManager.getEffectsForStage(nodeDrink, tEffectSet, nStage);
		for _, tEffect in ipairs(tEffects) do
			table.insert(tLines, string.format("%s %d: %s", sLabel, nStage, tEffect.text));
			if tEffect.key == "b1" then
				BetterToolsBrewingManager.applyProficiencyTempHP(rActor, tLines);
			end
			if StringManager.trim(tEffect.code or "") ~= "" and rActor then
				EffectManager.addEffectByTable(rActor, {
					sName = tEffect.code,
					sSource = ActorManager.getCTNodeName(rActor),
					sExpiration = "restlong",
				});
			end
		end
	end
end

function applyProficiencyTempHP(rActor, tLines)
	if not rActor then
		return;
	end

	local nProf = 2;
	if ActorManager5E and ActorManager5E.getAbilityBonus then
		nProf = ActorManager5E.getAbilityBonus(rActor, "prf");
	else
		local nodeActor = ActorManager.getCreatureNode(rActor);
		if nodeActor then
			nProf = DB.getValue(nodeActor, "profbonus", 2);
		end
	end
	nProf = math.max(tonumber(nProf) or 2, 0);

	local nTempHP = nProf * 5;
	local nCurrentTempHP = GameManager.getRecordFieldValue(rActor, "hptemp", 0);
	if nTempHP > nCurrentTempHP then
		GameManager.setRecordFieldValue(rActor, "hptemp", "number", nTempHP);
		table.insert(tLines, string.format("Temporäre TP gesetzt: %d (Übungsbonus %d x 5).", nTempHP, nProf));
	else
		table.insert(tLines, string.format("Temporäre TP bleiben bei %d; Bonus 1 würde %d geben.", nCurrentTempHP, nTempHP));
	end
end

function getEffectsForStage(nodeDrink, tEffectSet, nStage)
	local tEffects = tEffectSet[nStage] or {};
	if nStage ~= 2 and nStage ~= 4 then
		return tEffects;
	end

	local tSelected = {};
	for _, tEffect in ipairs(tEffects) do
		if DB.getValue(nodeDrink, tEffect.key, 0) == 1 then
			table.insert(tSelected, tEffect);
		end
	end
	if #tSelected == 0 and tEffects[1] then
		table.insert(tSelected, tEffects[1]);
	end
	return tSelected;
end
