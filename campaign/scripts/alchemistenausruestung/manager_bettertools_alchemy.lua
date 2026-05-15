local HARVEST_ROLL_TYPE = "bettertools_alchemy_harvest";

local _tMaterialOrder = {
	"aberration", "dragon", "elemental", "fey", "celestial", "humanoid", "construct",
	"monstrosity", "plant", "giant", "ooze", "beast", "fiend", "undead",
};

local _tMaterials = {
	aberration = { label = "Aberration", names = { "Magische Essenz", "Magische Essenz+", "Kosmische Essenz" } },
	dragon = { label = "Drache", names = { "Drachenschuppe", "Drachenschuppe+", "Drachenherz" } },
	elemental = { label = "Elementar", names = { "Elementarkern", "Elementarkern+", "Elementarkristall" } },
	fey = { label = "Feenwesen", names = { "Feenstaub", "Feenstaub+", "Feenpuder" } },
	celestial = { label = "Himmlischer", names = { "Engelsblut", "Engelsblut+", "Götterblut" } },
	humanoid = { label = "Humanoider", names = { "Humanoides Hirn", "Humanoides Hirn+", "Humanoides Herz" } },
	construct = { label = "Konstrukt", names = { "Magiesehne", "Magiesehne+", "Magiekern" } },
	monstrosity = { label = "Monströsität", names = { "Monsterbrühe", "Monsterbrühe+", "Monsteressenz" } },
	plant = { label = "Pflanze", names = { "Hexenwurzel", "Hexenwurzel+", "Hexenblüte" } },
	giant = { label = "Riese", names = { "Riesenauge", "Riesenauge+", "Riesenhorn" } },
	ooze = { label = "Schlick", names = { "Schleimtropfen", "Schleimtropfen+", "Schleimperle" } },
	beast = { label = "Tier", names = { "Tierhaut", "Tierhaut+", "Tierherz" } },
	fiend = { label = "Unhold", names = { "Höllenblut", "Höllenblut+", "Dämonenblut" } },
	undead = { label = "Untoter", names = { "Ektoplasma", "Ektoplasma+", "Totensplitter" } },
};

local _tItemOrder = {
	"antiarkanum", "drachenbruehe", "alchemistenfeuer", "wutpulver", "goetterfackel", "menschlichkeit", "systemschock",
	"berserkerdunst", "egelsamen", "hehrgas", "schlitterseife", "buschdaempfe", "teufelssaeuseln", "grabesluft",
};

local _tItems = {
	antiarkanum = { label = "Anti-Arkanum", material = "aberration" },
	drachenbruehe = { label = "Drachenbrühe", material = "dragon" },
	alchemistenfeuer = { label = "Alchemistenfeuer", material = "elemental" },
	wutpulver = { label = "Wutpulver", material = "fey" },
	goetterfackel = { label = "Götterfackel", material = "celestial" },
	menschlichkeit = { label = "Menschlichkeit", material = "humanoid" },
	systemschock = { label = "Systemschock", material = "construct" },
	berserkerdunst = { label = "Berserkerdunst", material = "monstrosity" },
	egelsamen = { label = "Egelsamen", material = "plant" },
	hehrgas = { label = "Hehrgas", material = "giant" },
	schlitterseife = { label = "Schlitterseife", material = "ooze" },
	buschdaempfe = { label = "Buschdämpfe", material = "beast" },
	teufelssaeuseln = { label = "Teufelssäuseln", material = "fiend" },
	grabesluft = { label = "Grabesluft", material = "undead" },
};

local MATERIAL_UNITS_PER_ITEM = 6;

function onInit()
	ActionsManager.registerResultHandler(HARVEST_ROLL_TYPE, BetterToolsAlchemyManager.onHarvestRoll);
	BetterToolsAlchemyManager.ensureCraftedItemRecords();
end

