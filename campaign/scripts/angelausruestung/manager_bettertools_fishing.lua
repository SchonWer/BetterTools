local FISHING_ROLL_TYPE = "bettertools_fishing";
local FISHING_LOOT_ROLL_TYPE = "bettertools_fishing_loot";
local RECORD_CATEGORY = "BetterTools";

local _tSpecialTableNames = {
	uncommon = "BetterTools - Angeln - Ungewöhnliche Gegenstände",
	rare = "BetterTools - Angeln - Seltene Gegenstände",
};

local _tSpecialTables = {
	uncommon = {
		{ 1, "Flöte des Rattenfängers" },
		{ 2, "Perle der Kraft" },
		{ 3, "Dreizack der Fischherrschaft" },
		{ 4, "Ring des Wasserlaufens" },
		{ 5, "Ring des Schwimmens" },
		{ 6, "Mütze der Wasseratmung" },
		{ 7, "Umhang des Mantarochens" },
		{ 8, "Schwebefeder (Anker)" },
	},
	rare = {
		{ 1, "Perle der Macht" },
		{ 2, "Ionenstein (Wahrnehmung)" },
		{ 3, "Ionenstein (Schutz)" },
		{ 4, "Ionenstein (Reserve)" },
		{ 5, "Ionenstein (Stärke)" },
		{ 6, "Tentakelzepter" },
		{ 7, "Haken der Fischerfreude" },
		{ 8, "Schwebefeder (Schwanenboot)" },
	},
};

local _tLootRows = {
	[1] = { fish = "Gewöhnlicher Fisch", portions = 1, rations = 2 },
	[2] = { fish = "Gewöhnlicher Fisch", portions = 1, rations = 2 },
	[3] = { fish = "Gewöhnlicher Fisch", portions = 2, rations = 4 },
	[4] = { fish = "Gewöhnlicher Fisch", portions = 2, rations = 4 },
	[5] = { fish = "Gewöhnlicher Fisch", portions = 3, rations = 6 },
	[6] = { fish = "Gewöhnlicher Fisch", portions = 3, rations = 6 },
	[7] = { fish = "Gewöhnlicher Fisch", portions = 4, rations = 8, ring = "smith" },
	[8] = { fish = "Gewöhnlicher Fisch", portions = 4, rations = 8, ring = "craftsman" },
	[9] = { fish = "Seltener Fisch", portions = 1, rations = 10, ring = "tanner" },
	[10] = { fish = "Seltener Fisch", portions = 1, rations = 10, ring = "alchemist" },
	[11] = { fish = "Seltener Fisch", portions = 2, rations = 20, ring = "healer" },
	[12] = { fish = "Seltener Fisch", portions = 2, rations = 20, ring = "scribe" },
	[13] = { fish = "Seltener Fisch", portions = 3, rations = 30, ring = "smith", enhanced = true },
	[14] = { fish = "Seltener Fisch", portions = 3, rations = 30, ring = "craftsman", enhanced = true },
	[15] = { fish = "Seltener Fisch", portions = 4, rations = 40, ring = "tanner", enhanced = true },
	[16] = { fish = "Seltener Fisch", portions = 4, rations = 40, ring = "alchemist", enhanced = true },
	[17] = { fish = "Sehr seltener Fisch", portions = 1, rations = 50, ring = "healer", enhanced = true },
	[18] = { fish = "Sehr seltener Fisch", portions = 1, rations = 50, ring = "scribe", enhanced = true },
	[19] = { fish = "Sehr seltener Fisch", portions = 2, rations = 100, table = "uncommon" },
	[20] = { fish = "Sehr seltener Fisch", portions = 2, rations = 100, table = "rare" },
};

local _tRingOrder = {
	"smith", "craftsman", "tanner", "alchemist", "healer", "scribe",
};

local _tRings = {
	smith = { label = "Ring des Schmiedes", ability = "Stärke" },
	craftsman = { label = "Ring des Handwerkers", ability = "Geschicklichkeit" },
	tanner = { label = "Ring des Gerbers", ability = "Konstitution" },
	alchemist = { label = "Ring des Alchemisten", ability = "Intelligenz" },
	healer = { label = "Ring des Heilers", ability = "Weisheit" },
	scribe = { label = "Ring des Schreibers", ability = "Charisma" },
};

