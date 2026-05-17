local ROLL_TYPE = "bettertools_leisure_play";

local _tCategoryOrder = {
	"strength_games", "strength_instruments",
	"dexterity_games", "dexterity_instruments",
	"constitution_games", "constitution_instruments",
	"intelligence_games", "intelligence_instruments",
	"wisdom_games", "wisdom_instruments",
	"charisma_games", "charisma_instruments",
};

local _tCategories = {
	strength_games = { label = "Kraftspiele", ability = "strength" },
	strength_instruments = { label = "Schlaginstrumente", ability = "strength" },
	dexterity_games = { label = "Geschicklichkeitsspiele", ability = "dexterity" },
	dexterity_instruments = { label = "Zupfinstrumente", ability = "dexterity" },
	constitution_games = { label = "Gesellschaftsspiele", ability = "constitution" },
	constitution_instruments = { label = "Blasinstrumente", ability = "constitution" },
	intelligence_games = { label = "Strategiespiele", ability = "intelligence" },
	intelligence_instruments = { label = "Streichinstrumente", ability = "intelligence" },
	wisdom_games = { label = "Deduktionsspiele", ability = "wisdom" },
	wisdom_instruments = { label = "Tasteninstrumente", ability = "wisdom" },
	charisma_games = { label = "Glücksspiele", ability = "charisma" },
	charisma_instruments = { label = "Exotikinstrumente", ability = "charisma" },
};

local _tAbilityLabels = {
	strength = "Stärke",
	dexterity = "Geschicklichkeit",
	constitution = "Konstitution",
	intelligence = "Intelligenz",
	wisdom = "Weisheit",
	charisma = "Charisma",
};

function onInit()
	ActionsManager.registerModHandler(ROLL_TYPE, BetterToolsLeisureManager.modPlayRoll);
	ActionsManager.registerResultHandler(ROLL_TYPE, BetterToolsLeisureManager.onPlayRoll);
end