function getToolText()
	return [[<formattedtext>
<h>Alchemistenausrüstung</h>
<p><i>Genutztes Attribut: Intelligenz</i></p>
<p>Mit Alchemistenausrüstung schaffst du Gegenstände aus Chemikalien und Monsterteilen, die andere Kreaturen schwächen und verletzen können.</p>
<p>Alchemistenausrüstung enthält eine Reihe von Instrumenten wie Phiolen, Brenner, Kolben und einen Beutel mit grundlegenden Materialien, wie etwa Salz, Eisenpulver oder sterilisiertes Wasser. Sie wiegen 8 Pfund und kosten 50 Gold.</p>
<h>Fertigkeiten</h>
<p>Folgende Beispiele zeigen auf, inwiefern andere Fertigkeiten von der Übung in Brauerausrüstung profitieren könnten. Es handelt sich dabei lediglich um Vorschläge; sei kreativ!</p>
<p><b>Arkana.</b> Mittels Alchemistenausrüstung können weitere Informationen über Zaubertränke und dergleichen in Erfahrung gebracht werden.</p>
<p><b>Nachforschung.</b> Wenn du einen Raum nach Hinweisen inspizierst, kann dir dein Wissen über alchemistische Prozesse Einsicht in eventuelle Chemikalien oder ähnliche Substanzen geben, die verwendet wurden.</p>
<p><b>Heilkunde.</b> Durch Übung mit Alchemistenausrüstung kannst du Gifte oder andere Substanzen einfacher identifizieren.</p>
<h>Materialbeschaffung</h>
<p>Zusätzlich zu den Chemikalien, die du stets bei dir trägst, benötigst du für die Herstellung alchemistischer Gegenstände Monstermaterialien. Diese erhältst du, indem du getötete Monster ausweidest.</p>
<h>Monster ausweiden</h>
<p>Sobald eine Kreatur gestorben ist, kannst du einen Intelligenz (Alchemistenausrüstung)-Wurf ablegen, um sie auszuweiden. Diesen Wurf tätigst du für jeden auszuweidenden Kadaver. Pro Kadaver brauchst du 1 Minute für deine Arbeit.</p>
<p>Welche Materialien von einer Kreatur zu erhalten sind, ist von ihrem Typ abhängig und kann in der untenstehenden Tabelle eingesehen werden.</p>
<p>Abhängig vom Ergebnis deines Wurfes erhältst du gewöhnliche oder seltenere Materialien. Je seltener das Material desto grösser seine Potenz bei der Herstellung von Gegenständen.</p>
<h>Monstermaterialien</h>
<table>
<tr><td><b>SG / Stufe</b></td><td><b>Aberration</b></td><td><b>Drache</b></td><td><b>Elementar</b></td><td><b>Feenwesen</b></td><td><b>Himmlischer</b></td><td><b>Humanoider</b></td><td><b>Konstrukt</b></td></tr>
<tr><td>10 / 1</td><td>Magische Essenz</td><td>Drachenschuppe</td><td>Elementarkern</td><td>Feenstaub</td><td>Engelsblut</td><td>Humanoides Hirn</td><td>Magiesehne</td></tr>
<tr><td>15 / 2</td><td>Magische Essenz+</td><td>Drachenschuppe+</td><td>Elementarkern+</td><td>Feenstaub+</td><td>Engelsblut+</td><td>Humanoides Hirn+</td><td>Magiesehne+</td></tr>
<tr><td>20 / 3</td><td>Kosmische Essenz</td><td>Drachenherz</td><td>Elementarkristall</td><td>Feenpuder</td><td>Götterblut</td><td>Humanoides Herz</td><td>Magiekern</td></tr>
</table>
<table>
<tr><td><b>SG / Stufe</b></td><td><b>Monströsität</b></td><td><b>Pflanze</b></td><td><b>Riese</b></td><td><b>Schlick</b></td><td><b>Tier</b></td><td><b>Unhold</b></td><td><b>Untoter</b></td></tr>
<tr><td>10 / 1</td><td>Monsterbrühe</td><td>Hexenwurzel</td><td>Riesenauge</td><td>Schleimtropfen</td><td>Tierhaut</td><td>Höllenblut</td><td>Ektoplasma</td></tr>
<tr><td>15 / 2</td><td>Monsterbrühe+</td><td>Hexenwurzel+</td><td>Riesenauge+</td><td>Schleimtropfen+</td><td>Tierhaut+</td><td>Höllenblut+</td><td>Ektoplasma+</td></tr>
<tr><td>20 / 3</td><td>Monsteressenz</td><td>Hexenblüte</td><td>Riesenhorn</td><td>Schleimperle</td><td>Tierherz</td><td>Dämonenblut</td><td>Totensplitter</td></tr>
</table>
<h>Herstellung</h>
<p>Um alchemistische Gegenstände herzustellen, benötigst du mindestens 1 Stunde Zeit. Die Herstellung zählt nicht als anstrengende Aktivität, weswegen du sie auch während einer Kurzen Rast ausführen und trotzdem deren Effekte erhalten kannst. Welche Gegenstände du herstellen kannst, siehst du weiter unten.</p>
<h>Alchemistische Gegenstände</h>
<p>Im Folgenden kannst du die Gegenstände einsehen, die du mit Alchemistenausrüstung herstellen kannst. Falls ein Gegenstand einen Rettungswurf erfordert, errechnet sich der SG für diesen folgendermaßen: 8 + deinem Übungsbonus + deinem Intelligenzmodifikator.</p>
<h>Anti-Arkanum</h>
<p><i>Benötigt Aberration-Materialien</i></p>
<p>Als Bonusaktion kannst du das Anti-Arkanum benutzen, um eine Kreatur innerhalb 30 ft. von dir sofort einen Konzentrationswurf für einen Zauber oder Effekt ablegen zu lassen, auf den sie sich konzentriert.</p>
<p><b>Auf Stufe 2:</b> Die Reichweite des Anti-Arkanums steigt auf 60 ft. und die Kreatur hat einen Malus von -2 auf den Konzentrationswurf.</p>
<p><b>Auf Stufe 3:</b> Die Reichweite des Anti-Arkanums steigt auf 90 ft. und die Kreatur hat einen Malus von -4 auf den Konzentrationswurf.</p>
<h>Drachenbrühe</h>
<p><i>Benötigt Drachen-Materialien</i></p>
<p>Als Aktion kannst du die Drachenbrühe verwenden, um daraufhin eine von dir ausgehende Fläche mit Drachenatem zu füllen. Die Form der Fläche entspricht der Art des Drachen von dem du die Materialien erhalten hast, ebenso wie der dazugehörige Rettungswurf und Schadenstyp. Der Atem bleibt drei Runden bestehen und verschwindet zu Beginn deines entsprechenden Zuges. Bewegt sich eine Kreatur zum ersten Mal in einem Zug in den Atem oder startet ihren Zug in ihm, erleidet sie 2W10 Schaden des entsprechenden Typs, ohne einen Rettungswurf abgelegt zu haben.</p>
<p>Bei Monstern des Typs Drache, die keinen bestimmten Schadenstypen besitzen (bspw. Pseudodrachen oder Wyvern), verursacht die Drachenbrühe Energieschaden.</p>
<p><b>Auf Stufe 2:</b> Der Schaden steigt auf 4W6.</p>
<p><b>Auf Stufe 3:</b> Der Schaden steigt auf 6W6.</p>
<h>Alchemistenfeuer</h>
<p><i>Benötigt Elementar-Materialien</i></p>
<p>Als Bonusaktion kannst du Alchemistenfeuer bis zu 20 ft. weit werfen. Führe einen Fernkampfangriff gegen eine Kreatur oder ein Objekt aus. Du kannst deinen Übungsbonus für diesen Angriff verwenden. Bei einem Treffer erleidet das Ziel zu Beginn jeder seiner Runden 1d8 Schaden der dem Element des Elementars entspricht von dem du das Material erhalten hast. Eine Kreatur kann diesen Schaden beenden, indem sie ihre Aktion nutzt, um einen Geschicklichkeitsrettungswurf zu machen, um die Flammen zu löschen.</p>
<p><b>Auf Stufe 2:</b> Der Schaden steigt auf 2d8.</p>
<p><b>Auf Stufe 3:</b> Der Schaden steigt auf 3d8.</p>
<h>Wutpulver</h>
<p><i>Benötigt Feenwesen-Materialien</i></p>
<p>Als Aktion wirfst du das Wutpulver auf eine Kreatur innerhalb 5 ft. von dir. Sie muss einen Weisheitsrettungswurf ablegen. Bei einem Fehlschlag wird sie bezaubert und von tiefstem Zorn erfüllt. Zu Beginn jedes ihrer nächsten Züge muss eine betroffene Kreatur ihren Zug nutzen, um einem zufälligen Verbündeten möglichst viel Schaden zuzufügen. Kann keiner Kreatur Schaden zugefügt werden, tut sie in ihrem Zug nichts.</p>
<p><b>Auf Stufe 2:</b> Die Reichweite des Wutpulvers steigt auf 30 ft.</p>
<p><b>Auf Stufe 3:</b> Die Reichweite des Wutpulvers steigt auf 90 ft.</p>
<h>Götterfackel</h>
<p><i>Benötigt Himmlischer-Materialien</i></p>
<p>Als Bonusaktion kannst du diese Fackel entzünden, um kreisförmige Fläche mit einem Radius von 20 ft. für 3 Runden hell zu erleuchten. Das Licht bewegt sich mit dir und deckt sämtliche unsichtbaren Kreaturen und Objekte auf und erleuchtet selbst magische Dunkelheit. Monströsitäten, Unholde und Untote erleiden zudem Nachteil auf ihre Angriffswürfe.</p>
<p><b>Auf Stufe 2:</b> Der Radius des Fackelscheins steigt auf 30 ft.</p>
<p><b>Auf Stufe 3:</b> Der Radius des Fackelscheins steigt auf 40 ft.</p>
<h>Menschlichkeit</h>
<p><i>Benötigt Humanoider-Materialien</i></p>
<p>Als Bonusaktion kannst du die Menschlichkeit auf eine beliebige Kreatur innerhalb 120 ft. anwenden. Wähle ein beliebiges Attribut. Die Kreatur muss den dazugehörigen Rettungswurf schaffen oder ihr Attributswert wird auf 10 gesetzt. Der Effekt dauert 1 Minute an. Eine Kreatur kann ihre Aktion verwenden, um den Rettungswurf zu wiederholen und den Effekt bei Erfolg zu beenden.</p>
<p><b>Auf Stufe 2:</b> Du kannst bis zu zwei Kreaturen auswählen.</p>
<p><b>Auf Stufe 3:</b> Du kannst bis zu drei Kreaturen auswählen.</p>
<h>Systemschock</h>
<p><i>Benötigt Konstrukt-Materialien</i></p>
<p>Als Bonusaktion rufst du einen Systemschock bei Kreaturen in einem von dir ausgehenden 15 ft.-Kegel hervor. Jede Kreatur muss einen Geschicklichkeitsrettungswurf schaffen oder erhält einen Malus von -2 auf ihre Rüstungsklasse. Jeder Angriff auf eine betroffene Kreatur verringert den Malus um 1.</p>
<p><b>Auf Stufe 2:</b> Der Malus beginnt bei -3.</p>
<p><b>Auf Stufe 3:</b> Der Malus beginnt bei -4.</p>
<h>Berserkerdunst</h>
<p><i>Benötigt Monströsität-Materialien</i></p>
<p>Als Aktion verstreust du den Berserkerdunst in einem von dir ausgehenden 10 ft.-Kegel. Alle Kreaturen in diesem Bereich müssen einen Weisheitsrettungswurf ablegen. Bei einem Fehlschlag werden sie von Blutrünstigkeit erfüllt. Fügt sie einer anderen Kreatur Schaden zu, erleidet sie selbst den gleiche Menge an Schaden. Der Effekt dauert 1 Minute an. Eine Kreatur kann ihre Aktion verwenden, um den Effekt zu beenden.</p>
<p><b>Auf Stufe 2:</b> Die Dimensionen des Kegels steigen auf 20 ft.</p>
<p><b>Auf Stufe 3:</b> Die Dimensionen des Kegels steigen auf 30 ft.</p>
<h>Egelsamen</h>
<p><i>Benötigt Pflanze-Materialien</i></p>
<p>Als Aktion pflanzt du einen Egelsamen auf einer Kreatur innerhalb von 60 ft. von dir. Die Kreatur muss einen Konstitutionsrettungswurf schaffen oder erleidet 1 Stufe Erschöpfung. In deinen nächsten Zügen kannst du deine Bonusaktion verwenden, um die Kreatur den Rettungswurf wiederholen zu lassen, sofern sie sich innerhalb 60 ft. von dir befindet. Mit jedem Fehlschlag erhält sie eine weitere Stufe Erschöpfung. Eine Kreatur kann auf diese Weise maximal Stufe 3 an Erschöpfung erhalten. Verwendest du deine Bonusaktion nicht hierfür, fällt der Egelsamen ab und die Kreatur muss keine weiteren Rettungswürfe ablegen.</p>
<p><b>Auf Stufe 2:</b> Du kannst bis zu zwei Kreaturen auswählen. Benutzt du in Folgezügen deine Bonusaktion dafür, müssen alle betroffenen Kreaturen den Rettungswurf wiederholen.</p>
<p><b>Auf Stufe 3:</b> Du kannst bis zu drei Kreaturen auswählen. Benutzt du in Folgezügen deine Bonusaktion dafür, müssen alle betroffenen Kreaturen den Rettungswurf wiederholen.</p>
<h>Hehrgas</h>
<p><i>Benötigt Riese-Materialien</i></p>
<p>Als Bonusaktion kannst du Hehrgas bis zu 20 ft. weit werfen. Führe einen Fernkampfangriff gegen eine Kreatur aus. Du kannst deinen Übungsbonus für diesen Angriff verwenden. Bei einem Treffer wird der Kreatur tiefste Ehrfurcht eingeflößt. Greift sie dich oder einen deiner Verbündeten an, muss sie einen Weisheitsrettungswurf ablegen. Bei einem Fehlschlag trifft sie automatisch nicht. Zusätzlich fügen sämtliche ihrer Angriffe -1W4 Schaden zu.</p>
<p><b>Auf Stufe 2:</b> Der Schadensmalus steigt auf -2W4.</p>
<p><b>Auf Stufe 3:</b> Der Schadensmalus steigt auf -3W4.</p>
<h>Schlitterseife</h>
<p><i>Benötigt Schlick-Materialien</i></p>
<p>Als Aktion kannst du die Schlitterseife auf eine quadratische Fläche mit einer Seitenlänge von 30 ft. anwenden, die innerhalb 60 ft. von dir liegt. Kreaturen, die diesen Bereich betreten, müssen einen Geschicklichkeitsrettungswurf ablegen. Schlägt dieser fehl, schlittern sie in derselben Richtung über die Fläche in der sie diese betreten haben. Die dabei zurückgelegte Entfernung zählt nicht zu der Bewegungsrate der Kreatur. Eine schlitternde Kreatur kann ihre Richtung nicht ändern. Stößt sie während des Schlitterns gegen eine Wand oder eine andere Kreatur, stoppt die schlitternde Kreatur. Die Kreatur mit der sie zusammengestoßen ist, schlittert weiter, sofern sie sich auf der betroffenen Fläche befindet. Die Seife bleibt für 1 Minute bestehen.</p>
<p><b>Auf Stufe 2:</b> Eine schlitternde Kreatur erhält den Zustand Liegend.</p>
<p><b>Auf Stufe 3:</b> Eine schlitternde Kreatur erhält den Zustand Liegend und ihre Bewegungsrate wird für den Rest ihres Zuges auf 0 gesetzt.</p>
<h>Buschdämpfe</h>
<p><i>Benötigt Tier-Materialien</i></p>
<p>Als Aktion wirfst du die Buschdämpfe auf einen Punkt innerhalb 60 ft. von dir. Von diesem Punkt ausgehend, füllen die Dämpfe einen Würfel mit einer Seitenlänge von 10 ft. Eine Kreatur verliert sämtliche Resistenzen, solange sie sich innerhalb der Kugel befindet. Die Dämpfe halten 1 Minute an an.</p>
<p><b>Auf Stufe 2:</b> Die Seitenlänge des Würfels steigt auf 20 ft.</p>
<p><b>Auf Stufe 3:</b> Die Seitenlänge des Würfels steigt auf 30 ft.</p>
<h>Teufelssäuseln</h>
<p><i>Benötigt Unhold-Materialien</i></p>
<p>Als Aktion öffnest du das Teufelssäuseln. Jede Kreatur innerhalb von 30 ft. zu dir, die hören kann, erleidet 1W10 Punkte psychischen Schaden. Zusätzlich muss sie einen Charismarettungswurf schaffen oder ist bezaubert. Der Effekt Der Effekt dauert 1 Runde an.</p>
<p><b>Auf Stufe 2:</b> Der Effekt dauert 3 Runden an.</p>
<p><b>Auf Stufe 3:</b> Der Effekt dauert 1 Minute an</p>
<h>Grabesluft</h>
<p><i>Benötigt Untote-Materialien</i></p>
<p>Als Bonusaktion verstreust du die Grabesluft in einem von dir ausgehenden 20 ft.-Kegel. Sämtliche Kreaturen, die sich in dem Kegel befinden, können für die nächste Minute nicht geheilt werden. Der Effekt dauert 1 Minute an. Eine betroffene Kreatur kann ihre Aktion verwenden, um einen Konstitutionsrettungswurf abzulegen. Bei Erfolg endet der Effekt für sie.</p>
<p><b>Auf Stufe 2:</b> Die Dimensionen des Kegels steigen auf 30 ft.</p>
<p><b>Auf Stufe 3:</b> Die Dimensionen des Kegels steigen auf 40 ft.</p>
</formattedtext>]];
end