function onInit()
	ActionsManager.registerModHandler(FISHING_ROLL_TYPE, BetterToolsFishingManager.modFishingRoll);
	ActionsManager.registerResultHandler(FISHING_ROLL_TYPE, BetterToolsFishingManager.onFishingRoll);
	ActionsManager.registerResultHandler(FISHING_LOOT_ROLL_TYPE, BetterToolsFishingManager.onLootRoll);
	if Session.IsHost then
		BetterToolsFishingManager.ensureFishingItemRecords();
		BetterToolsFishingManager.ensureSpecialTables();
	end
end

function getToolText()
	return [[<formattedtext>
<p><i>Genutztes Attribut: Stärke</i></p>
<p>Mit Angelausrüstung kannst du Fische und seltener auch besondere Gegenstände aus dem Wasser holen. Erstere eignen sich zum Kochen und füllen deinen Magen, während letztere z. B. verwendet werden können, um deine Fähigkeiten im Umgang mit anderen Werkzeugen zu verbessern.</p>
<p>Angelausrüstung besteht aus einer Angelrute, Schnur, mehreren Haken wie Ködern und Treibern, sowie Behälter für diese und einen Eimer für gefangene Fische. Sie wiegt 6 Pfund und kostet 1 Gold.</p>
<h>Fertigkeiten</h>
<p>Folgende Beispiele zeigen auf, inwiefern andere Fertigkeiten von der Übung in Angelausrüstung profitieren könnten. Es handelt sich dabei lediglich um Vorschläge; sei kreativ!</p>
<p><b>Einschüchtern.</b> Fischer protzen gerne und scheuen sich nicht davor, sich vor anderen aufzuplustern. Niemand will sich mit jemandem anlegen, der zwölf Haie mit bloßen Händen totprügelte, weil sie die Schnur durchbissen.</p>
<p><b>Naturkunde.</b> Um ordentlich angeln zu können, musst du nicht nur die Lebensräume und Verhaltensweisen deiner Beute kennen, sondern auch wissen, wer sie dir streitig machen könnte.</p>
<p><b>Geschichte.</b> Nebst Fischen hast du schon manch anderes aus dem Wasser gezogen und so nach und nach erfahren, was über die Zeitalter so auf und unter dem Wasser schwamm.</p>
<h>Fischen</h>
<p>Fischen zählt nicht als anstrengende Aktivität, weswegen du es auch während einer Kurzen oder Langen Rast tun und trotzdem deren Effekte erhalten kannst. Zum Ende des Fischens machst du einen Angelausrüstung-Wurf. Abhängig vom Ergebnis dieses Wurfes, würfelst du mit einem anderen Würfel auf die Beutetabelle. Fischst du während einer Kurzen Rast, kannst du höchstens mit 1W4 würfeln.</p>
<table>
	<tr><td><b>SG</b></td><td><b>Würfel</b></td></tr>
	<tr><td>10</td><td>1W4</td></tr>
	<tr><td>15</td><td>1W8 (nur bei Langer Rast)</td></tr>
	<tr><td>20</td><td>1W12 (nur bei Langer Rast)</td></tr>
	<tr><td>25</td><td>1W20 (nur bei Langer Rast)</td></tr>
</table>
<h>Zutaten und Rationen</h>
<p>Gefangene Fische können als Kochzutaten verwendet werden, wobei ihre Seltenheit von dem Wurf auf der Beutetabelle abhängig ist. Die Menge an Portionen, die ein Fisch ergibt, ist in Klammern aufgeführt.</p>
<p>Alternativ kannst du die Fische zu einer Menge Rationen verarbeiten, die ebenfalls von ihrer Seltenheit abhängig ist und die du in den Klammern in der Beutetabelle sehen kannst. Die Entscheidung, ob du die Fische als Zutaten oder Rationen verwenden willst, triffst du direkt nach Ende des Fischens.</p>
<h>Gegenstände würfeln</h>
<p>Würfelst du auf der Beutetabelle zum ersten Mal ein Ergebnis mit einem Gegenstand, erhältst du sowohl die Beute wie auch den Gegenstand. Du kannst den Gegenstand eines bestimmten Ergebnisses nur ein Mal erhalten. Würfelst du eine 19 oder 20, wirfst du zusätzlich 1W8, um auf der jeweiligen untenstehenden Tabelle zu bestimmen, welchen konkreten Gegenstand du erhältst.</p>
<h>Beutetabelle</h>
<table>
	<tr><td><b>Ergebnis</b></td><td><b>Beute (Portionen / Rationen)</b></td><td><b>Gegenstände</b></td></tr>
	<tr><td>1</td><td>Gewöhnlicher Fisch (1 / 2)</td><td>-</td></tr>
	<tr><td>2</td><td>Gewöhnlicher Fisch (1 / 2)</td><td>-</td></tr>
	<tr><td>3</td><td>Gewöhnlicher Fisch (2 / 4)</td><td>-</td></tr>
	<tr><td>4</td><td>Gewöhnlicher Fisch (2 / 4)</td><td>-</td></tr>
	<tr><td>5</td><td>Gewöhnlicher Fisch (3 / 6)</td><td>-</td></tr>
	<tr><td>6</td><td>Gewöhnlicher Fisch (3 / 6)</td><td>-</td></tr>
	<tr><td>7</td><td>Gewöhnlicher Fisch (4 / 8)</td><td>Ring des Schmiedes</td></tr>
	<tr><td>8</td><td>Gewöhnlicher Fisch (4 / 8)</td><td>Ring des Handwerkers</td></tr>
	<tr><td>9</td><td>Seltener Fisch (1 / 10)</td><td>Ring des Gerbers</td></tr>
	<tr><td>10</td><td>Seltener Fisch (1 / 10)</td><td>Ring des Alchemisten</td></tr>
	<tr><td>11</td><td>Seltener Fisch (2 / 20)</td><td>Ring des Heilers</td></tr>
	<tr><td>12</td><td>Seltener Fisch (2 / 20)</td><td>Ring des Schreibers</td></tr>
	<tr><td>13</td><td>Seltener Fisch (3 / 30)</td><td>Ring des Schmiedes (Verstärkt)</td></tr>
	<tr><td>14</td><td>Seltener Fisch (3 / 30)</td><td>Ring des Handwerkers (Verstärkt)</td></tr>
	<tr><td>15</td><td>Seltener Fisch (4 / 40)</td><td>Ring des Gerbers (Verstärkt)</td></tr>
	<tr><td>16</td><td>Seltener Fisch (4 / 40)</td><td>Ring des Alchemisten (Verstärkt)</td></tr>
	<tr><td>17</td><td>Sehr seltener Fisch (1 / 50)</td><td>Ring des Heilers (Verstärkt)</td></tr>
	<tr><td>18</td><td>Sehr seltener Fisch (1 / 50)</td><td>Ring des Schreibers (Verstärkt)</td></tr>
	<tr><td>19</td><td>Sehr seltener Fisch (2 / 100)</td><td>Ungewöhnlicher Gegenstand</td></tr>
	<tr><td>20</td><td>Sehr seltener Fisch (2 / 100)</td><td>Seltener Gegenstand</td></tr>
</table>
<h>Liste an Gegenständen</h>
<h>Werkzeug-Gegenstände</h>
<h>Ring des Schmiedes</h>
<p>Der Träger erhält einen Bonus von +2 auf Werkzeug-Würfe, die Stärke verwenden.</p>
<p><b>Verstärkt:</b> Der Träger erhält einen Bonus von +5.</p>
<h>Ring des Handwerkers</h>
<p>Der Träger erhält einen Bonus von +2 auf Werkzeug-Würfe, die Geschicklichkeit verwenden.</p>
<p><b>Verstärkt:</b> Der Träger erhält einen Bonus von +5.</p>
<h>Ring des Gerbers</h>
<p>Der Träger erhält einen Bonus von +2 auf Werkzeug-Würfe, die Konstitution verwenden.</p>
<p><b>Verstärkt:</b> Der Träger erhält einen Bonus von +5.</p>
<h>Ring des Alchemisten</h>
<p>Der Träger erhält einen Bonus von +2 auf Werkzeug-Würfe, die Intelligenz verwenden.</p>
<p><b>Verstärkt:</b> Der Träger erhält einen Bonus von +5.</p>
<h>Ring des Heilers</h>
<p>Der Träger erhält einen Bonus von +2 auf Werkzeug-Würfe, die Weisheit verwenden.</p>
<p><b>Verstärkt:</b> Der Träger erhält einen Bonus von +5.</p>
<h>Ring des Schreibers</h>
<p>Der Träger erhält einen Bonus von +2 auf Werkzeug-Würfe, die Charisma verwenden.</p>
<p><b>Verstärkt:</b> Der Träger erhält einen Bonus von +5.</p>
<h>Sonstige Gegenstände</h>
<h>Ungewöhnliche Gegenstände</h>
<table>
	<tr><td><b>W8</b></td><td><b>Erhaltener Gegenstand</b></td></tr>
	<tr><td>1</td><td>Flöte des Rattenfängers</td></tr>
	<tr><td>2</td><td>Perle der Kraft</td></tr>
	<tr><td>3</td><td>Dreizack der Fischherrschaft</td></tr>
	<tr><td>4</td><td>Ring des Wasserlaufens</td></tr>
	<tr><td>5</td><td>Ring des Schwimmens</td></tr>
	<tr><td>6</td><td>Mütze der Wasseratmung</td></tr>
	<tr><td>7</td><td>Umhang des Mantarochens</td></tr>
	<tr><td>8</td><td>Schwebefeder (Anker)</td></tr>
</table>
<h>Seltene Gegenstände</h>
<table>
	<tr><td><b>W8</b></td><td><b>Erhaltener Gegenstand</b></td></tr>
	<tr><td>1</td><td>Perle der Macht</td></tr>
	<tr><td>2</td><td>Ionenstein (Wahrnehmung)</td></tr>
	<tr><td>3</td><td>Ionenstein (Schutz)</td></tr>
	<tr><td>4</td><td>Ionenstein (Reserve)</td></tr>
	<tr><td>5</td><td>Ionenstein (Stärke)</td></tr>
	<tr><td>6</td><td>Tentakelzepter</td></tr>
	<tr><td>7</td><td>Haken der Fischerfreude</td></tr>
	<tr><td>8</td><td>Schwebefeder (Schwanenboot)</td></tr>
</table>
</formattedtext>]];
end