function getToolText()
	return [[<formattedtext>
<h>Freizeitset</h>
<p><i>Genutztes Attribut: Alle</i></p>
<p>Übung mit einem Freizeitset erlaubt es dir, dein Geschick im Spiel und musikalisches Talent dafür zu nutzen, um Berühmtheit und die damit verbundenen Vorteile zu erlangen.</p>
<p>Du stellst dir dein Freizeitset selbst aus Spielsets und Instrumenten zusammen. Die Kosten und das Gewicht sind von deiner Auswahl abhängig.</p>
<h>Fertigkeiten</h>
<p>Folgende Beispiele zeigen auf, inwiefern andere Fertigkeiten von der Übung mit einem Freizeitset profitieren könnten. Es handelt sich dabei lediglich um Vorschläge; sei kreativ!</p>
<p><b>Auftreten.</b> Sowohl auf der Bühne wie an einem Kneipentisch mit aufgesetztem Pokerface hast du gelernt, deine Mimik und Gestik kontrolliert einzusetzen. Das hilft sowohl dabei die Aufmerksamkeit auf dich zu ziehen, wie sie in andere Richtungen zu leiten.</p>
<p><b>Motiv Erkennen.</b> Sowohl um den Pot zu gewinnen als auch, um die richtigen Stücke für deinen Auftritt auszusuchen, musst du einigermaßen wissen, was im Inneren deiner Gegenüber vor sich geht.</p>
<p><b>Fingerfertigkeit.</b> Flinke Finger sind nicht nur hilfreich, um bei einem Spiel zu betrügen, sondern auch, um dir deinen Einsatz wiederzuholen, wenn dein Gegner besser betrogen hat.</p>
<h>Kategorien von Spielen und Instrumenten</h>
<p>Du kannst in insgesamt drei Kategorien von Spielen oder Instrumenten geübt sein. Zum Beispiel könntest du in Kraftspielen, Schlaginstrumenten und Tasteninstrumenten geübt sein. Jede Kategorie macht von einem anderen Attribut Gebrauch, wenn du einen Wurf mit deinem Freizeitset ablegen musst. Die untenstehende Tabelle zeigt dir die Verteilung der Kategorien.</p>
<p>Hast du mindestens eine Stufe in der Barden-Klasse, kannst du Charisma als Attribut für jede Kategorie verwenden.</p>
<table>
<tr><td><b>Genutztes Attribut</b></td><td><b>Spiele</b></td><td><b>Instrumente</b></td></tr>
<tr><td><b>Stärke</b></td><td>Kraftspiele (Armdrücken, Goblinweitwurf, Tauziehen)</td><td>Schlaginstrumente (Trommel, Pauke, Glockenspiel)</td></tr>
<tr><td><b>Geschicklichkeit</b></td><td>Geschicklichkeitsspiele (Hufeisenwerfen, Barbarenschach, Darts)</td><td>Zupfinstrumente (Laute, Harfe, Zither)</td></tr>
<tr><td><b>Konstitution</b></td><td>Gesellschaftsspiele (Zwergenhalma, Despotoly, Ork ogere dich nicht)</td><td>Blasinstrumente (Trompete, Flöte, Saxophon)</td></tr>
<tr><td><b>Intelligenz</b></td><td>Strategiespiele (Schach, Mühle, Dame)</td><td>Streichinstrumente (Geige, Kontrabass, Drehleier)</td></tr>
<tr><td><b>Weisheit</b></td><td>Deduktionsspiele (Dunkler Elf, Werwölfe, Zwei Halblinge Ein Gnom)</td><td>Tasteninstrumente (Klavier, Orgel, Akkordeon)</td></tr>
<tr><td><b>Charisma</b></td><td>Glücksspiele (Poker, Elf hoch, Halblingskniffel)</td><td>Exotikinstrumente (Theremin, Kastagnetten, fiktive Instrumente)</td></tr>
</table>
<h>Spielen</h>
<p>Um zu spielen brauchst du mindestens 1 Stunde an Zeit. Du kannst pro Langer Rast ein Mal spielen.</p>
<h>Ruhm</h>
<p>Nach jedem Spiel machst du einen Freizeitset-Wurf. Das Ergebnis dieses Wurfes bestimmt, wie viel Ruhm du erhältst. Ruhm bezeichnet deine Bekanntheit innerhalb einer Region. In den untenstehenden Tabellen siehst du, wie viel Ruhm du durch deinen Wurf erhältst und welche Summe an Ruhm benötigt wird, um eine jeweilige Stufe an Bekanntheit zu erreichen.</p>
<p>Auch wenn du nur in einer Region gespielt hast, kann man anderswo von dir gehört haben. Ein NPC kann einen Geschichte-Wurf ablegen, um zu bestimmen, ob er dich kennt und du die entsprechenden Vorteile deines Bekanntheitsgrades von ihm erhältst. Der SG dieses Wurfes ist abhängig von deinem Bekanntheitsgrad.</p>
<table>
<tr><td><b>SG</b></td><td><b>Erhaltener Ruhm</b></td></tr>
<tr><td>-</td><td>-10</td></tr>
<tr><td>10</td><td>5</td></tr>
<tr><td>15</td><td>10</td></tr>
<tr><td>20</td><td>25</td></tr>
<tr><td>25</td><td>100</td></tr>
<tr><td>30</td><td>500</td></tr>
</table>
<p></p>
<table>
<tr><td><b>Menge an Ruhm</b></td><td><b>Bekanntheitsgrad</b></td><td><b>Erkennungs-SG</b></td></tr>
<tr><td>-100</td><td>Verhasst</td><td>10</td></tr>
<tr><td>-5</td><td>Unbeliebt</td><td>15</td></tr>
<tr><td>0</td><td>Unbekannt</td><td>25</td></tr>
<tr><td>100</td><td>Bekannt</td><td>15</td></tr>
<tr><td>500</td><td>Beliebt</td><td>10</td></tr>
<tr><td>1000</td><td>Berühmtheit</td><td>5</td></tr>
<tr><td>2000</td><td>Legende</td><td>0</td></tr>
</table>
<h>Vorteile</h>
<p>Je bekannter du bist, desto größere Vorteile erhältst du. In der untenstehenden Tabelle kannst du die genauen Vorteile jedes Bekanntheitsgrades einsehen.</p>
<table>
<tr><td><b>Vorteile</b></td><td><b>Verhasst</b></td><td><b>Unbeliebt</b></td><td><b>Unbekannt</b></td><td><b>Bekannt</b></td><td><b>Beliebt</b></td><td><b>Berühmt</b></td><td><b>Legende</b></td></tr>
<tr><td><b>Rabatt</b></td><td>+20%</td><td>+10%</td><td>0%</td><td>10%</td><td>15%</td><td>20%</td><td>25%</td></tr>
<tr><td><b>Geld</b></td><td>0</td><td>0</td><td>1d4 SP</td><td>1d4 GP</td><td>2d10 GP</td><td>10d10 GP</td><td>10d10 PP</td></tr>
<tr><td><b>Items</b></td><td>-</td><td>-</td><td>Kinkerlitzchen</td><td>Gewöhnlich (Arkan)</td><td>Ungewöhnlich (Arkan)</td><td>Selten (Arkan)</td><td>Sehr selten (Arkan)</td></tr>
<tr><td><b>Unterkunft</b></td><td>Unerwünscht</td><td>-</td><td>-</td><td>Moderat</td><td>Bequem</td><td>Wohlhabend</td><td>Edel</td></tr>
<tr><td><b>Reisemöglichkeiten</b></td><td>Unerwünscht</td><td>-</td><td>Landreise</td><td>Wasserreise</td><td>Luftreise</td><td>Teleportation</td><td>Sphärenreise</td></tr>
</table>
<p>Die Vorteile Rabatt, Unterkunft und Reisemöglichkeiten stehen dir zur Verfügung, sobald du den jeweiligen Bekanntheitsgrad erreichst. Mit Erreichen eines Bekanntheitsgrades erhältst du einen zufälligen Gegenstand aus der entsprechenden Kategorie. Nach jedem Mal Spielen erhältst du eine Menge an Geld, die deinem aktuellen Bekanntheitsgrad entspricht.</p>
<h>Zwischen den Abenteuern</h>
<p>Verweilst du länger an einem Ort, fällt es dir leichter an Ruhm zu kommen. Mach für jede Woche, die du an einem Ort verbringst, einen Freizeitset-Wurf. Addiere zu dem Ergebnis jeweils die Anzahl an Wochen, die du insgesamt an dem Ort bleibst. Bleibst du drei Wochen, addierst du also zu jedem deiner drei Würfe eine +3.</p>
</formattedtext>]];
end

