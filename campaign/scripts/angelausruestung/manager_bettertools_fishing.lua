local RECORD_CATEGORY = "BetterTools";

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
	if Session.IsHost then
		BetterToolsFishingManager.ensureFishingItemRecords();
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
<p>Um zu fischen, benötigst du mindestens 1 Stunde an Zeit. Fischen zählt nicht als anstrengende Aktivität, weswegen du es auch während einer Kurzen Rast tun und trotzdem deren Effekte erhalten kannst. Zum Ende des Fischens machst du einen Angelausrüstung-Wurf. Abhängig vom Ergebnis dieses Wurfes, würfelst du mit einem anderen Würfel auf die Beutetabelle. Fischst du für weniger als 8 Stunden, kannst du höchstens mit 1W4 würfeln.</p>
<table>
	<tr><td><b>SG</b></td><td><b>Würfel</b></td></tr>
	<tr><td>10</td><td>1W4</td></tr>
	<tr><td>15</td><td>1W8 (nur ab 8 Stunden)</td></tr>
	<tr><td>20</td><td>1W12 (nur ab 8 Stunden)</td></tr>
	<tr><td>25</td><td>1W20 (nur ab 8 Stunden)</td></tr>
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
