local ROLL_TYPE = "bettertools_leisure_play";
local MONEY_ROLL_TYPE = "bettertools_leisure_money";
local RECORD_CATEGORY = "BetterTools";

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

local _tArcanaTableNames = {
	common = "BetterTools - Arcana - Common",
	uncommon = "BetterTools - Arcana - Uncommon",
	rare = "BetterTools - Arcana - Rare",
	veryrare = "BetterTools - Arcana - Very Rare",
};

local _tArcanaTables = {
	common = {
		{ 1, 2, "Bead of Nourishment" },
		{ 3, 4, "Bead of Refreshment" },
		{ 5, 7, "Candle of the Deep" },
		{ 8, 10, "Cloak of Billowing" },
		{ 11, 13, "Cloak of Many Fashions" },
		{ 14, 15, "Clothes of Mending" },
		{ 16, 17, "Dark Shard Amulet" },
		{ 18, 19, "Enduring Spellbook" },
		{ 20, 21, "Ersatz Eye" },
		{ 22, 24, "Hat of Vermin" },
		{ 25, 27, "Hat of Wizardry" },
		{ 28, 29, "Heward's Handy Spice Pouch" },
		{ 30, 31, "Horn of Silent Alarm" },
		{ 32, 33, "Instrument of Illusions" },
		{ 34, 35, "Instrument of Scribing" },
		{ 36, 37, "Lock of Trickery" },
		{ 38, 40, "Mystery Key" },
		{ 41, 42, "Orb of Direction" },
		{ 43, 44, "Orb of Time" },
		{ 45, 46, "Perfume of Bewitching" },
		{ 47, 49, "Pipe of Smoke Monsters" },
		{ 50, 52, "Potion of Climbing" },
		{ 53, 55, "Potion of Comprehension" },
		{ 56, 58, "Pot of Awakening" },
		{ 59, 60, "Prosthetic Limb" },
		{ 61, 64, "Rival Coin" },
		{ 65, 66, "Rope of Mending" },
		{ 67, 68, "Ruby of the War Mage" },
		{ 69, 82, "Spell Scroll (cantrip or level 1 spell)" },
		{ 83, 84, "Staff of Adornment" },
		{ 85, 86, "Staff of Birdcalls" },
		{ 87, 89, "Staff of Flowers" },
		{ 90, 92, "Talking Doll" },
		{ 93, 94, "Tankard of Sobriety" },
		{ 95, 97, "Wand of Conducting" },
		{ 98, 100, "Wand of Pyrotechnics" },
	},
	uncommon = {
		{ 1, 1, "Amulet of Proof against Detection and Location" },
		{ 2, 2, "Baba Yaga's Dancing Broom" },
		{ 3, 5, "Bag of Holding" },
		{ 6, 7, "Bag of Tricks" },
		{ 8, 8, "Brooch of Shielding" },
		{ 9, 9, "Broom of Flying" },
		{ 10, 10, "Cap of Water Breathing" },
		{ 11, 11, "Circlet of Blasting" },
		{ 12, 13, "Cloak of Protection" },
		{ 14, 14, "Cloak of the Manta Ray" },
		{ 15, 15, "Decanter of Endless Water" },
		{ 16, 16, "Deck of Illusions" },
		{ 17, 18, "Driftglobe" },
		{ 19, 20, "Dust of Disappearance" },
		{ 21, 21, "Dust of Dryness" },
		{ 22, 22, "Dust of Sneezing and Choking" },
		{ 23, 24, "Elemental Gem" },
		{ 25, 25, "Enspelled Staff (cantrip or level 1 spell)" },
		{ 26, 26, "Eversmoking Bottle" },
		{ 27, 27, "Eyes of Charming" },
		{ 28, 28, "Eyes of Minute Seeing" },
		{ 29, 30, "Figurine of Wondrous Power (silver raven)" },
		{ 31, 31, "Gem of Brightness" },
		{ 32, 32, "Hag Eye" },
		{ 33, 33, "Hat of Disguise" },
		{ 34, 34, "Headband of Intellect" },
		{ 35, 35, "Helm of Comprehending Languages" },
		{ 36, 36, "Helm of Telepathy" },
		{ 37, 37, "Immovable Rod" },
		{ 38, 38, "Lantern of Revealing" },
		{ 39, 39, "Medallion of Thoughts" },
		{ 40, 40, "Mithral Armor" },
		{ 41, 42, "Necklace of Adaptation" },
		{ 43, 43, "Oil of Slipperiness" },
		{ 44, 44, "Pearl of Power" },
		{ 45, 45, "Periapt of Health" },
		{ 46, 47, "Philter of Love" },
		{ 48, 49, "Potion of Animal Friendship" },
		{ 50, 51, "Potion of Fire Breath" },
		{ 52, 53, "Potion of Giant Strength (hill)" },
		{ 54, 55, "Potion of Growth" },
		{ 56, 57, "Potion of Poison" },
		{ 58, 59, "Potion of Resistance" },
		{ 60, 61, "Potion of Water Breathing" },
		{ 62, 62, "Quaal's Feather Token (anchor, fan, or tree)" },
		{ 63, 63, "Ring of Mind Shielding" },
		{ 64, 65, "Robe of Useful Items" },
		{ 66, 67, "Rod of the Pact Keeper, +1" },
		{ 68, 69, "Rope of Climbing" },
		{ 70, 70, "Saddle of the Cavalier" },
		{ 71, 72, "Sending Stones" },
		{ 73, 74, "Slippers of Spider Climbing" },
		{ 75, 82, "Spell Scroll (level 2 or 3 spell)" },
		{ 83, 83, "Staff of the Adder" },
		{ 84, 84, "Staff of the Python" },
		{ 85, 88, "Wand of Magic Detection" },
		{ 89, 91, "Wand of Magic Missiles" },
		{ 92, 93, "Wand of Secrets" },
		{ 94, 95, "Wand of the War Mage, +1" },
		{ 96, 97, "Wand of Web" },
		{ 98, 99, "Wind Fan" },
		{ 100, 100, "Winged Boots" },
	},
	rare = {
		{ 1, 1, "Bag of Beans" },
		{ 2, 3, "Bead of Force" },
		{ 4, 4, "Bowl of Commanding Water Elementals" },
		{ 5, 6, "Bracers of Defense" },
		{ 7, 7, "Brazier of Commanding Fire Elementals" },
		{ 8, 9, "Cape of the Mountebank" },
		{ 10, 10, "Censer of Controlling Air Elementals" },
		{ 11, 12, "Chime of Opening" },
		{ 13, 14, "Cloak of Displacement" },
		{ 15, 16, "Cloak of the Bat" },
		{ 17, 17, "Cube of Force" },
		{ 18, 18, "Cube of Summoning" },
		{ 19, 19, "Daern's Instant Fortress" },
		{ 20, 21, "Enspelled Staff (level 2 or 3 spell)" },
		{ 22, 23, "Figurine of Wondrous Power (bronze griffon, ebony fly, golden lions, ivory goats, marble elephant, onyx dog, or serpentine owl)" },
		{ 24, 25, "Folding Boat" },
		{ 26, 27, "Gem of Seeing" },
		{ 28, 28, "Helm of Teleportation" },
		{ 29, 30, "Heward's Handy Haversack" },
		{ 31, 32, "Horseshoes of Speed" },
		{ 33, 34, "Ioun Stone (reserve)" },
		{ 35, 35, "Iron Bands of Bilarro" },
		{ 36, 36, "Mantle of Spell Resistance" },
		{ 37, 38, "Necklace of Fireballs" },
		{ 39, 39, "Oil of Etherealness" },
		{ 40, 40, "Portable Hole" },
		{ 41, 42, "Potion of Clairvoyance" },
		{ 43, 44, "Potion of Diminution" },
		{ 45, 46, "Potion of Gaseous Form" },
		{ 47, 47, "Potion of Giant Strength (fire)" },
		{ 48, 49, "Potion of Giant Strength (frost or stone)" },
		{ 50, 51, "Potion of Heroism" },
		{ 52, 53, "Potion of Invisibility" },
		{ 54, 55, "Potion of Invulnerability" },
		{ 56, 57, "Potion of Mind Reading" },
		{ 58, 59, "Quaal's Feather Token (bird, swan boat, or whip)" },
		{ 60, 61, "Ring of Feather Falling" },
		{ 62, 62, "Ring of Spell Storing" },
		{ 63, 63, "Ring of X-ray Vision" },
		{ 64, 65, "Robe of Eyes" },
		{ 66, 66, "Rod of Rulership" },
		{ 67, 68, "Rod of the Pact Keeper, +2" },
		{ 69, 70, "Scroll of Protection" },
		{ 71, 75, "Spell Scroll (level 4 or 5 spell)" },
		{ 76, 77, "Staff of Charming" },
		{ 78, 79, "Staff of Swarming Insects" },
		{ 80, 81, "Staff of Withering" },
		{ 82, 82, "Stone of Controlling Earth Elementals" },
		{ 83, 84, "Wand of Binding" },
		{ 85, 86, "Wand of Fear" },
		{ 87, 90, "Wand of Fireballs" },
		{ 91, 94, "Wand of Lightning Bolts" },
		{ 95, 96, "Wand of the War Mage, +2" },
		{ 97, 98, "Wand of Wonder" },
		{ 99, 100, "Wings of Flying" },
	},
	veryrare = {
		{ 1, 2, "Amulet of the Planes" },
		{ 3, 4, "Bag of Devouring" },
		{ 5, 6, "Carpet of Flying" },
		{ 7, 8, "Cauldron of Rebirth" },
		{ 9, 10, "Cloak of Arachnida" },
		{ 11, 12, "Crystal Ball" },
		{ 13, 13, "Dancing Sword" },
		{ 14, 14, "Efreeti Bottle" },
		{ 15, 16, "Enspelled Staff (level 4 or 5 spell)" },
		{ 17, 18, "Figurine of Wondrous Power (obsidian steed)" },
		{ 19, 20, "Hat of Many Spells" },
		{ 21, 22, "Helm of Brilliance" },
		{ 23, 24, "Horseshoes of a Zephyr" },
		{ 25, 26, "Ioun Stone (absorption, fortitude, intellect, or leadership)" },
		{ 27, 28, "Manual of Golems (clay, flesh, iron, or stone)" },
		{ 29, 29, "Mirror of Life Trapping" },
		{ 30, 31, "Nolzur's Marvelous Pigments" },
		{ 32, 34, "Oil of Sharpness" },
		{ 35, 38, "Potion of Flying" },
		{ 39, 42, "Potion of Giant Strength (cloud)" },
		{ 43, 46, "Potion of Greater Invisibility" },
		{ 47, 49, "Potion of Longevity" },
		{ 50, 53, "Potion of Speed" },
		{ 54, 57, "Potion of Vitality" },
		{ 58, 59, "Ring of Regeneration" },
		{ 60, 61, "Ring of Shooting Stars" },
		{ 62, 63, "Ring of Telekinesis" },
		{ 64, 65, "Robe of Scintillating Colors" },
		{ 66, 67, "Robe of Stars" },
		{ 68, 69, "Rod of Absorption" },
		{ 70, 71, "Rod of Security" },
		{ 72, 73, "Rod of the Pact Keeper, +3" },
		{ 74, 85, "Spell Scroll (level 6, 7, or 8 spell)" },
		{ 86, 87, "Staff of Fire" },
		{ 88, 89, "Staff of Frost" },
		{ 90, 90, "Staff of Power" },
		{ 91, 92, "Staff of Thunder and Lightning" },
		{ 93, 94, "Tome of Clear Thought" },
		{ 95, 97, "Wand of Polymorph" },
		{ 98, 100, "Wand of the War Mage, +3" },
	},
};