function ensureDefaultRows(nodeAlchemy)
	if not nodeAlchemy then
		return;
	end
	for nIndex, sKey in ipairs(_tMaterialOrder) do
		local tMaterial = _tMaterials[sKey];
		local nodeRow = DB.createChild(nodeAlchemy, "materials." .. sKey);
		DB.setValue(nodeRow, "order", "number", nIndex);
		DB.setValue(nodeRow, "materialkey", "string", sKey);
		DB.setValue(nodeRow, "label", "string", tMaterial.label);
		BetterToolsAlchemyManager.updateMaterialDisplays(nodeRow);
	end
	if DB.getValue(nodeAlchemy, "creaturetype", "") == "" then
		DB.setValue(nodeAlchemy, "creaturetype", "string", "aberration");
	end
	DB.setValue(nodeAlchemy, "creaturetypelabel", "string", BetterToolsAlchemyManager.getCreatureTypeLabel(DB.getValue(nodeAlchemy, "creaturetype", "aberration")));
	if DB.getValue(nodeAlchemy, "craftitem", "") == "" then
		DB.setValue(nodeAlchemy, "craftitem", "string", "antiarkanum");
	end
	DB.setValue(nodeAlchemy, "craftitemlabel", "string", BetterToolsAlchemyManager.getItemLabel(DB.getValue(nodeAlchemy, "craftitem", "antiarkanum")));
	if DB.getValue(nodeAlchemy, "craftlevel", 0) <= 0 then
		DB.setValue(nodeAlchemy, "craftlevel", "number", 1);
	end
end