function ensureDefaultRows(nodeLeisure)
	if not nodeLeisure then
		return;
	end
	for nIndex = 1, 3 do
		local nodeEntry = DB.createChild(nodeLeisure, "activities.slot" .. nIndex);
		DB.setValue(nodeEntry, "order", "number", nIndex);
		if DB.getValue(nodeEntry, "category", "") == "" then
			DB.setValue(nodeEntry, "category", "string", _tCategoryOrder[nIndex] or "strength_games");
		end
		BetterToolsLeisureManager.updateActivity(nodeEntry);
	end
	local tRegions = DB.getChildList(nodeLeisure, "regions");
	if #tRegions == 1 then
		local nodeRegion = tRegions[1];
		if DB.getValue(nodeRegion, "name", "") == "Startregion" and DB.getValue(nodeRegion, "fame", 0) == 0 then
			if DB.deleteNode then
				local bDeleted = pcall(DB.deleteNode, nodeRegion);
				if not bDeleted then
					pcall(DB.deleteNode, DB.getPath(nodeRegion));
				end
			end
		end
	end
end

function getCategoryLabel(sCategory)
	return (_tCategories[sCategory or ""] or _tCategories.strength_games).label;
end

function getCategoryAbility(sCategory)
	return (_tCategories[sCategory or ""] or _tCategories.strength_games).ability;
end

function getAbilityLabel(sAbility)
	return _tAbilityLabels[sAbility or ""] or sAbility or "";
end

function getActivityAbility(nodeActivity)
	local nodeLeisure = DB.getChild(nodeActivity, "...");
	local nodeChar = nodeLeisure and DB.getChild(nodeLeisure, "...") or nil;
	if BetterToolsLeisureManager.hasBardLevel(nodeChar) then
		return "charisma";
	end
	return BetterToolsLeisureManager.getCategoryAbility(DB.getValue(nodeActivity, "category", "strength_games"));
end

function updateActivity(nodeActivity)
	if not nodeActivity then
		return;
	end
	local sCategory = DB.getValue(nodeActivity, "category", "strength_games");
	local sAbility = BetterToolsLeisureManager.getActivityAbility(nodeActivity);
	DB.setValue(nodeActivity, "categorylabel", "string", BetterToolsLeisureManager.getCategoryLabel(sCategory));
	DB.setValue(nodeActivity, "ability", "string", sAbility);
	DB.setValue(nodeActivity, "abilitylabel", "string", BetterToolsLeisureManager.getAbilityLabel(sAbility));
	DB.setValue(nodeActivity, "bonus", "number", BetterToolsLeisureManager.getActivityBonus(nodeActivity));
end

function openCategoryPicker(nodeActivity)
	if not nodeActivity then
		return;
	end
	local nodePicker = DB.createChild(nodeActivity, "categorypicker");
	DB.setValue(nodePicker, "name", "string", "Spiel / Instrument ausw\195\164hlen");
	DB.setValue(nodePicker, "targetpath", "string", DB.getPath(nodeActivity));
	Interface.openWindow("bettertools_leisure_category_picker", nodePicker);