function ensureFishingItemRecords()
	if not Session.IsHost then
		return;
	end

	for _, sRingKey in ipairs(_tRingOrder) do
		BetterToolsFishingManager.ensureFishingItemRecord(sRingKey, false);
		BetterToolsFishingManager.ensureFishingItemRecord(sRingKey, true);
	end
end

function ensureFishingItemRecord(sRingKey, bEnhanced)
	local sName = BetterToolsFishingManager.getRingItemName(sRingKey, bEnhanced);
	local nodeItem = BetterToolsFishingManager.findFishingItemRecord(sName);
	if not Session.IsHost then
		return nodeItem;
	end
	if not nodeItem then
		nodeItem = BetterToolsFishingManager.createFishingItemRecord();
	end
	if nodeItem then
		BetterToolsFishingManager.populateFishingItemRecord(nodeItem, sRingKey, bEnhanced);
	end
	return nodeItem;
end

function getItemRoot()
	local sItemRoot = "item";
	if RecordDataManager and RecordDataManager.getDataPathRoot then
		sItemRoot = RecordDataManager.getDataPathRoot("item") or sItemRoot;
	end
	return sItemRoot;
end

function getRingItemName(sRingKey, bEnhanced)
	local tRing = _tRings[sRingKey] or _tRings.smith;
	if bEnhanced then
		return tRing.label .. " (Verstärkt)";
	end
	return tRing.label;