function getCreatureTypeLabel(sCreatureType)
	return (_tMaterials[sCreatureType or ""] or _tMaterials.aberration).label;
end

function getItemLabel(sItem)
	return (_tItems[sItem or ""] or _tItems.antiarkanum).label;
end

function getItemKeyForMaterial(sMaterial)
	for _, sItem in ipairs(_tItemOrder) do
		if (_tItems[sItem] or {}).material == sMaterial then
			return sItem;
		end
	end
	return "";
end

function openCreatureTypePicker(nodeAlchemy)
	BetterToolsAlchemyManager.openPicker(nodeAlchemy, "bettertools_alchemy_creature_picker", "Monsterart auswählen");
end

function openItemPicker(nodeAlchemy)
	BetterToolsAlchemyManager.openPicker(nodeAlchemy, "bettertools_alchemy_item_picker", "Gegenstand auswählen");
end

function openPicker(nodeAlchemy, sClass, sTitle)
	if not nodeAlchemy then
		return;
	end
	local nodePicker = DB.createChild(nodeAlchemy, "picker");
	DB.setValue(nodePicker, "name", "string", sTitle);
	DB.setValue(nodePicker, "targetpath", "string", DB.getPath(nodeAlchemy));
	Interface.openWindow(sClass, nodePicker);
end

function chooseCreatureType(nodePicker, sCreatureType)
	local nodeAlchemy = BetterToolsAlchemyManager.getPickerTarget(nodePicker);
	if not nodeAlchemy then
		return;
	end
	DB.setValue(nodeAlchemy, "creaturetype", "string", sCreatureType or "aberration");
	DB.setValue(nodeAlchemy, "creaturetypelabel", "string", BetterToolsAlchemyManager.getCreatureTypeLabel(sCreatureType));
end

function chooseItem(nodePicker, sItem)
	local nodeAlchemy = BetterToolsAlchemyManager.getPickerTarget(nodePicker);
	if not nodeAlchemy then
		return;
	end
	sItem = sItem or "antiarkanum";
	local nLevel = BetterToolsAlchemyManager.getHighestAvailableItemLevel(nodeAlchemy, sItem);
	if nLevel <= 0 then
		ChatManager.SystemMessage("BetterTools: Für diesen Gegenstand besitzt du keine passenden Materialien.");
		return;
	end
	DB.setValue(nodeAlchemy, "craftitem", "string", sItem);
	DB.setValue(nodeAlchemy, "craftitemlabel", "string", BetterToolsAlchemyManager.getItemLabel(sItem));
	DB.setValue(nodeAlchemy, "craftlevel", "number", nLevel);
end

function getPickerTarget(nodePicker)
	if not nodePicker then
		return nil;
	end
	return DB.findNode(DB.getValue(nodePicker, "targetpath", ""));
end

function getAlchemyNodeFromMaterialRow(nodeRow)
	if not nodeRow then
		return nil;
	end
	local sPath = DB.getPath(nodeRow);
	local sAlchemyPath = string.match(sPath or "", "^(.-)%.materials%.[^%.]+$");
	if sAlchemyPath and sAlchemyPath ~= "" then
		return DB.findNode(sAlchemyPath);
	end
	return nil;
end

function getHighestAvailableItemLevel(nodeAlchemy, sItem)
	if not nodeAlchemy then
		return 0;
	end

	local tItem = _tItems[sItem or ""] or _tItems.antiarkanum;
	local nodeMaterial = DB.getChild(nodeAlchemy, "materials." .. tItem.material);
	if not nodeMaterial then
		return 0;
	end

	for nLevel = 3, 1, -1 do
		if DB.getValue(nodeMaterial, "p" .. nLevel .. "units", 0) >= MATERIAL_UNITS_PER_ITEM then
			return nLevel;
		end
	end
	return 0;
end

function hasMaterialsForItem(nodePicker, sItem)
	local nodeAlchemy = BetterToolsAlchemyManager.getPickerTarget(nodePicker);
	return BetterToolsAlchemyManager.getHighestAvailableItemLevel(nodeAlchemy, sItem) > 0;
end

function performHarvest(nodeAlchemy)
	if not nodeAlchemy then
		return;
	end

	local nodeChar = DB.getChild(nodeAlchemy, "...");
	local rActor = ActorManager.resolveActor(nodeChar);
	local nMod = BetterToolsAlchemyManager.getToolTotal(nodeChar);
	local sCreatureType = DB.getValue(nodeAlchemy, "creaturetype", "aberration");
	local tMaterial = _tMaterials[sCreatureType] or _tMaterials.aberration;

	local rRoll = {
		sType = HARVEST_ROLL_TYPE,
		sDesc = "[BetterTools] Alchemistenausrüstung: " .. tMaterial.label .. " ausweiden",
		aDice = { "d20" },
		nMod = nMod,
		sAlchemyPath = DB.getPath(nodeAlchemy),
		sCreatureType = sCreatureType,
	};
	ActionsManager.performAction(nil, rActor, rRoll);
end

function onHarvestRoll(rSource, _, rRoll)
	local nodeAlchemy = DB.findNode(rRoll.sAlchemyPath or "");
	local sCreatureType = rRoll.sCreatureType or "aberration";
	local tMaterial = _tMaterials[sCreatureType] or _tMaterials.aberration;
	local nTotal = rRoll.nTotal or ActionsManager.total(rRoll);

	local nLevel = 0;
	if nTotal >= 20 then
		nLevel = 3;
	elseif nTotal >= 15 then
		nLevel = 2;
	elseif nTotal >= 10 then
		nLevel = 1;
	end

	local tLines = {};
	if nLevel > 0 and nodeAlchemy then
		local nodeRow = DB.createChild(nodeAlchemy, "materials." .. sCreatureType);
		local sField = "p" .. nLevel .. "units";
		DB.setValue(nodeRow, sField, "number", DB.getValue(nodeRow, sField, 0) + MATERIAL_UNITS_PER_ITEM);
		BetterToolsAlchemyManager.updateMaterialDisplays(nodeRow);
		table.insert(tLines, string.format("Erhalten: %s (Stufe %d).", tMaterial.names[nLevel], nLevel));
	else
		table.insert(tLines, "Kein verwertbares Material erhalten.");
	end

	local rMessage = ActionsManager.createActionMessage(rSource, rRoll);
	rMessage.text = rMessage.text .. "\r" .. table.concat(tLines, "\r");
	Comm.deliverChatMessage(rMessage);
end

function craftSelectedItem(nodeAlchemy)
	if not nodeAlchemy then
		return;
	end
	BetterToolsAlchemyManager.ensureDefaultRows(nodeAlchemy);
	BetterToolsAlchemyManager.ensureCraftedItemRecords();

	local sItemKey = DB.getValue(nodeAlchemy, "craftitem", "antiarkanum");
	local nLevel = math.max(math.min(DB.getValue(nodeAlchemy, "craftlevel", 1), 3), 1);
	DB.setValue(nodeAlchemy, "craftlevel", "number", nLevel);

	local tItem = _tItems[sItemKey] or _tItems.antiarkanum;
	local nodeMaterial = DB.getChild(nodeAlchemy, "materials." .. tItem.material);
	local sField = "p" .. nLevel .. "units";
	local nAvailable = DB.getValue(nodeMaterial, sField, 0);

	if nAvailable < MATERIAL_UNITS_PER_ITEM then
		ChatManager.SystemMessage(string.format("BetterTools: Für %s Stufe %d fehlt 1 %s-Material Stufe %d.",
			tItem.label, nLevel, (_tMaterials[tItem.material] or {}).label or "passendes", nLevel));
		return;
	end

	DB.setValue(nodeMaterial, sField, "number", nAvailable - MATERIAL_UNITS_PER_ITEM);
	BetterToolsAlchemyManager.updateMaterialDisplays(nodeMaterial);

	local nodeChar = DB.getChild(nodeAlchemy, "...");
	BetterToolsAlchemyManager.addCraftedItemToInventory(nodeChar, sItemKey, nLevel);
	ChatManager.SystemMessage(string.format("BetterTools: %s Stufe %d hergestellt und ins Inventar gelegt.",
		tItem.label, nLevel));