end

function chooseCategory(nodeActivity, sCategory)
	if not nodeActivity then
		return;
	end
	if not _tCategories[sCategory or ""] then
		return;
	end
	DB.setValue(nodeActivity, "category", "string", sCategory);
	BetterToolsLeisureManager.updateActivity(nodeActivity);
end

function getActivityBonus(nodeActivity)
	local nodeLeisure = DB.getChild(nodeActivity, "...");
	local nodeChar = nodeLeisure and DB.getChild(nodeLeisure, "...") or nil;
	local rActor = ActorManager.resolveActor(nodeChar);
	local rRoll = BetterToolsLeisureManager.getPlayRollFromTool(nodeActivity, rActor);
	return rRoll and rRoll.nMod or 0;
end

function performPlay(nodeActivity)
	if not nodeActivity then
		return;
	end
	BetterToolsLeisureManager.updateActivity(nodeActivity);
	local nodeLeisure = DB.getChild(nodeActivity, "...");
	local nodeRegion = BetterToolsLeisureManager.getSelectedRegion(nodeLeisure);
	if not nodeRegion then
		ChatManager.SystemMessage("BetterTools: Wähle zuerst eine Region aus.");
		return;
	end

	local nodeChar = DB.getChild(nodeLeisure, "...");
	local rActor = ActorManager.resolveActor(nodeChar);
	local sCategory = DB.getValue(nodeActivity, "categorylabel", BetterToolsLeisureManager.getCategoryLabel(DB.getValue(nodeActivity, "category", "")));
	local rRoll = BetterToolsLeisureManager.getPlayRollFromTool(nodeActivity, rActor);
	if not rRoll then
		ChatManager.SystemMessage("BetterTools: Freizeitset nicht im Tools-Tab gefunden.");
		return;
	end
	rRoll.sType = ROLL_TYPE;
	rRoll.sDesc = (rRoll.sDesc or "") .. "\r[Freizeitset: " .. sCategory .. "]\r[Region: " .. DB.getValue(nodeRegion, "name", "Region") .. "]";
	rRoll.sLeisurePath = DB.getPath(nodeLeisure);
	rRoll.sRegionPath = DB.getPath(nodeRegion);
	rRoll.sCategory = sCategory;
	ActionsManager.performAction(nil, rActor, rRoll);
end

function getPlayRollFromTool(nodeActivity, rActor)
	if not nodeActivity then
		return nil;
	end
	local nodeLeisure = DB.getChild(nodeActivity, "...");
	local nodeChar = nodeLeisure and DB.getChild(nodeLeisure, "...") or nil;
	local nodeTool = BetterToolsLeisureManager.getToolNode(nodeChar);
	if not nodeTool then
		return nil;
	end

	local sAbility = BetterToolsLeisureManager.getActivityAbility(nodeActivity);
	local sOldStat = DB.getValue(nodeTool, "stat", "");
	DB.setValue(nodeTool, "stat", "string", sAbility);
	local bOk, rRoll = pcall(ActionSkill.getRoll, rActor, nodeTool);
	DB.setValue(nodeTool, "stat", "string", sOldStat);
	if bOk then
		return rRoll;
	end
	return nil;
end

function modPlayRoll(rSource, rTarget, rRoll)
	local sType = rRoll.sType;
	rRoll.sType = "skill";
	ActionCheck.modRoll(rSource, rTarget, rRoll);
	rRoll.sType = sType;
	return true;
end

function onPlayRoll(rSource, _, rRoll)
	if ActionsManager2 and ActionsManager2.setupD20RollResolve then
		ActionsManager2.setupD20RollResolve(rRoll, rSource);
	end
	local nodeRegion = DB.findNode(rRoll.sRegionPath or "");
	local nTotal = rRoll.nTotal or ActionsManager.total(rRoll);
	local nFameGain = BetterToolsLeisureManager.getFameGain(nTotal);
	local tLines = {};

	if nodeRegion then
		local nOldFame = DB.getValue(nodeRegion, "fame", 0);
		local nNewFame = nOldFame + nFameGain;
		DB.setValue(nodeRegion, "fame", "number", nNewFame);
		BetterToolsLeisureManager.updateRegion(nodeRegion);
		table.insert(tLines, string.format("Ruhm: %+d (%d -> %d) in %s.", nFameGain, nOldFame, nNewFame, DB.getValue(nodeRegion, "name", "Region")));
		table.insert(tLines, "Bekanntheitsgrad: " .. BetterToolsLeisureManager.getFameRank(nNewFame).label .. ".");
	else
		table.insert(tLines, string.format("Ruhm: %+d.", nFameGain));
	end

	local rMessage = ActionsManager.createActionMessage(rSource, rRoll);
	rMessage.text = rMessage.text .. "\r" .. table.concat(tLines, "\r");
	Comm.deliverChatMessage(rMessage);