local _tItemRewardTiers = {
	{ fame = 0, tabletype = "trinkets", label = "Trinkets" },
	{ fame = 100, tabletype = "common", label = _tArcanaTableNames.common },
	{ fame = 500, tabletype = "uncommon", label = _tArcanaTableNames.uncommon },
	{ fame = 1000, tabletype = "rare", label = _tArcanaTableNames.rare },
	{ fame = 2000, tabletype = "veryrare", label = _tArcanaTableNames.veryrare },
};

function onInit()
	ActionsManager.registerModHandler(ROLL_TYPE, BetterToolsLeisureManager.modPlayRoll);
	ActionsManager.registerResultHandler(ROLL_TYPE, BetterToolsLeisureManager.onPlayRoll);
	ActionsManager.registerResultHandler(MONEY_ROLL_TYPE, BetterToolsLeisureManager.onMoneyRewardRoll);
	BetterToolsLeisureManager.ensureArcanaTables();
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
<p>Die Vorteile Rabatt, Unterkunft und Reisemöglichkeiten stehen dir zur Verfügung, sobald du den jeweiligen Bekanntheitsgrad erreichst. Mit Erreichen eines Bekanntheitsgrades erhältst du einen zufälligen Gegenstand aus der entsprechenden Kategorie. Nach jedem Mal Spielen erhältst du eine Menge an Geld, die deinem aktuellen Bekanntheitsgrad entspricht.</p>]] .. BetterToolsLeisureManager.getRewardTableLinksText() .. [[
<h>Zwischen den Abenteuern</h>
<p>Verweilst du länger an einem Ort, fällt es dir leichter an Ruhm zu kommen. Mach für jede Woche, die du an einem Ort verbringst, einen Freizeitset-Wurf. Addiere zu dem Ergebnis jeweils die Anzahl an Wochen, die du insgesamt an dem Ort bleibst. Bleibst du drei Wochen, addierst du also zu jedem deiner drei Würfe eine +3.</p>
</formattedtext>]];
end