end

function findFishingItemRecord(sName)
	for _, nodeItem in ipairs(DB.getChildList(BetterToolsFishingManager.getItemRoot())) do
		if DB.getValue(nodeItem, "name", "") == sName and DB.getValue(nodeItem, "subtype", "") == "Werkzeug-Gegenstand" then
			return nodeItem;
		end
	end
	return nil;
end

function createFishingItemRecord()
	if not Session.IsHost then
		return nil;
	end

	local bCreated, nodeItem = pcall(DB.createChild, BetterToolsFishingManager.getItemRoot());
	if not bCreated and BetterToolsFishingManager.getItemRoot() ~= "item" then
		bCreated, nodeItem = pcall(DB.createChild, "item");
	end
	if not bCreated then
		return nil;
	end
	return nodeItem;
end

function populateFishingItemRecord(nodeItem, sRingKey, bEnhanced)
	if not nodeItem then
		return;
	end

	DB.setValue(nodeItem, "name", "string", BetterToolsFishingManager.getRingItemName(sRingKey, bEnhanced));
	BetterToolsFishingManager.setRecordCategory(nodeItem);
	DB.setValue(nodeItem, "count", "number", 1);
	DB.setValue(nodeItem, "isidentified", "number", 1);
	DB.setValue(nodeItem, "locked", "number", 1);
	DB.setValue(nodeItem, "type", "string", "Wondrous Item");
	DB.setValue(nodeItem, "subtype", "string", "Werkzeug-Gegenstand");
	DB.setValue(nodeItem, "rarity", "string", BetterToolsFishingManager.getRingRarity(bEnhanced));
	DB.setValue(nodeItem, "weight", "number", 0);
	DB.setValue(nodeItem, "cost", "string", "");
	DB.setValue(nodeItem, "description", "formattedtext", BetterToolsFishingManager.getRingDescription(sRingKey, bEnhanced));