end

function ensureCraftedItemRecords()
	for _, sItemKey in ipairs(_tItemOrder) do
		for nLevel = 1, 3 do
			BetterToolsAlchemyManager.ensureCraftedItemRecord(sItemKey, nLevel);
		end
	end
end

function ensureCraftedItemRecord(sItemKey, nLevel)
	local tItem = _tItems[sItemKey] or _tItems.antiarkanum;
	local sName = BetterToolsAlchemyManager.getCraftedItemName(sItemKey, nLevel);
	local nodeItem = BetterToolsAlchemyManager.findCraftedItemRecord(sName);
	if not nodeItem then
		nodeItem = BetterToolsAlchemyManager.createCraftedItemRecord(sItemKey, nLevel);
	end
	if nodeItem then
		BetterToolsAlchemyManager.populateCraftedItemRecord(nodeItem, sItemKey, nLevel);
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

function getCraftedItemName(sItemKey, nLevel)
	local tItem = _tItems[sItemKey] or _tItems.antiarkanum;
	return string.format("%s (Stufe %d)", tItem.label, nLevel);
end

function findCraftedItemRecord(sName)
	for _, nodeItem in ipairs(DB.getChildList(BetterToolsAlchemyManager.getItemRoot())) do
		if DB.getValue(nodeItem, "name", "") == sName and DB.getValue(nodeItem, "subtype", "") == "Alchemischer Gegenstand" then
			return nodeItem;
		end
	end
	return nil;
end

function createCraftedItemRecord(sItemKey, nLevel)
	local nodeItem = DB.createChild(BetterToolsAlchemyManager.getItemRoot());
	if not nodeItem then
		return nil;
	end
	BetterToolsAlchemyManager.populateCraftedItemRecord(nodeItem, sItemKey, nLevel);
	return nodeItem;
end

function populateCraftedItemRecord(nodeItem, sItemKey, nLevel)
	if not nodeItem then
		return;
	end
	DB.setValue(nodeItem, "name", "string", BetterToolsAlchemyManager.getCraftedItemName(sItemKey, nLevel));
	DB.setValue(nodeItem, "count", "number", 1);
	DB.setValue(nodeItem, "isidentified", "number", 1);
	DB.setValue(nodeItem, "locked", "number", 1);
	DB.setValue(nodeItem, "type", "string", "Adventuring Gear");
	DB.setValue(nodeItem, "subtype", "string", "Alchemischer Gegenstand");
	DB.setValue(nodeItem, "rarity", "string", BetterToolsAlchemyManager.getCraftedItemRarity(nLevel));
	DB.setValue(nodeItem, "weight", "number", 0);
	DB.setValue(nodeItem, "cost", "string", "");
	DB.setValue(nodeItem, "description", "formattedtext", BetterToolsAlchemyManager.getCraftedItemDescription(sItemKey, nLevel));
end

function addCraftedItemToInventory(nodeChar, sItemKey, nLevel)
	if not nodeChar then
		return nil;
	end

	local nodeSource = BetterToolsAlchemyManager.ensureCraftedItemRecord(sItemKey, nLevel);
	if not nodeSource then
		return nil;
	end

	local nodeExisting = BetterToolsAlchemyManager.findCraftedInventoryItem(nodeChar, DB.getValue(nodeSource, "name", ""));
	if nodeExisting then
		DB.setValue(nodeExisting, "count", "number", DB.getValue(nodeExisting, "count", 0) + 1);
		return nodeExisting;
	end

	local nodeInventory = DB.createChild(nodeChar, "inventorylist");
	local nodeItem = nodeInventory and DB.createChild(nodeInventory) or nil;
	if not nodeItem then
		return nil;
	end

	BetterToolsAlchemyManager.copyItemRecord(nodeSource, nodeItem);
	DB.setValue(nodeItem, "count", "number", 1);
	DB.setValue(nodeItem, "carried", "number", 1);
	return nodeItem;
end

function findCraftedInventoryItem(nodeChar, sName)
	if not nodeChar or sName == "" then
		return nil;
	end

	for _, nodeItem in ipairs(DB.getChildList(nodeChar, "inventorylist")) do
		if DB.getValue(nodeItem, "name", "") == sName and DB.getValue(nodeItem, "subtype", "") == "Alchemischer Gegenstand" then
			return nodeItem;
		end
	end
	return nil;
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
end

function getCraftedItemRarity(nLevel)
	local tRarities = { "uncommon", "rare", "very rare" };
	return tRarities[math.max(math.min(tonumber(nLevel) or 1, 3), 1)] or "uncommon";
end

function replacePlain(sText, sOld, sNew)
	local nStart, nEnd = string.find(sText, sOld, 1, true);
	if not nStart then
		return sText;
	end
	return string.sub(sText, 1, nStart - 1) .. sNew .. string.sub(sText, nEnd + 1);
end

function stripItemHeader(sBlock)
	sBlock = string.gsub(sBlock, "^%s*<h>.-</h>%s*", "");
	sBlock = string.gsub(sBlock, "^%s*<p><i>Benötigt .-</i></p>%s*", "");
	return sBlock;
end

function stripItemLevelParagraphs(sBlock)
	sBlock = string.gsub(sBlock, "<p><b>Auf Stufe 2:</b>.-</p>", "");
	sBlock = string.gsub(sBlock, "<p><b>Auf Stufe 3:</b>.-</p>", "");
	return sBlock;
end

function addSaveDCToItemText(sBlock)
	local sDC = " (8 + deinem Übungsbonus + deinem Intelligenzmodifikator)";
	local tPatterns = {
		"Geschicklichkeitsrettungswurf",
		"Weisheitsrettungswurf",
		"Konstitutionsrettungswurf",
		"Charismarettungswurf",
		"Rettungswurf",
	};

	for _, sPattern in ipairs(tPatterns) do
		sBlock = BetterToolsAlchemyManager.replacePlain(sBlock, sPattern .. sDC, sPattern);
		sBlock = string.gsub(sBlock, sPattern, sPattern .. sDC);
	end
	sBlock = BetterToolsAlchemyManager.replacePlain(sBlock, "ohne einen Rettungswurf" .. sDC, "ohne einen Rettungswurf");
	sBlock = BetterToolsAlchemyManager.replacePlain(sBlock, "dazugehörige Rettungswurf" .. sDC .. " und Schadenstyp", "dazugehörige Rettungswurf und Schadenstyp");
	return sBlock;
end