end

function getFameGain(nTotal)
	nTotal = tonumber(nTotal) or 0;
	if nTotal >= 30 then
		return 500;
	elseif nTotal >= 25 then
		return 100;
	elseif nTotal >= 20 then
		return 25;
	elseif nTotal >= 15 then
		return 10;
	elseif nTotal >= 10 then
		return 5;
	end
	return -10;
end

function getFameRank(nFame)
	nFame = tonumber(nFame) or 0;
	if nFame >= 2000 then
		return { label = "Legende", dc = 0 };
	elseif nFame >= 1000 then
		return { label = "Berühmtheit", dc = 5 };
	elseif nFame >= 500 then
		return { label = "Beliebt", dc = 10 };
	elseif nFame >= 100 then
		return { label = "Bekannt", dc = 15 };
	elseif nFame >= 0 then
		return { label = "Unbekannt", dc = 25 };
	elseif nFame >= -5 then
		return { label = "Unbeliebt", dc = 15 };
	end
	return { label = "Verhasst", dc = 10 };
end

function updateRegion(nodeRegion)
	if not nodeRegion then
		return;
	end
	local tRank = BetterToolsLeisureManager.getFameRank(DB.getValue(nodeRegion, "fame", 0));
	DB.setValue(nodeRegion, "rank", "string", tRank.label);
	DB.setValue(nodeRegion, "recognitiondc", "number", tRank.dc);
end

function selectRegion(nodeRegion)
	if not nodeRegion then
		return;
	end
	local nodeRegions = DB.getChild(nodeRegion, "..");
	local sSelectedPath = DB.getPath(nodeRegion);
	for _, nodeOther in ipairs(DB.getChildList(nodeRegions)) do
		DB.setValue(nodeOther, "selected", "number", DB.getPath(nodeOther) == sSelectedPath and 1 or 0);
	end
end

function getSelectedRegion(nodeLeisure)
	if not nodeLeisure then
		return nil;
	end
	for _, nodeRegion in ipairs(DB.getChildList(nodeLeisure, "regions")) do
		if DB.getValue(nodeRegion, "selected", 0) == 1 then
			return nodeRegion;
		end
	end
	return nil;
end

function getToolNode(nodeChar)
	if not nodeChar then
		return nil;
	end
	for _, nodeTool in ipairs(DB.getChildList(nodeChar, "toollist")) do
		if DB.getValue(nodeTool, "tooltype", "") == "leisure" or DB.getValue(nodeTool, "name", "") == "Freizeitset" then
			return nodeTool;
		end
	end
	return nil;
end

function getToolProficiencyBonus(nodeChar)
	local nodeTool = BetterToolsLeisureManager.getToolNode(nodeChar);
	local nProfMult = nodeTool and tonumber(DB.getValue(nodeTool, "prof", 0)) or 0;
	return math.floor(BetterToolsLeisureManager.getProficiencyBonus(nodeChar) * nProfMult);
end

function getProficiencyBonus(nodeChar)
	if not nodeChar then
		return 2;
	end
	local rActor = ActorManager.resolveActor(nodeChar);
	if ActorManager5E and ActorManager5E.getAbilityBonus then
		return math.max(tonumber(ActorManager5E.getAbilityBonus(rActor, "prf")) or 2, 0);
	end
	return math.max(DB.getValue(nodeChar, "profbonus", 2), 0);
end

function getAbilityMod(nodeChar, sAbility)
	if not nodeChar then
		return 0;
	end
	local rActor = ActorManager.resolveActor(nodeChar);
	if ActorManager5E and ActorManager5E.getAbilityBonus then
		return tonumber(ActorManager5E.getAbilityBonus(rActor, sAbility)) or 0;
	end
	local nScore = DB.getValue(nodeChar, "abilities." .. (sAbility or "") .. ".score", 10);
	return math.floor((nScore - 10) / 2);
end

function hasBardLevel(nodeChar)
	if not nodeChar then
		return false;
	end
	for _, nodeClass in ipairs(DB.getChildList(nodeChar, "classes")) do
		local sName = StringManager.trim(DB.getValue(nodeClass, "name", "")):lower();
		if (sName == "bard" or sName == "barde") and DB.getValue(nodeClass, "level", 0) > 0 then
			return true;
		end
	end
	return false;
end