end

function setRecordCategory(nodeRecord)
	if not Session.IsHost or not nodeRecord then
		return;
	end
	if DB.setCategory then
		DB.setCategory(DB.getPath(nodeRecord), RECORD_CATEGORY);
	end
	if DB.setPublic then
		DB.setPublic(nodeRecord, true);
	end
end

function getRingRarity(bEnhanced)
	if bEnhanced then
		return "Selten";
	end
	return "Ungewöhnlich";
end

function getRingDescription(sRingKey, bEnhanced)
	local tRing = _tRings[sRingKey] or _tRings.smith;
	local nBonus = 2;
	if bEnhanced then
		nBonus = 5;
	end

	return string.format([[<formattedtext>
<p>Der Träger erhält einen Bonus von +%d auf Werkzeug-Würfe, die %s verwenden.</p>
</formattedtext>]], nBonus, tRing.ability);
end

function ensureSpecialTables()
	if not Session.IsHost then
		return;
	end

	for sTableKey, _ in pairs(_tSpecialTableNames) do
		BetterToolsFishingManager.ensureSpecialTable(sTableKey);
	end
end

function ensureSpecialTable(sTableKey)
	local nodeExisting = BetterToolsFishingManager.findSpecialTable(sTableKey);
	if nodeExisting then
		BetterToolsFishingManager.setRecordCategory(nodeExisting);
		return;
	end

	local tRows = _tSpecialTables[sTableKey];
	if not tRows then
		return;
	end

	local nodeTable = DB.createChild(BetterToolsFishingManager.getTableRoot());
	if not nodeTable then
		return;
	end

	DB.setValue(nodeTable, "name", "string", BetterToolsFishingManager.getSpecialTableName(sTableKey));
	BetterToolsFishingManager.setRecordCategory(nodeTable);
	DB.setValue(nodeTable, "dice", "dice", { "d8" });
	DB.setValue(nodeTable, "mod", "number", 0);
	DB.setValue(nodeTable, "resultscols", "number", 1);
	DB.setValue(nodeTable, "labelcol1", "string", "Gegenstand");
	DB.setValue(nodeTable, "description", "string", "BetterTools Angelausrüstung: " .. BetterToolsFishingManager.getSpecialTableLabel(sTableKey));
	DB.setValue(nodeTable, "notes", "formattedtext", "<p>Texttabelle für zufällige Angel-Gegenstände. Die Einträge sind absichtlich nicht mit Items verlinkt.</p>");

	local nodeRows = DB.createChild(nodeTable, "tablerows");
	if not nodeRows then
		return;
	end

	for _, tRow in ipairs(tRows) do
		local nodeRow = DB.createChild(nodeRows);
		DB.setValue(nodeRow, "fromrange", "number", tRow[1] or 0);
		DB.setValue(nodeRow, "torange", "number", tRow[1] or 0);

		local nodeResults = DB.createChild(nodeRow, "results");
		local nodeResult = DB.createChild(nodeResults);
		DB.setValue(nodeResult, "result", "string", tRow[2] or "");
	end