function ensureArcanaTables()
	if not Session.IsHost then
		return;
	end

	for sRarity, _ in pairs(_tArcanaTableNames) do
		BetterToolsLeisureManager.ensureArcanaTable(sRarity);
	end
end

function ensureArcanaTable(sRarity)
	local nodeExisting = BetterToolsLeisureManager.findArcanaTable(sRarity);
	if nodeExisting then
		BetterToolsLeisureManager.setRecordCategory(nodeExisting);
		return;
	end

	local tRows = _tArcanaTables[sRarity];
	if not tRows then
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

	DB.setValue(nodeTable, "name", "string", BetterToolsLeisureManager.getArcanaTableName(sRarity));
	BetterToolsLeisureManager.setRecordCategory(nodeTable);
	DB.setValue(nodeTable, "dice", "dice", { "d100" });
	DB.setValue(nodeTable, "mod", "number", 0);
	DB.setValue(nodeTable, "resultscols", "number", 1);
	DB.setValue(nodeTable, "labelcol1", "string", "Item");
	DB.setValue(nodeTable, "description", "string", "BetterTools Freizeitset: Arcana " .. BetterToolsLeisureManager.getArcanaRarityLabel(sRarity));
	DB.setValue(nodeTable, "notes", "formattedtext", "<p>Arcana-Tabelle für zufällige magische Gegenstände.</p>");

	local nodeRows = DB.createChild(nodeTable, "tablerows");
	if not nodeRows then
		return;
	end

	for _, tRow in ipairs(tRows) do
		local nodeRow = DB.createChild(nodeRows);
		DB.setValue(nodeRow, "fromrange", "number", tRow[1] or 0);
		DB.setValue(nodeRow, "torange", "number", tRow[2] or tRow[1] or 0);

		local nodeResults = DB.createChild(nodeRow, "results");
		local nodeResult = DB.createChild(nodeResults);
		DB.setValue(nodeResult, "result", "string", tRow[3] or "");
	end