function applyCraftedItemLevel(sItemKey, nLevel, sBlock)
	nLevel = math.max(math.min(tonumber(nLevel) or 1, 3), 1);
	sBlock = BetterToolsAlchemyManager.stripItemHeader(sBlock);
	sBlock = BetterToolsAlchemyManager.stripItemLevelParagraphs(sBlock);
	sBlock = BetterToolsAlchemyManager.replacePlain(sBlock, "Der Effekt Der Effekt dauert 1 Runde an.", "Der Effekt dauert 1 Runde an.");
	if nLevel <= 1 then
		return BetterToolsAlchemyManager.addSaveDCToItemText(sBlock);
	end

	local tReplacements = {
		antiarkanum = {
			[2] = {
				{ "innerhalb 30 ft. von dir", "innerhalb 60 ft. von dir" },
				{ "ablegen zu lassen, auf den sie sich konzentriert.", "ablegen zu lassen, auf den sie sich konzentriert. Die Kreatur hat einen Malus von -2 auf den Konzentrationswurf." },
			},
			[3] = {
				{ "innerhalb 30 ft. von dir", "innerhalb 90 ft. von dir" },
				{ "ablegen zu lassen, auf den sie sich konzentriert.", "ablegen zu lassen, auf den sie sich konzentriert. Die Kreatur hat einen Malus von -4 auf den Konzentrationswurf." },
			},
		},
		drachenbruehe = {
			[2] = { { "2W10 Schaden", "4W10 Schaden" } },
			[3] = { { "2W10 Schaden", "6W10 Schaden" } },
		},
		alchemistenfeuer = {
			[2] = { { "1d8 Schaden", "2d8 Schaden" } },
			[3] = { { "1d8 Schaden", "3d8 Schaden" } },
		},
		wutpulver = {
			[2] = { { "innerhalb 5 ft. von dir", "innerhalb 30 ft. von dir" } },
			[3] = { { "innerhalb 5 ft. von dir", "innerhalb 90 ft. von dir" } },
		},
		goetterfackel = {
			[2] = { { "Radius von 20 ft.", "Radius von 30 ft." } },
			[3] = { { "Radius von 20 ft.", "Radius von 40 ft." } },
		},
		menschlichkeit = {
			[2] = { { "auf eine beliebige Kreatur", "auf bis zu zwei beliebige Kreaturen" }, { "Die Kreatur muss", "Jede Kreatur muss" }, { "ihr Attributswert", "ihr jeweiliger Attributswert" }, { "Eine Kreatur kann", "Eine betroffene Kreatur kann" } },
			[3] = { { "auf eine beliebige Kreatur", "auf bis zu drei beliebige Kreaturen" }, { "Die Kreatur muss", "Jede Kreatur muss" }, { "ihr Attributswert", "ihr jeweiliger Attributswert" }, { "Eine Kreatur kann", "Eine betroffene Kreatur kann" } },
		},
		systemschock = {
			[2] = { { "Malus von -2", "Malus von -3" } },
			[3] = { { "Malus von -2", "Malus von -4" } },
		},
		berserkerdunst = {
			[2] = { { "10 ft.-Kegel", "20 ft.-Kegel" } },
			[3] = { { "10 ft.-Kegel", "30 ft.-Kegel" } },
		},
		egelsamen = {
			[2] = { { "pflanzt du einen Egelsamen auf einer Kreatur", "pflanzt du Egelsamen auf bis zu zwei Kreaturen" }, { "Die Kreatur muss", "Jede Kreatur muss" }, { "um die Kreatur den Rettungswurf wiederholen zu lassen, sofern sie sich innerhalb 60 ft. von dir befindet.", "um alle betroffenen Kreaturen den Rettungswurf wiederholen zu lassen, sofern sie sich innerhalb 60 ft. von dir befinden." } },
			[3] = { { "pflanzt du einen Egelsamen auf einer Kreatur", "pflanzt du Egelsamen auf bis zu drei Kreaturen" }, { "Die Kreatur muss", "Jede Kreatur muss" }, { "um die Kreatur den Rettungswurf wiederholen zu lassen, sofern sie sich innerhalb 60 ft. von dir befindet.", "um alle betroffenen Kreaturen den Rettungswurf wiederholen zu lassen, sofern sie sich innerhalb 60 ft. von dir befinden." } },
		},
		hehrgas = {
			[2] = { { "-1W4 Schaden", "-2W4 Schaden" } },
			[3] = { { "-1W4 Schaden", "-3W4 Schaden" } },
		},
		schlitterseife = {
			[2] = { { "Die Seife bleibt für 1 Minute bestehen.", "Die Seife bleibt für 1 Minute bestehen. Eine schlitternde Kreatur erhält den Zustand Liegend." } },
			[3] = { { "Die Seife bleibt für 1 Minute bestehen.", "Die Seife bleibt für 1 Minute bestehen. Eine schlitternde Kreatur erhält den Zustand Liegend und ihre Bewegungsrate wird für den Rest ihres Zuges auf 0 gesetzt." } },
		},
		buschdaempfe = {
			[2] = { { "Seitenlänge von 10 ft.", "Seitenlänge von 20 ft." } },
			[3] = { { "Seitenlänge von 10 ft.", "Seitenlänge von 30 ft." } },
		},
		teufelssaeuseln = {
			[2] = { { "Der Effekt dauert 1 Runde an.", "Der Effekt dauert 3 Runden an." } },
			[3] = { { "Der Effekt dauert 1 Runde an.", "Der Effekt dauert 1 Minute an." } },
		},
		grabesluft = {
			[2] = { { "20 ft.-Kegel", "30 ft.-Kegel" } },
			[3] = { { "20 ft.-Kegel", "40 ft.-Kegel" } },
		},
	};

	for _, tReplacement in ipairs((tReplacements[sItemKey] or {})[nLevel] or {}) do
		sBlock = BetterToolsAlchemyManager.replacePlain(sBlock, tReplacement[1], tReplacement[2]);
	end
	return BetterToolsAlchemyManager.addSaveDCToItemText(sBlock);
end

function getCraftedItemDescriptionFromToolText(sItemKey, nLevel)
	local tItem = _tItems[sItemKey];
	if not tItem then
		return "";
	end

	local sToolText = BetterToolsAlchemyManager.getToolText();
	local sIntroHeading = "<h>Alchemistische Gegenstände</h>";
	local _, nIntroHeadingEnd = string.find(sToolText, sIntroHeading, 1, true);
	local sItemHeading = "<h>" .. tItem.label .. "</h>";
	local nItemStart = string.find(sToolText, sItemHeading, nIntroHeadingEnd or 1, true);
	if not nItemStart then
		return "";
	end

	local sNextItemKey = nil;
	for nIndex, sKey in ipairs(_tItemOrder) do
		if sKey == sItemKey then
			sNextItemKey = _tItemOrder[nIndex + 1];
			break;
		end
	end

	local nItemEnd = nil;
	if sNextItemKey and _tItems[sNextItemKey] then
		local nNextItemStart = string.find(sToolText, "<h>" .. _tItems[sNextItemKey].label .. "</h>", nItemStart + string.len(sItemHeading), true);
		if nNextItemStart then
			nItemEnd = nNextItemStart - 1;
		end
	end
	if not nItemEnd then
		local nFormattedTextEnd = string.find(sToolText, "</formattedtext>", nItemStart, true);
		if nFormattedTextEnd then
			nItemEnd = nFormattedTextEnd - 1;
		end
	end
	if not nItemEnd then
		return "";
	end

	local sBlock = BetterToolsAlchemyManager.applyCraftedItemLevel(sItemKey, nLevel, string.sub(sToolText, nItemStart, nItemEnd));
	return "<formattedtext>\n" .. sBlock .. "\n</formattedtext>";
end