end

function getTableRoot()
	local sTableRoot = "tables";
	if RecordDataManager and RecordDataManager.getDataPathRoot then
		sTableRoot = RecordDataManager.getDataPathRoot("table") or sTableRoot;
	end
	return sTableRoot;
end

function getSpecialTableName(sTableKey)
	return _tSpecialTableNames[sTableKey or ""] or "";
end

function getSpecialTableLabel(sTableKey)
	if sTableKey == "uncommon" then
		return "Ungewöhnliche Gegenstände";
	elseif sTableKey == "rare" then
		return "Seltene Gegenstände";
	end
	return sTableKey or "";
end

function findSpecialTable(sTableKey)
	local sTableName = BetterToolsFishingManager.getSpecialTableName(sTableKey);
	if sTableName == "" then
		return nil;
	end

	if TableManager and TableManager.findTable then
		local nodeTable = TableManager.findTable(sTableName);
		if nodeTable then
			return nodeTable;
		end
	end

	for _, nodeTable in ipairs(DB.getChildList(BetterToolsFishingManager.getTableRoot())) do
		if DB.getValue(nodeTable, "name", "") == sTableName then
			return nodeTable;
		end
	end
	return nil;
end

function performFishing(nodeFishing, sRestType)
	if not nodeFishing then
		return;
	end

	sRestType = sRestType or "short";
	local nodeChar = DB.getChild(nodeFishing, "...");
	local rActor = ActorManager.resolveActor(nodeChar);
	local rRoll = BetterToolsFishingManager.getFishingRoll(nodeChar, rActor);
	if not rRoll then
		ChatManager.SystemMessage("BetterTools: Angelausrüstung nicht im Tools-Tab gefunden.");
		return;
	end

	rRoll.sType = FISHING_ROLL_TYPE;
	rRoll.sDesc = (rRoll.sDesc or "") .. "\r[Angelausrüstung: " .. BetterToolsFishingManager.getRestLabel(sRestType) .. "]";
	rRoll.sFishingPath = DB.getPath(nodeFishing);
	rRoll.sRestType = sRestType;
	ActionsManager.performAction(nil, rActor, rRoll);
end

function getFishingRoll(nodeChar, rActor)
	local nodeTool = BetterToolsFishingManager.findToolNode(nodeChar);
	if not nodeTool then
		return nil;
	end

	local sOldStat = DB.getValue(nodeTool, "stat", "");
	DB.setValue(nodeTool, "stat", "string", "strength");
	local bOk, rRoll = pcall(ActionSkill.getRoll, rActor, nodeTool);
	DB.setValue(nodeTool, "stat", "string", sOldStat);
	if bOk then
		return rRoll;
	end
	return nil;
end

function modFishingRoll(rSource, rTarget, rRoll)
	local sType = rRoll.sType;
	rRoll.sType = "skill";
	ActionCheck.modRoll(rSource, rTarget, rRoll);
	rRoll.sType = sType;
	return true;
end