end

function setRecordCategory(nodeRecord)
	if nodeRecord then
		if DB.setCategory then
			DB.setCategory(nodeRecord, RECORD_CATEGORY);
		end
	end
end

function getArcanaTableName(sRarity)
	return _tArcanaTableNames[sRarity or ""] or "";
end

function getArcanaRarityLabel(sRarity)
	if sRarity == "common" then
		return "Common";
	elseif sRarity == "uncommon" then
		return "Uncommon";
	elseif sRarity == "rare" then
		return "Rare";
	elseif sRarity == "veryrare" then
		return "Very Rare";
	end
	return sRarity or "";
end

function findArcanaTable(sRarity)
	local sTableName = BetterToolsLeisureManager.getArcanaTableName(sRarity);
	if sTableName == "" then
		return nil;
	end

	if TableManager and TableManager.findTable then
		local nodeTable = TableManager.findTable(sTableName);
		if nodeTable then
			return nodeTable;
		end
	end

	local sTableRoot = "tables";
	if RecordDataManager and RecordDataManager.getDataPathRoot then
		sTableRoot = RecordDataManager.getDataPathRoot("table") or sTableRoot;
	end
	for _, nodeTable in ipairs(DB.getChildList(sTableRoot)) do
		local sName = DB.getValue(nodeTable, "name", "");
		if sName == sTableName then
			return nodeTable;
		end
	end
	return nil;
