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
	DB.setValue(nodeCooking, "text", "formattedtext", self.getCookingToolText());
	Interface.openWindow("bettertools_cooking", nodeCooking);
end

function openBrewingToolWindow()
	local nodeTool = getDatabaseNode();
	local nodeChar = DB.getChild(nodeTool, "...");
	local nodeBrewing = DB.createChild(nodeChar, "bettertools.brewing");
	DB.setValue(nodeBrewing, "name", "string", "Brauerausrüstung");
	DB.setValue(nodeBrewing, "text", "formattedtext", self.getBrewingToolText());
	Interface.openWindow("bettertools_brewing", nodeBrewing);
end

function encodeXML(s)
	if UtilityManager and UtilityManager.encodeXML then
		return UtilityManager.encodeXML(s or "");
	end
	return (s or ""):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub("\"", "&quot;");
end

function getCookingEffectTableLinks()
	local tRarities = { "common", "rare", "veryrare" };
	local tLines = {
		"<h>Effekttabellen</h>",
	};

	if BetterToolsCookingManager and BetterToolsCookingManager.ensureEffectTables then
		BetterToolsCookingManager.ensureEffectTables();
	end

	local bHasAnyLink = false;
	for _, sRarity in ipairs(tRarities) do
		local sTableName = BetterToolsCookingManager.getEffectTableName(sRarity);
		local nodeTable = BetterToolsCookingManager.findEffectTable(sRarity);
		if nodeTable then
			if not bHasAnyLink then
				table.insert(tLines, "<linklist>");
				bHasAnyLink = true;
			end
			table.insert(tLines, string.format("<link class=\"table\" recordname=\"%s\">%s</link>", self.encodeXML(DB.getPath(nodeTable)), self.encodeXML(sTableName)));
		end
	end

	if bHasAnyLink then
		table.insert(tLines, "</linklist>");
	else
		table.insert(tLines, "<list>");
		for _, sRarity in ipairs(tRarities) do
			table.insert(tLines, "<li><b>Table:</b> " .. self.encodeXML(BetterToolsCookingManager.getEffectTableName(sRarity)) .. "</li>");
		end
		table.insert(tLines, "</list>");
	end

	return table.concat(tLines, "\n");
end

function getCookingToolText()
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
]] .. self.getCookingEffectTableLinks() .. [[
</formattedtext>]];
end

function getBrewingToolText()
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

function action(draginfo)
	local nodeTool = getDatabaseNode();
	local nodeChar = DB.getChild(nodeTool, "...");
	local rActor = ActorManager.resolveActor(nodeChar);
	ActionSkill.performRoll(draginfo, rActor, nodeTool);
	return true;
end