function onFishingRoll(rSource, _, rRoll)
	if ActionsManager2 and ActionsManager2.setupD20RollResolve then
		ActionsManager2.setupD20RollResolve(rRoll, rSource);
	end

	local nodeFishing = DB.findNode(rRoll.sFishingPath or "");
	local nodeChar = BetterToolsFishingManager.getCharacterNodeFromFishing(nodeFishing);
	if not nodeChar and ActorManager then
		nodeChar = ActorManager.getCreatureNode(rSource);
	end

	local nTotal = rRoll.nTotal or ActionsManager.total(rRoll);
	local sRestType = rRoll.sRestType or "short";
	local nLootDie = BetterToolsFishingManager.getLootDie(nTotal, sRestType);
	local tLines = {
		"Rast: " .. BetterToolsFishingManager.getRestLabel(sRestType) .. ".",
	};

	if nLootDie <= 0 then
		table.insert(tLines, "Kein Fang.");
		local rMessage = ActionsManager.createActionMessage(rSource, rRoll);
		rMessage.text = rMessage.text .. "\r" .. table.concat(tLines, "\r");
		Comm.deliverChatMessage(rMessage);
		return;
	end

	table.insert(tLines, "Beutewürfel: 1W" .. nLootDie .. ".");
	local rMessage = ActionsManager.createActionMessage(rSource, rRoll);
	rMessage.text = rMessage.text .. "\r" .. table.concat(tLines, "\r");
	Comm.deliverChatMessage(rMessage);

	local rLootRoll = {
		sType = FISHING_LOOT_ROLL_TYPE,
		sDesc = "[BetterTools] Angelausrüstung: Beutetabelle (1W" .. nLootDie .. ")",
		aDice = { "d" .. nLootDie },
		nMod = 0,
		sFishingPath = rRoll.sFishingPath,
		sRestType = sRestType,
		nLootDie = nLootDie,
	};
	ActionsManager.performAction(nil, rSource, rLootRoll);
end

function onLootRoll(rSource, _, rRoll)
	local nodeFishing = DB.findNode(rRoll.sFishingPath or "");
	local nodeChar = BetterToolsFishingManager.getCharacterNodeFromFishing(nodeFishing);
	if not nodeChar and ActorManager then
		nodeChar = ActorManager.getCreatureNode(rSource);
	end

	local nResult = math.max(math.min(rRoll.nTotal or ActionsManager.total(rRoll), tonumber(rRoll.nLootDie) or 20), 1);
	local tLoot = _tLootRows[nResult] or _tLootRows[1];
	local tLines = {
		string.format("Beute: %s (%d Portion(en) / %d Ration(en)).", tLoot.fish, tLoot.portions, tLoot.rations),
	};

	if tLoot.ring then
		table.insert(tLines, BetterToolsFishingManager.claimRing(nodeChar, tLoot.ring, tLoot.enhanced));
	elseif tLoot.table then
		local bClaimed, sClaimMessage = BetterToolsFishingManager.claimSpecialTable(nodeChar, tLoot.table);
		table.insert(tLines, sClaimMessage);
		if bClaimed then
			rRoll.sSpecialTable = tLoot.table;
		end
	end

	local rMessage = ActionsManager.createActionMessage(rSource, rRoll);
	rMessage.text = rMessage.text .. "\r" .. table.concat(tLines, "\r");
	Comm.deliverChatMessage(rMessage);

	if (rRoll.sSpecialTable or "") ~= "" then
		BetterToolsFishingManager.rollSpecialTable(rSource, rRoll.sSpecialTable);
	end
end

function getLootDie(nTotal, sRestType)
	nTotal = tonumber(nTotal) or 0;
	if nTotal < 10 then
		return 0;
	end
	if sRestType == "short" then
		return 4;
	end
	if nTotal >= 25 then
		return 20;
	elseif nTotal >= 20 then
		return 12;
	elseif nTotal >= 15 then
		return 8;
	end
	return 4;
end