end

function findTrinketsTable()
	if TableManager and TableManager.findTable then
		local nodeTable = TableManager.findTable("Trinkets");
		if nodeTable then
			return nodeTable;
		end
	end

	for _, sPath in ipairs({ "tables.id-00004@D&D Free Rules", "tables.id-00004@DND2024FREERULES" }) do
		local nodeTable = DB.findNode(sPath);
		if nodeTable then
			return nodeTable;
		end
	end

	local sTableRoot = "tables";
	if RecordDataManager and RecordDataManager.getDataPathRoot then
		sTableRoot = RecordDataManager.getDataPathRoot("table") or sTableRoot;
	end
	for _, nodeTable in ipairs(DB.getChildList(sTableRoot)) do
		if DB.getValue(nodeTable, "name", "") == "Trinkets" then
			return nodeTable;
		end
	end
	return nil;
end

function findRewardTable(sTableType)
	if sTableType == "trinkets" then
		return BetterToolsLeisureManager.findTrinketsTable();
	end
	return BetterToolsLeisureManager.findArcanaTable(sTableType);
end

function getRewardTableRecordName(sTableType)
	local nodeTable = BetterToolsLeisureManager.findRewardTable(sTableType);
	if nodeTable then
		return DB.getPath(nodeTable);
	end
	if sTableType == "trinkets" then
		return "tables.id-00004@D&D Free Rules";
	end
	return "";
end

function getRewardTableLinksText()
	local tLines = { "<p><b>Tabellen</b></p>", "<linklist>" };
	for _, tTier in ipairs(_tItemRewardTiers) do
		local sRecordName = BetterToolsLeisureManager.getRewardTableRecordName(tTier.tabletype);
		if sRecordName ~= "" then
			table.insert(tLines, string.format('<link class="table" recordname="%s"><b>Table: </b>%s</link>', sRecordName, tTier.label));
		end
	end
	table.insert(tLines, "</linklist>");
	return table.concat(tLines, "\r");
end

function getReachedItemRewardTables(nOldFame, nNewFame)
	local tTables = {};
	nOldFame = tonumber(nOldFame) or 0;
	nNewFame = tonumber(nNewFame) or 0;
	if nNewFame <= nOldFame then
		return tTables;
	end

	for _, tTier in ipairs(_tItemRewardTiers) do
		if nOldFame < tTier.fame and nNewFame >= tTier.fame then
			table.insert(tTables, tTier);
		end
	end
	return tTables;
end

function performRewardTableRolls(rActor, tRewardTables)
	for _, tTier in ipairs(tRewardTables or {}) do
		local nodeTable = BetterToolsLeisureManager.findRewardTable(tTier.tabletype);
		if nodeTable and TableManager and TableManager.performRoll then
			local rTableRoll = { nodeTable = nodeTable };
			rTableRoll.aDice, rTableRoll.nMod = TableManager.getTableDice(nodeTable);
			TableManager.performRoll(nil, rActor, rTableRoll, false);
		else
			ChatManager.SystemMessage("BetterTools: Item-Tabelle nicht gefunden: " .. (tTier.label or ""));
		end
	end
end

function ensureDefaultRows(nodeLeisure)
	if not nodeLeisure then
		return;
	end
	for nIndex = 1, 3 do
		local nodeEntry = DB.createChild(nodeLeisure, "activities.slot" .. nIndex);
		DB.setValue(nodeEntry, "order", "number", nIndex);
		if nIndex == 1 and DB.getValue(nodeEntry, "selected", 0) == 0 then
			local bHasSelected = false;
			for _, nodeOther in ipairs(DB.getChildList(nodeLeisure, "activities")) do
				if DB.getValue(nodeOther, "selected", 0) == 1 then
					bHasSelected = true;
					break;
				end
			end
			if not bHasSelected then
				DB.setValue(nodeEntry, "selected", "number", 1);
			end
		end
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
	if DB.getValue(nodeActivity, "usecharisma", 0) == 1 then
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

function selectActivity(nodeActivity)
	if not nodeActivity then
		return;
	end
	local nodeActivities = DB.getChild(nodeActivity, "..");
	local sSelectedPath = DB.getPath(nodeActivity);
	for _, nodeOther in ipairs(DB.getChildList(nodeActivities)) do
		DB.setValue(nodeOther, "selected", "number", DB.getPath(nodeOther) == sSelectedPath and 1 or 0);
	end