function getCraftedItemDescription(sItemKey, nLevel)
	local sToolDescription = BetterToolsAlchemyManager.getCraftedItemDescriptionFromToolText(sItemKey, nLevel);
	if sToolDescription ~= "" then
		return sToolDescription;
	end

	local tDescriptions = {
		antiarkanum = [[<h>Anti-Arkanum</h>
<p><i>Benötigt Aberration-Materialien</i></p>
<p>Als Bonusaktion kannst du das Anti-Arkanum benutzen, um eine Kreatur innerhalb 30 ft. von dir sofort einen Konzentrationswurf für einen Zauber oder Effekt ablegen zu lassen, auf den sie sich konzentriert.</p>
<p><b>Auf Stufe 2:</b> Die Reichweite des Anti-Arkanums steigt auf 60 ft. und die Kreatur hat einen Malus von -2 auf den Konzentrationswurf.</p>
<p><b>Auf Stufe 3:</b> Die Reichweite des Anti-Arkanums steigt auf 90 ft. und die Kreatur hat einen Malus von -4 auf den Konzentrationswurf.</p>]],
		drachenbruehe = [[<h>Drachenbrühe</h>
<p><i>Benötigt Drachen-Materialien</i></p>
<p>Als Aktion kannst du die Drachenbrühe verwenden, um daraufhin eine von dir ausgehende Fläche mit Drachenatem zu füllen. Die Form der Fläche entspricht der Art des Drachen von dem du die Materialien erhalten hast, ebenso wie der dazugehörige Rettungswurf und Schadenstyp. Der Atem bleibt drei Runden bestehen und verschwindet zu Beginn deines entsprechenden Zuges. Bewegt sich eine Kreatur zum ersten Mal in einem Zug in den Atem oder startet ihren Zug in ihm, erleidet sie 2W10 Schaden des entsprechenden Typs, ohne einen Rettungswurf abgelegt zu haben.</p>
<p>Bei Monstern des Typs Drache, die keinen bestimmten Schadenstypen besitzen (bspw. Pseudodrachen oder Wyvern), verursacht die Drachenbrühe Energieschaden.</p>
<p><b>Auf Stufe 2:</b> Der Schaden steigt auf 4W6.</p>
<p><b>Auf Stufe 3:</b> Der Schaden steigt auf 6W6.</p>]],
		alchemistenfeuer = [[<h>Alchemistenfeuer</h>
<p><i>Benötigt Elementar-Materialien</i></p>
<p>Als Bonusaktion kannst du Alchemistenfeuer bis zu 20 ft. weit werfen. Führe einen Fernkampfangriff gegen eine Kreatur oder ein Objekt aus. Du kannst deinen Übungsbonus für diesen Angriff verwenden. Bei einem Treffer erleidet das Ziel zu Beginn jeder seiner Runden 1d8 Schaden der dem Element des Elementars entspricht von dem du das Material erhalten hast. Eine Kreatur kann diesen Schaden beenden, indem sie ihre Aktion nutzt, um einen Geschicklichkeitsrettungswurf zu machen, um die Flammen zu löschen.</p>
<p><b>Auf Stufe 2:</b> Der Schaden steigt auf 2d8.</p>
<p><b>Auf Stufe 3:</b> Der Schaden steigt auf 3d8.</p>]],
		wutpulver = [[<h>Wutpulver</h>
<p><i>Benötigt Feenwesen-Materialien</i></p>
<p>Als Aktion wirfst du das Wutpulver auf eine Kreatur innerhalb 5 ft. von dir. Sie muss einen Weisheitsrettungswurf ablegen. Bei einem Fehlschlag wird sie bezaubert und von tiefstem Zorn erfüllt. Zu Beginn jedes ihrer nächsten Züge muss eine betroffene Kreatur ihren Zug nutzen, um einem zufälligen Verbündeten möglichst viel Schaden zuzufügen. Kann keiner Kreatur Schaden zugefügt werden, tut sie in ihrem Zug nichts.</p>
<p><b>Auf Stufe 2:</b> Die Reichweite des Wutpulvers steigt auf 30 ft.</p>
<p><b>Auf Stufe 3:</b> Die Reichweite des Wutpulvers steigt auf 90 ft.</p>]],
		goetterfackel = [[<h>Götterfackel</h>
<p><i>Benötigt Himmlischer-Materialien</i></p>
<p>Als Bonusaktion kannst du diese Fackel entzünden, um kreisförmige Fläche mit einem Radius von 20 ft. für 3 Runden hell zu erleuchten. Das Licht bewegt sich mit dir und deckt sämtliche unsichtbaren Kreaturen und Objekte auf und erleuchtet selbst magische Dunkelheit. Monströsitäten, Unholde und Untote erleiden zudem Nachteil auf ihre Angriffswürfe.</p>
<p><b>Auf Stufe 2:</b> Der Radius des Fackelscheins steigt auf 30 ft.</p>
<p><b>Auf Stufe 3:</b> Der Radius des Fackelscheins steigt auf 40 ft.</p>]],
		menschlichkeit = [[<h>Menschlichkeit</h>
<p><i>Benötigt Humanoider-Materialien</i></p>
<p>Als Bonusaktion kannst du die Menschlichkeit auf eine beliebige Kreatur innerhalb 120 ft. anwenden. Wähle ein beliebiges Attribut. Die Kreatur muss den dazugehörigen Rettungswurf schaffen oder ihr Attributswert wird auf 10 gesetzt. Der Effekt dauert 1 Minute an. Eine Kreatur kann ihre Aktion verwenden, um den Rettungswurf zu wiederholen und den Effekt bei Erfolg zu beenden.</p>
<p><b>Auf Stufe 2:</b> Du kannst bis zu zwei Kreaturen auswählen.</p>
<p><b>Auf Stufe 3:</b> Du kannst bis zu drei Kreaturen auswählen.</p>]],
		systemschock = [[<h>Systemschock</h>
<p><i>Benötigt Konstrukt-Materialien</i></p>
<p>Als Bonusaktion rufst du einen Systemschock bei Kreaturen in einem von dir ausgehenden 15 ft.-Kegel hervor. Jede Kreatur muss einen Geschicklichkeitsrettungswurf schaffen oder erhält einen Malus von -2 auf ihre Rüstungsklasse. Jeder Angriff auf eine betroffene Kreatur verringert den Malus um 1.</p>
<p><b>Auf Stufe 2:</b> Der Malus beginnt bei -3.</p>
<p><b>Auf Stufe 3:</b> Der Malus beginnt bei -4.</p>]],
		berserkerdunst = [[<h>Berserkerdunst</h>
<p><i>Benötigt Monströsität-Materialien</i></p>
<p>Als Aktion verstreust du den Berserkerdunst in einem von dir ausgehenden 10 ft.-Kegel. Alle Kreaturen in diesem Bereich müssen einen Weisheitsrettungswurf ablegen. Bei einem Fehlschlag werden sie von Blutrünstigkeit erfüllt. Fügt sie einer anderen Kreatur Schaden zu, erleidet sie selbst den gleiche Menge an Schaden. Der Effekt dauert 1 Minute an. Eine Kreatur kann ihre Aktion verwenden, um den Effekt zu beenden.</p>
<p><b>Auf Stufe 2:</b> Die Dimensionen des Kegels steigen auf 20 ft.</p>
<p><b>Auf Stufe 3:</b> Die Dimensionen des Kegels steigen auf 30 ft.</p>]],
		egelsamen = [[<h>Egelsamen</h>
<p><i>Benötigt Pflanze-Materialien</i></p>
<p>Als Aktion pflanzt du einen Egelsamen auf einer Kreatur innerhalb von 60 ft. von dir. Die Kreatur muss einen Konstitutionsrettungswurf schaffen oder erleidet 1 Stufe Erschöpfung. In deinen nächsten Zügen kannst du deine Bonusaktion verwenden, um die Kreatur den Rettungswurf wiederholen zu lassen, sofern sie sich innerhalb 60 ft. von dir befindet. Mit jedem Fehlschlag erhält sie eine weitere Stufe Erschöpfung. Eine Kreatur kann auf diese Weise maximal Stufe 3 an Erschöpfung erhalten. Verwendest du deine Bonusaktion nicht hierfür, fällt der Egelsamen ab und die Kreatur muss keine weiteren Rettungswürfe ablegen.</p>
<p><b>Auf Stufe 2:</b> Du kannst bis zu zwei Kreaturen auswählen. Benutzt du in Folgezügen deine Bonusaktion dafür, müssen alle betroffenen Kreaturen den Rettungswurf wiederholen.</p>
<p><b>Auf Stufe 3:</b> Du kannst bis zu drei Kreaturen auswählen. Benutzt du in Folgezügen deine Bonusaktion dafür, müssen alle betroffenen Kreaturen den Rettungswurf wiederholen.</p>]],
		hehrgas = [[<h>Hehrgas</h>
<p><i>Benötigt Riese-Materialien</i></p>
<p>Als Bonusaktion kannst du Hehrgas bis zu 20 ft. weit werfen. Führe einen Fernkampfangriff gegen eine Kreatur aus. Du kannst deinen Übungsbonus für diesen Angriff verwenden. Bei einem Treffer wird der Kreatur tiefste Ehrfurcht eingeflößt. Greift sie dich oder einen deiner Verbündeten an, muss sie einen Weisheitsrettungswurf ablegen. Bei einem Fehlschlag trifft sie automatisch nicht. Zusätzlich fügen sämtliche ihrer Angriffe -1W4 Schaden zu.</p>
<p><b>Auf Stufe 2:</b> Der Schadensmalus steigt auf -2W4.</p>
<p><b>Auf Stufe 3:</b> Der Schadensmalus steigt auf -3W4.</p>]],
		schlitterseife = [[<h>Schlitterseife</h>
<p><i>Benötigt Schlick-Materialien</i></p>
<p>Als Aktion kannst du die Schlitterseife auf eine quadratische Fläche mit einer Seitenlänge von 30 ft. anwenden, die innerhalb 60 ft. von dir liegt. Kreaturen, die diesen Bereich betreten, müssen einen Geschicklichkeitsrettungswurf ablegen. Schlägt dieser fehl, schlittern sie in derselben Richtung über die Fläche in der sie diese betreten haben. Die dabei zurückgelegte Entfernung zählt nicht zu der Bewegungsrate der Kreatur. Eine schlitternde Kreatur kann ihre Richtung nicht ändern. Stößt sie während des Schlitterns gegen eine Wand oder eine andere Kreatur, stoppt die schlitternde Kreatur. Die Kreatur mit der sie zusammengestoßen ist, schlittert weiter, sofern sie sich auf der betroffenen Fläche befindet. Die Seife bleibt für 1 Minute bestehen.</p>
<p><b>Auf Stufe 2:</b> Eine schlitternde Kreatur erhält den Zustand Liegend.</p>
<p><b>Auf Stufe 3:</b> Eine schlitternde Kreatur erhält den Zustand Liegend und ihre Bewegungsrate wird für den Rest ihres Zuges auf 0 gesetzt.</p>]],
		buschdaempfe = [[<h>Buschdämpfe</h>
<p><i>Benötigt Tier-Materialien</i></p>
<p>Als Aktion wirfst du die Buschdämpfe auf einen Punkt innerhalb 60 ft. von dir. Von diesem Punkt ausgehend, füllen die Dämpfe einen Würfel mit einer Seitenlänge von 10 ft. Eine Kreatur verliert sämtliche Resistenzen, solange sie sich innerhalb der Kugel befindet. Die Dämpfe halten 1 Minute an an.</p>
<p><b>Auf Stufe 2:</b> Die Seitenlänge des Würfels steigt auf 20 ft.</p>
<p><b>Auf Stufe 3:</b> Die Seitenlänge des Würfels steigt auf 30 ft.</p>]],
		teufelssaeuseln = [[<h>Teufelssäuseln</h>
<p><i>Benötigt Unhold-Materialien</i></p>
<p>Als Aktion öffnest du das Teufelssäuseln. Jede Kreatur innerhalb von 30 ft. zu dir, die hören kann, erleidet 1W10 Punkte psychischen Schaden. Zusätzlich muss sie einen Charismarettungswurf schaffen oder ist bezaubert. Der Effekt Der Effekt dauert 1 Runde an.</p>
<p><b>Auf Stufe 2:</b> Der Effekt dauert 3 Runden an.</p>
<p><b>Auf Stufe 3:</b> Der Effekt dauert 1 Minute an</p>]],
		grabesluft = [[<h>Grabesluft</h>
<p><i>Benötigt Untote-Materialien</i></p>
<p>Als Bonusaktion verstreust du die Grabesluft in einem von dir ausgehenden 20 ft.-Kegel. Sämtliche Kreaturen, die sich in dem Kegel befinden, können für die nächste Minute nicht geheilt werden. Der Effekt dauert 1 Minute an. Eine betroffene Kreatur kann ihre Aktion verwenden, um einen Konstitutionsrettungswurf abzulegen. Bei Erfolg endet der Effekt für sie.</p>
<p><b>Auf Stufe 2:</b> Die Dimensionen des Kegels steigen auf 30 ft.</p>
<p><b>Auf Stufe 3:</b> Die Dimensionen des Kegels steigen auf 40 ft.</p>]],
	};

	local sFallbackBlock = BetterToolsAlchemyManager.applyCraftedItemLevel(sItemKey, nLevel, tDescriptions[sItemKey] or tDescriptions.antiarkanum);
	return string.format([[<formattedtext>
%s
</formattedtext>]], sFallbackBlock);
end