function claimRing(nodeChar, sRingKey, bEnhanced)
	if not nodeChar then
		return "Gegenstand konnte keinem Charakter zugeordnet werden.";
	end

	local sClaimKey = BetterToolsFishingManager.getClaimKey(sRingKey, bEnhanced);
	local nodeClaim = DB.createChild(nodeChar, "bettertools.fishing.claimed." .. sClaimKey);
	local sName = BetterToolsFishingManager.getRingItemName(sRingKey, bEnhanced);
	if DB.getValue(nodeClaim, "claimed", 0) > 0 then
		return "Gegenstand bereits erhalten: " .. sName .. ".";
	end

	local nodeSource = BetterToolsFishingManager.ensureFishingItemRecord(sRingKey, bEnhanced);
	if not nodeSource then
		return "Gegenstand konnte nicht erstellt werden: " .. sName .. ".";
	end

	local nodeInventory = DB.createChild(nodeChar, "inventorylist");
	local nodeItem = nodeInventory and DB.createChild(nodeInventory) or nil;
	if not nodeItem then
		return "Gegenstand konnte nicht ins Inventar gelegt werden: " .. sName .. ".";
	end

	BetterToolsFishingManager.copyItemRecord(nodeSource, nodeItem);
	DB.setValue(nodeClaim, "claimed", "number", 1);
	DB.setValue(nodeClaim, "name", "string", sName);
	return "Gegenstand erhalten: " .. sName .. ".";
end

function claimSpecialTable(nodeChar, sTableKey)
	if not nodeChar then
		return false, "Zusätzliche Tabelle konnte keinem Charakter zugeordnet werden.";
	end

	local sClaimKey = "special_" .. (sTableKey or "");
	local nodeClaim = DB.createChild(nodeChar, "bettertools.fishing.claimed." .. sClaimKey);
	local sTableName = BetterToolsFishingManager.getSpecialTableName(sTableKey);
	if DB.getValue(nodeClaim, "claimed", 0) > 0 then
		return false, "Zusätzliche Tabelle bereits erhalten: " .. sTableName .. ".";
	end

	DB.setValue(nodeClaim, "claimed", "number", 1);
	DB.setValue(nodeClaim, "name", "string", sTableName);
	return true, "Zusätzliche Tabelle: " .. sTableName .. ".";
end

function getClaimKey(sRingKey, bEnhanced)
	local sKey = sRingKey or "smith";
	if bEnhanced then
		return sKey .. "_enhanced";
	end
	return sKey;
end

function copyItemRecord(nodeSource, nodeTarget)
	if not nodeSource or not nodeTarget then
		return;
	end

	for _, sField in ipairs({ "name", "type", "subtype", "rarity", "cost" }) do
		DB.setValue(nodeTarget, sField, "string", DB.getValue(nodeSource, sField, ""));
	end
	DB.setValue(nodeTarget, "description", "formattedtext", DB.getValue(nodeSource, "description", ""));
	for _, sField in ipairs({ "count", "isidentified", "locked", "weight" }) do
		DB.setValue(nodeTarget, sField, "number", DB.getValue(nodeSource, sField, 0));
	end
	DB.setValue(nodeTarget, "count", "number", 1);
	DB.setValue(nodeTarget, "carried", "number", 1);
end

function rollSpecialTable(rActor, sTableKey)
	local nodeTable = BetterToolsFishingManager.findSpecialTable(sTableKey);
	if not nodeTable then
		ChatManager.SystemMessage("BetterTools: Tabelle nicht gefunden: " .. BetterToolsFishingManager.getSpecialTableName(sTableKey));
		return;
	end
	if not TableManager or not TableManager.performRoll then
		ChatManager.SystemMessage("BetterTools: TableManager nicht verfügbar.");
		return;
	end

	local rTableRoll = { nodeTable = nodeTable };
	if TableManager.getTableDice then
		rTableRoll.aDice, rTableRoll.nMod = TableManager.getTableDice(nodeTable);
	end
	TableManager.performRoll(nil, rActor, rTableRoll, false);
end

function getRestLabel(sRestType)
	if sRestType == "long" then
		return "Lange Rast";
	end
	return "Kurze Rast";
end

function getCharacterNodeFromFishing(nodeFishing)
	if not nodeFishing then
		return nil;
	end
	return DB.getChild(nodeFishing, "...");
end

function findToolNode(nodeChar)
	if not nodeChar then
		return nil;
	end
	for _, nodeTool in pairs(DB.getChildList(nodeChar, "toollist")) do
		if DB.getValue(nodeTool, "tooltype", "") == "fishing" or DB.getValue(nodeTool, "name", "") == "Angelausrüstung" then
			return nodeTool;
		end
	end
	return nil;
end