end

function getSelectedActivity(nodeLeisure)
	if not nodeLeisure then
		return nil;
	end
	for _, nodeActivity in ipairs(DB.getChildList(nodeLeisure, "activities")) do
		if DB.getValue(nodeActivity, "selected", 0) == 1 then
			return nodeActivity;
		end
	end
	local tActivities = DB.getChildList(nodeLeisure, "activities");
	return tActivities[1];
end

function performSelectedPlay(nodeLeisure)
	BetterToolsLeisureManager.performPlay(BetterToolsLeisureManager.getSelectedActivity(nodeLeisure));
end

function performDowntime(nodeLeisure, nWeeks)
	nWeeks = math.floor(math.max(tonumber(nWeeks) or 0, 0));
	if nWeeks <= 0 then
		ChatManager.SystemMessage("BetterTools: Gib zuerst die Anzahl der Downtime-Wochen an.");
		return;
	end
	local nodeActivity = BetterToolsLeisureManager.getSelectedActivity(nodeLeisure);
	for _ = 1, nWeeks do
		BetterToolsLeisureManager.performPlay(nodeActivity, nWeeks, "Downtime: " .. nWeeks .. " Woche(n)");
	end
end

function getActivityBonus(nodeActivity)
	local nodeLeisure = DB.getChild(nodeActivity, "...");
	local nodeChar = nodeLeisure and DB.getChild(nodeLeisure, "...") or nil;
	local rActor = ActorManager.resolveActor(nodeChar);
	local rRoll = BetterToolsLeisureManager.getPlayRollFromTool(nodeActivity, rActor);
	return rRoll and rRoll.nMod or 0;
end

function performPlay(nodeActivity, nBonusMod, sExtraDesc)
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
	if (sExtraDesc or "") ~= "" then
		rRoll.sDesc = rRoll.sDesc .. "\r[" .. sExtraDesc .. "]";
	end
	rRoll.nMod = (rRoll.nMod or 0) + (tonumber(nBonusMod) or 0);
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
	local nodeLeisure = DB.findNode(rRoll.sLeisurePath or "");
	local nodeChar = BetterToolsLeisureManager.getCharacterNodeFromLeisure(nodeLeisure);
	if not nodeChar and ActorManager then
		nodeChar = ActorManager.getCreatureNode(rSource);
	end
	local nTotal = rRoll.nTotal or ActionsManager.total(rRoll);
	local nFameGain = BetterToolsLeisureManager.getFameGain(nTotal);
	local tLines = {};
	local rMoneyRoll = nil;
	local tRewardTables = {};

	if nodeRegion then
		local nOldFame = DB.getValue(nodeRegion, "fame", 0);
		local nNewFame = nOldFame + nFameGain;
		DB.setValue(nodeRegion, "fame", "number", nNewFame);
		BetterToolsLeisureManager.updateRegion(nodeRegion);
		table.insert(tLines, string.format("Ruhm: %+d (%d -> %d).", nFameGain, nOldFame, nNewFame));
		table.insert(tLines, "Bekanntheitsgrad: " .. BetterToolsLeisureManager.getFameRank(nNewFame).label .. ".");
		tRewardTables = BetterToolsLeisureManager.getReachedItemRewardTables(nOldFame, nNewFame);
		rMoneyRoll = BetterToolsLeisureManager.getMoneyRewardRoll(nodeChar, nNewFame);
		if not rMoneyRoll then
			table.insert(tLines, "Geld: keine Belohnung.");
		end
	else
		table.insert(tLines, string.format("Ruhm: %+d.", nFameGain));
	end

	local rMessage = ActionsManager.createActionMessage(rSource, rRoll);
	rMessage.text = rMessage.text .. "\r" .. table.concat(tLines, "\r");
	Comm.deliverChatMessage(rMessage);

	if rMoneyRoll then
		ActionsManager.performAction(nil, rSource, rMoneyRoll);
	end
	BetterToolsLeisureManager.performRewardTableRolls(rSource, tRewardTables);
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