function updateMaterialDisplays(nodeRow)
	if not nodeRow then
		return;
	end
	for nPotency = 1, 3 do
		local nUnits = DB.getValue(nodeRow, "p" .. nPotency .. "units", 0);
		DB.setValue(nodeRow, "materialdisplay" .. nPotency, "string", tostring(math.floor((nUnits / MATERIAL_UNITS_PER_ITEM) + 0.5)));
	end

end

function setMaterialDisplayValue(nodeRow, nPotency, sValue)
	if not nodeRow then
		return;
	end
	nPotency = math.max(math.min(tonumber(nPotency) or 1, 3), 1);
	DB.setValue(nodeRow, "p" .. nPotency .. "units", "number", BetterToolsAlchemyManager.parseUnits(sValue));
	BetterToolsAlchemyManager.updateMaterialDisplays(nodeRow);
end

function parseUnits(sValue)
	sValue = StringManager.trim(tostring(sValue or ""));
	if sValue == "" then
		return 0;
	end

	local nUnits = 0;
	for sPart in string.gmatch(sValue, "%S+") do
		local sNumerator, sDenominator = string.match(sPart, "^(%d+)%/(%d+)$");
		if sNumerator and sDenominator then
			local nDenominator = tonumber(sDenominator) or 1;
			if nDenominator > 0 then
				nUnits = nUnits + math.floor(((tonumber(sNumerator) or 0) * 6 / nDenominator) + 0.5);
			end
		else
			nUnits = nUnits + ((tonumber(sPart) or 0) * 6);
		end
	end
	return math.max(math.floor(nUnits + 0.5), 0);
end

function formatUnits(nUnits)
	nUnits = math.max(tonumber(nUnits) or 0, 0);
	local nWhole = math.floor(nUnits / 6);
	local nRest = nUnits % 6;
	if nRest == 0 then
		return tostring(nWhole);
	end
	local tFractions = {
		[1] = "1/6", [2] = "1/3", [3] = "1/2", [4] = "2/3", [5] = "5/6",
	};
	if nWhole <= 0 then
		return tFractions[nRest] or "0";
	end
	return tostring(nWhole) .. " " .. (tFractions[nRest] or "");
end

function getToolTotal(nodeChar)
	local nodeTool = BetterToolsAlchemyManager.findToolNode(nodeChar);
	if nodeTool then
		local nTotal = DB.getValue(nodeTool, "total", nil);
		if nTotal ~= nil then
			return nTotal;
		end
	end
	return BetterToolsAlchemyManager.getIntelligenceMod(nodeChar) + BetterToolsAlchemyManager.getProficiencyBonus(nodeChar);
end

function findToolNode(nodeChar)
	for _, nodeTool in pairs(DB.getChildList(nodeChar, "toollist")) do
		if DB.getValue(nodeTool, "tooltype", "") == "alchemy" or DB.getValue(nodeTool, "name", "") == "Alchemistenausrüstung" then
			return nodeTool;
		end
	end
	return nil;
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

function getIntelligenceMod(nodeChar)
	return tonumber(DB.getValue(nodeChar, "abilities.intelligence.bonus", 0)) or 0;
end