function getCharacterNodeFromLeisure(nodeLeisure)
	if not nodeLeisure then
		return nil;
	end
	return DB.getChild(nodeLeisure, "...");
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
	elseif nFame > -100 then
		return { label = "Unbeliebt", dc = 15 };
	end
	return { label = "Verhasst", dc = 10 };
end

function getMoneyReward(nFame)
	nFame = tonumber(nFame) or 0;
	if nFame >= 2000 then
		return { dice = "10d10", currency = "PP" };
	elseif nFame >= 1000 then
		return { dice = "10d10", currency = "GP" };
	elseif nFame >= 500 then
		return { dice = "2d10", currency = "GP" };
	elseif nFame >= 100 then
		return { dice = "1d4", currency = "GP" };
	elseif nFame >= 0 then
		return { dice = "1d4", currency = "SP" };
	end
	return nil;
end

function getCurrencyLabel(sCurrency)
	local sCurrencyUpper = string.upper(sCurrency or "");
	if sCurrencyUpper == "PP" then
		return "Platin";
	elseif sCurrencyUpper == "GP" then
		return "Gold";
	elseif sCurrencyUpper == "EP" then
		return "Elektrum";
	elseif sCurrencyUpper == "SP" then
		return "Silber";
	elseif sCurrencyUpper == "CP" then
		return "Kupfer";
	end
	return sCurrency or "";
end

function getDiceFromFormula(sFormula)
	local nCount, nSides = string.match(sFormula or "", "^(%d+)d(%d+)$");
	nCount = tonumber(nCount) or 0;
	nSides = tonumber(nSides) or 0;
	local aDice = {};
	for _ = 1, nCount do
		table.insert(aDice, "d" .. nSides);
	end
	return aDice;
end

function getMoneyRewardRoll(nodeChar, nFame)
	local tReward = BetterToolsLeisureManager.getMoneyReward(nFame);
	if not tReward then
		return nil;
	end

	local aDice = BetterToolsLeisureManager.getDiceFromFormula(tReward.dice);
	if #aDice == 0 then
		return nil;
	end

	return {
		sType = MONEY_ROLL_TYPE,
		sDesc = "[BetterTools] Freizeitset Geld: " .. BetterToolsLeisureManager.getCurrencyLabel(tReward.currency),
		aDice = aDice,
		nMod = 0,
		sCharPath = nodeChar and DB.getPath(nodeChar) or "",
		sCurrency = tReward.currency,
		sRewardDice = tReward.dice,
	};
end

function onMoneyRewardRoll(rSource, _, rRoll)
	local nAmount = math.max(ActionsManager.total(rRoll), 0);
	local nodeChar = DB.findNode(rRoll.sCharPath or "");
	if (not nodeChar) and ActorManager then
		nodeChar = ActorManager.getCreatureNode(rSource);
	end

	local tLines = {};
	if nAmount <= 0 then
		table.insert(tLines, "Geld: keine Belohnung.");
	elseif not BetterToolsLeisureManager.addCurrencyToCharacter(nodeChar, rRoll.sCurrency, nAmount) then
		table.insert(tLines, string.format("Geld: +%d %s konnte nicht automatisch hinzugefügt werden.", nAmount, rRoll.sCurrency or ""));
	end

	local rMessage = ActionsManager.createActionMessage(rSource, rRoll);
	if #tLines > 0 then
		rMessage.text = rMessage.text .. "\r" .. table.concat(tLines, "\r");
	end
	Comm.deliverChatMessage(rMessage);
end

function addCurrencyToCharacter(nodeChar, sCurrency, nAmount)
	if not nodeChar then
		return false;
	end

	local sCurrencyLower = string.lower(sCurrency or "");
	for _, nodeCoin in ipairs(DB.getChildList(nodeChar, "coins")) do
		if string.lower(DB.getValue(nodeCoin, "name", "")) == sCurrencyLower then
			DB.setValue(nodeCoin, "amount", "number", DB.getValue(nodeCoin, "amount", 0) + nAmount);
			return true;
		end
	end

	local nodeCoins = DB.createChild(nodeChar, "coins");
	local nodeCoin = nodeCoins and DB.createChild(nodeCoins) or nil;
	if nodeCoin then
		DB.setValue(nodeCoin, "name", "string", sCurrency or "");
		DB.setValue(nodeCoin, "amount", "number", nAmount);
		return true;
	end
	return false;
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
