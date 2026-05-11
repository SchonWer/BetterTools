local _tLevelPortions = { 2, 10, 20, 50, 100, 200, 300, 650 };
local _tHerbOrder = { "ruestflechte", "allwettermoos", "klingenblaetter", "vitalblueten", "zitterstiele", "raschroeschen", "kraftkaffee", "witterwurz", "stoika", "klaerrauke" };
local HARVEST_HERBS_ROLL_TYPE = "bettertools_herbalism_harvest_herbs";
local HARVEST_PORTIONS_ROLL_TYPE = "bettertools_herbalism_harvest_portions";
local _tHarvestSessions = {};

local _tHerbs = {
	ruestflechte = {
		label = "Rüstflechte",
		family = "Panzergewächse",
		effects = {
			"Der nächste erlittene nichtmagische Schaden wird um 1W6 reduziert",
			"Der nächste erlittene nichtmagische Schaden wird um 3W6 reduziert",
			"Der nächste erlittene Schaden wird um 2W6 reduziert",
			"Der nächste erlittene Schaden wird um 3W6 reduziert",
			"Der nächste erlittene Schaden wird um 4W6 reduziert",
			"Der nächste erlittene Schaden wird um 5W6 reduziert",
			"Der nächste erlittene Schaden wird um 6W6 reduziert",
			"Der nächste erlittene Schaden wird negiert",
		},
		codes = {
			{ sName = "Herbalism; DMGR: 1d6 all; Notiz: Nur nichtmagischer Schaden", sApply = "action" },
			{ sName = "Herbalism; DMGR: 3d6 all; Notiz: Nur nichtmagischer Schaden", sApply = "action" },
			{ sName = "Herbalism; DMGR: 2d6 all", sApply = "action" },
			{ sName = "Herbalism; DMGR: 3d6 all", sApply = "action" },
			{ sName = "Herbalism; DMGR: 4d6 all", sApply = "action" },
			{ sName = "Herbalism; DMGR: 5d6 all", sApply = "action" },
			{ sName = "Herbalism; DMGR: 6d6 all", sApply = "action" },
			{ sName = "Herbalism; IMMUNE: all", sApply = "action" },
		},
	},
	allwettermoos = {
		label = "Allwettermoos",
		family = "Panzergewächse",
		effects = {
			"Für die nächste Runde wird jeder erlittene nichtmagische Schaden um 1 reduziert",
			"Für die nächste Runde wird jeder erlittene nichtmagische Schaden um 3 reduziert",
			"Für die nächste Runde wird jeder erlittene Schaden um 2 reduziert",
			"Für die nächste Runde wird jeder erlittene Schaden um 3 reduziert",
			"Für die nächste Runde wird jeder erlittene Schaden um 4 reduziert",
			"Für die nächste Runde wird jeder erlittene Schaden um 5 reduziert",
			"Für die nächste Runde wird jeder erlittene Schaden um 6 reduziert",
			"Für die nächste Runde wird jeder erlittene Schaden halbiert",
		},
		codes = {
			{ sName = "Herbalism; RESIST: 1 all, !magic", nDuration = 1, sInitSource = "target" },
			{ sName = "Herbalism; RESIST: 3 all, !magic", nDuration = 1, sInitSource = "target" },
			{ sName = "Herbalism; RESIST: 2 all", nDuration = 1, sInitSource = "target" },
			{ sName = "Herbalism; RESIST: 3 all", nDuration = 1, sInitSource = "target" },
			{ sName = "Herbalism; RESIST: 4 all", nDuration = 1, sInitSource = "target" },
			{ sName = "Herbalism; RESIST: 5 all", nDuration = 1, sInitSource = "target" },
			{ sName = "Herbalism; RESIST: 6 all", nDuration = 1, sInitSource = "target" },
			{ sName = "Herbalism; RESIST: all", nDuration = 1, sInitSource = "target" },
		},
	},
	klingenblaetter = {
		label = "Klingenblätter",
		family = "Klingenblättler",
		effects = {
			"+1 auf den nächsten Angriffs- und Schadenswurf. Kann nach dem Angriffswurf eingesetzt werden.",
			"+2 auf den nächsten Angriffs- und Schadenswurf. Kann nach dem Angriffswurf eingesetzt werden.",
			"+3 auf den nächsten Angriffs- und Schadenswurf. Kann nach dem Angriffswurf eingesetzt werden.",
			"+4 auf Angriffs- und Schadenswürfe bis zu deinem nächsten Zug. Kann nach dem Angriffswurf eingesetzt werden.",
			"+5 auf Angriffs- und Schadenswürfe bis zu deinem nächsten Zug. Kann nach dem Angriffswurf eingesetzt werden.",
			"+6 auf Angriffs- und Schadenswürfe bis zu deinem nächsten Zug. Kann nach dem Angriffswurf eingesetzt werden.",
			"+7 auf Angriffs- und Schadenswürfe bis zu deinem nächsten Zug. Kann nach dem Angriffswurf eingesetzt werden.",
			"+8 auf Angriffs- und Schadenswürfe bis zu deinem nächsten Zug. Kann nach dem Angriffswurf eingesetzt werden.",
		},
		codes = {
			{ sName = "Herbalism; ATK: 1; DMG: 1", sApply = "action" },
			{ sName = "Herbalism; ATK: 2; DMG: 2", sApply = "action" },
			{ sName = "Herbalism; ATK: 3; DMG: 3", sApply = "action" },
			{ sName = "Herbalism; ATK: 4; DMG: 4", nDuration = 1, sExpiration = "endnext", sInitSource = "target" },
			{ sName = "Herbalism; ATK: 5; DMG: 5", nDuration = 1, sExpiration = "endnext", sInitSource = "target" },
			{ sName = "Herbalism; ATK: 6; DMG: 6", nDuration = 1, sExpiration = "endnext", sInitSource = "target" },
			{ sName = "Herbalism; ATK: 7; DMG: 7", nDuration = 1, sExpiration = "endnext", sInitSource = "target" },
			{ sName = "Herbalism; ATK: 8; DMG: 8", nDuration = 1, sExpiration = "endnext", sInitSource = "target" },
		},
	},
	vitalblueten = {
		label = "Vitalblüten",
		family = "Vitalblüten",
		effects = {
			"+2 auf den nächsten Attributswurf",
			"+3 auf den nächsten Attributswurf",
			"+4 auf den nächsten Attributswurf",
			"+5 auf den nächsten Attributswurf",
			"+5 auf Attributswürfe für 8h",
			"+6 auf Attributswürfe für 8h",
			"+7 auf Attributswürfe für 8h",
			"+8 auf Attributswürfe für 8h",
		},
		codes = {
			{ sName = "Herbalism; CHECK: 2", sApply = "roll" },
			{ sName = "Herbalism; CHECK: 3", sApply = "roll" },
			{ sName = "Herbalism; CHECK: 4", sApply = "roll" },
			{ sName = "Herbalism; CHECK: 5", sApply = "roll" },
			{ sName = "Herbalism; CHECK: 5", nDuration = 4800, sInitSource = "target" },
			{ sName = "Herbalism; CHECK: 6", nDuration = 4800, sInitSource = "target" },
			{ sName = "Herbalism; CHECK: 7", nDuration = 4800, sInitSource = "target" },
			{ sName = "Herbalism; CHECK: 8", nDuration = 4800, sInitSource = "target" },
		},
	},
	zitterstiele = {
		label = "Zitterstiele",
		family = "Vitalblüten",
		effects = {
			"+1 auf den nächsten Rettungswurf",
			"+1 auf Rettungswürfe für 1h",
			"+2 auf den nächsten Rettungswurf",
			"+2 auf Rettungswürfe 1h",
			"+3 auf Rettungswürfe für 1h",
			"+3 auf Rettungswürfe für 8h",
			"Vorteil auf Rettungswürfe für 1h",
			"Vorteil auf Rettungswürfe für 8h",
		},
		codes = {
			{ sName = "Herbalism; SAVE: 1", sApply = "roll" },
			{ sName = "Herbalism; SAVE: 1", nDuration = 600, sInitSource = "target" },
			{ sName = "Herbalism; SAVE: 2", sApply = "roll" },
			{ sName = "Herbalism; SAVE: 2", nDuration = 600, sInitSource = "target" },
			{ sName = "Herbalism; SAVE: 3", nDuration = 600, sInitSource = "target" },
			{ sName = "Herbalism; SAVE: 3", nDuration = 4800, sInitSource = "target" },
			{ sName = "Herbalism; ADVSAV", nDuration = 600, sInitSource = "target" },
			{ sName = "Herbalism; ADVSAV", nDuration = 4800, sInitSource = "target" },
		},
	},
	raschroeschen = {
		label = "Raschröschen",
		family = "Putschpflanzen",
		effects = {
			"+5 ft. Bewegungsrate für 1min",
			"+5 ft. Bewegungsrate für 8h",
			"+10 ft. Bewegungsrate für 8h",
			"+15 ft. Bewegungsrate für 8h",
			"Vorangehende Effekte plus deine Kletterbewegungsrate entspricht der normalen Bewegungsrate",
			"Vorangehende Effekte plus deine Schwimmbewegungsrate entspricht der normalen Bewegungsrate",
			"Vorangehende Effekte plus Immunität gegen bewegungsmindernde Effekte, solange sie die Bewegungsrate nicht auf 0 setzen",
			"Vorangehende Effekte plus deine Flugbewegungsrate entspricht der normalen Bewegungsrate",
		},
		codes = {
			{ sName = "Herbalism; Notiz: +5 ft. Bewegungsrate", nDuration = 10, sInitSource = "target" },
			{ sName = "Herbalism; Notiz: +5 ft. Bewegungsrate", nDuration = 4800, sInitSource = "target" },
			{ sName = "Herbalism; Notiz: +10 ft. Bewegungsrate", nDuration = 4800, sInitSource = "target" },
			{ sName = "Herbalism; Notiz: +15 ft. Bewegungsrate", nDuration = 4800, sInitSource = "target" },
			{ sName = "Herbalism; Notiz: +15 ft. Bewegungsrate; Klettern = Bewegungsrate", nDuration = 4800, sInitSource = "target" },
			{ sName = "Herbalism; Notiz: +15 ft. Bewegungsrate; Klettern/Schwimmen = Bewegungsrate", nDuration = 4800, sInitSource = "target" },
			{ sName = "Herbalism; Notiz: +15 ft. Bewegungsrate; Klettern/Schwimmen = Bewegungsrate; Immun gegen bewegungsmindernde Effekte", nDuration = 4800, sInitSource = "target" },
			{ sName = "Herbalism; Notiz: +15 ft. Bewegungsrate; Klettern/Schwimmen/Fliegen = Bewegungsrate; Immun gegen bewegungsmindernde Effekte", nDuration = 4800, sInitSource = "target" },
		},
	},
	kraftkaffee = {
		label = "Kraftkaffee",
		family = "Putschpflanzen",
		effects = {
			"Kreatur kann nicht eingeschläfert werden",
			"Vorangehende Effekte und du kannst bis zu 2 Trefferwürfel verwenden, um ihr Ergebnis in temp. TP zu erhalten",
			"Vorangehende Effekte und du kannst bis zu 3 Trefferwürfel verwenden, um ihr Ergebnis in temp. TP zu erhalten",
			"Vorangehende Effekte -1 Erschöpfung",
			"Vorangehende Effekte -2 Erschöpfung",
			"Vorangehende Effekte -3 Erschöpfung",
			"Vorangehende Effekte und du erhältst die Effekte einer Kurzen Rast",
			"Vorangehende Effekte plus Effekt des Wiederbeleben-Zaubers",
		},
		codes = {
			{ sName = "Herbalism; Notiz: Kreatur kann nicht eingeschläfert werden" },
			{ sName = "Herbalism; Notiz: Nicht einschläferbar; bis zu 2 Trefferwürfel als temporäre TP" },
			{ sName = "Herbalism; Notiz: Nicht einschläferbar; bis zu 3 Trefferwürfel als temporäre TP" },
			{ sName = "Herbalism; Notiz: Nicht einschläferbar; bis zu 3 Trefferwürfel als temporäre TP; -1 Erschöpfung" },
			{ sName = "Herbalism; Notiz: Nicht einschläferbar; bis zu 3 Trefferwürfel als temporäre TP; -2 Erschöpfung" },
			{ sName = "Herbalism; Notiz: Nicht einschläferbar; bis zu 3 Trefferwürfel als temporäre TP; -3 Erschöpfung" },
			{ sName = "Herbalism; Notiz: Nicht einschläferbar; bis zu 3 Trefferwürfel als temporäre TP; -3 Erschöpfung; Kurze Rast" },
			{ sName = "Herbalism; Notiz: Nicht einschläferbar; bis zu 3 Trefferwürfel als temporäre TP; -3 Erschöpfung; Kurze Rast; Wiederbeleben" },
		},
	},
	witterwurz = {
		label = "Witterwurz",
		family = "Heilkräuter",
		effects = {
			"Heilt Taub",
			"Immun gegen Taub für 1h",
			"Immun gegen Taub für 8h",
			"Vorangehende Effekte und heilt Blind",
			"Vorangehende Effekte und Immun gegen Blind für 1h",
			"Vorangehende Effekte und Immun gegen Blind für 8h",
			"Vorangehende Effekte und Immun gegen Betäubt für 1h",
			"Vorangehende Effekte und Immun gegen Betäubt für 8h",
		},
		codes = {
			{
				{ sName = "Herbalism; Entfernt: deafened", tRemoveConditions = { "deafened" }, bNoAdd = true },
			},
			{
				{ sName = "Herbalism; Entfernt: deafened", tRemoveConditions = { "deafened" }, bNoAdd = true },
				{ sName = "Herbalism; IMMUNE: deafened", nDuration = 600, sInitSource = "target" },
			},
			{
				{ sName = "Herbalism; Entfernt: deafened", tRemoveConditions = { "deafened" }, bNoAdd = true },
				{ sName = "Herbalism; IMMUNE: deafened", nDuration = 4800, sInitSource = "target" },
			},
			{
				{ sName = "Herbalism; Entfernt: deafened, blinded", tRemoveConditions = { "deafened", "blinded" }, bNoAdd = true },
				{ sName = "Herbalism; IMMUNE: deafened", nDuration = 4800, sInitSource = "target" },
			},
			{
				{ sName = "Herbalism; Entfernt: deafened, blinded", tRemoveConditions = { "deafened", "blinded" }, bNoAdd = true },
				{ sName = "Herbalism; IMMUNE: deafened", nDuration = 4800, sInitSource = "target" },
				{ sName = "Herbalism; IMMUNE: blinded", nDuration = 600, sInitSource = "target" },
			},
			{
				{ sName = "Herbalism; Entfernt: deafened, blinded", tRemoveConditions = { "deafened", "blinded" }, bNoAdd = true },
				{ sName = "Herbalism; IMMUNE: deafened, blinded", nDuration = 4800, sInitSource = "target" },
			},
			{
				{ sName = "Herbalism; Entfernt: deafened, blinded", tRemoveConditions = { "deafened", "blinded" }, bNoAdd = true },
				{ sName = "Herbalism; IMMUNE: deafened, blinded", nDuration = 4800, sInitSource = "target" },
				{ sName = "Herbalism; IMMUNE: stunned", nDuration = 600, sInitSource = "target" },
			},
			{
				{ sName = "Herbalism; Entfernt: deafened, blinded", tRemoveConditions = { "deafened", "blinded" }, bNoAdd = true },
				{ sName = "Herbalism; IMMUNE: deafened, blinded, stunned", nDuration = 4800, sInitSource = "target" },
			},
		},
	},
	stoika = {
		label = "Stoika",
		family = "Heilkräuter",
		effects = {
			"Heilt Bezaubert",
			"Immun gegen Bezaubert für 1h",
			"Immun gegen Bezaubert für 8h",
			"Vorangehende Effekte und heilt Verängstigt",
			"Vorangehende Effekte und Immun gegen Verängstigt für 1h",
			"Vorangehende Effekte und Immun gegen Verängstigt für 8h",
			"Vorangehende Effekte und Immun gegen Kampfunfähig für 1h",
			"Vorangehende Effekte und Immun gegen Kampfunfähig für 8h",
		},
		codes = {
			{
				{ sName = "Herbalism; Entfernt: charmed", tRemoveConditions = { "charmed" }, bNoAdd = true },
			},
			{
				{ sName = "Herbalism; Entfernt: charmed", tRemoveConditions = { "charmed" }, bNoAdd = true },
				{ sName = "Herbalism; IMMUNE: charmed", nDuration = 600, sInitSource = "target" },
			},
			{
				{ sName = "Herbalism; Entfernt: charmed", tRemoveConditions = { "charmed" }, bNoAdd = true },
				{ sName = "Herbalism; IMMUNE: charmed", nDuration = 4800, sInitSource = "target" },
			},
			{
				{ sName = "Herbalism; Entfernt: charmed, frightened", tRemoveConditions = { "charmed", "frightened" }, bNoAdd = true },
				{ sName = "Herbalism; IMMUNE: charmed", nDuration = 4800, sInitSource = "target" },
			},
			{
				{ sName = "Herbalism; Entfernt: charmed, frightened", tRemoveConditions = { "charmed", "frightened" }, bNoAdd = true },
				{ sName = "Herbalism; IMMUNE: charmed", nDuration = 4800, sInitSource = "target" },
				{ sName = "Herbalism; IMMUNE: frightened", nDuration = 600, sInitSource = "target" },
			},
			{
				{ sName = "Herbalism; Entfernt: charmed, frightened", tRemoveConditions = { "charmed", "frightened" }, bNoAdd = true },
				{ sName = "Herbalism; IMMUNE: charmed, frightened", nDuration = 4800, sInitSource = "target" },
			},
			{
				{ sName = "Herbalism; Entfernt: charmed, frightened", tRemoveConditions = { "charmed", "frightened" }, bNoAdd = true },
				{ sName = "Herbalism; IMMUNE: charmed, frightened", nDuration = 4800, sInitSource = "target" },
				{ sName = "Herbalism; IMMUNE: incapacitated", nDuration = 600, sInitSource = "target" },
			},
			{
				{ sName = "Herbalism; Entfernt: charmed, frightened", tRemoveConditions = { "charmed", "frightened" }, bNoAdd = true },
				{ sName = "Herbalism; IMMUNE: charmed, frightened, incapacitated", nDuration = 4800, sInitSource = "target" },
			},
		},
	},
	klaerrauke = {
		label = "Klärrauke",
		family = "Heilkräuter",
		effects = {
			"Heilt Vergiftet",
			"Immun gegen Vergiftet für 1h",
			"Immun gegen Vergiftet für 8h",
			"Vorangehende Effekte und heilt Gelähmt",
			"Vorangehende Effekte und Immun gegen Gelähmt für 1h",
			"Vorangehende Effekte und Immun gegen Gelähmt für 8h",
			"Vorangehende Effekte und Immun gegen Versteinert für 1h",
			"Vorangehende Effekte und Immun gegen Versteinert für 8h",
		},
		codes = {
			{
				{ sName = "Herbalism; Entfernt: poisoned", tRemoveConditions = { "poisoned" }, bNoAdd = true },
			},
			{
				{ sName = "Herbalism; Entfernt: poisoned", tRemoveConditions = { "poisoned" }, bNoAdd = true },
				{ sName = "Herbalism; IMMUNE: poisoned", nDuration = 600, sInitSource = "target" },
			},
			{
				{ sName = "Herbalism; Entfernt: poisoned", tRemoveConditions = { "poisoned" }, bNoAdd = true },
				{ sName = "Herbalism; IMMUNE: poisoned", nDuration = 4800, sInitSource = "target" },
			},
			{
				{ sName = "Herbalism; Entfernt: poisoned, paralyzed", tRemoveConditions = { "poisoned", "paralyzed" }, bNoAdd = true },
				{ sName = "Herbalism; IMMUNE: poisoned", nDuration = 4800, sInitSource = "target" },
			},
			{
				{ sName = "Herbalism; Entfernt: poisoned, paralyzed", tRemoveConditions = { "poisoned", "paralyzed" }, bNoAdd = true },
				{ sName = "Herbalism; IMMUNE: poisoned", nDuration = 4800, sInitSource = "target" },
				{ sName = "Herbalism; IMMUNE: paralyzed", nDuration = 600, sInitSource = "target" },
			},
			{
				{ sName = "Herbalism; Entfernt: poisoned, paralyzed", tRemoveConditions = { "poisoned", "paralyzed" }, bNoAdd = true },
				{ sName = "Herbalism; IMMUNE: poisoned, paralyzed", nDuration = 4800, sInitSource = "target" },
			},
			{
				{ sName = "Herbalism; Entfernt: poisoned, paralyzed", tRemoveConditions = { "poisoned", "paralyzed" }, bNoAdd = true },
				{ sName = "Herbalism; IMMUNE: poisoned, paralyzed", nDuration = 4800, sInitSource = "target" },
				{ sName = "Herbalism; IMMUNE: petrified", nDuration = 600, sInitSource = "target" },
			},
			{
				{ sName = "Herbalism; Entfernt: poisoned, paralyzed", tRemoveConditions = { "poisoned", "paralyzed" }, bNoAdd = true },
				{ sName = "Herbalism; IMMUNE: poisoned, paralyzed, petrified", nDuration = 4800, sInitSource = "target" },
			},
		},
	},
};

function onInit()
	ActionsManager.registerResultHandler(HARVEST_HERBS_ROLL_TYPE, BetterToolsHerbalismManager.onHarvestHerbsRoll);
	ActionsManager.registerResultHandler(HARVEST_PORTIONS_ROLL_TYPE, BetterToolsHerbalismManager.onHarvestPortionsRoll);
end

function getToolText()
	return [[<formattedtext>
<h>Kräuterkundeausrüstung</h>
<p><i>Genutztes Attribut: Weisheit</i></p>
<p>Mithilfe der Kräuterkundeausrüstung kannst du Kräuter zu einer Vielfalt an Tränken verarbeiten, die einzelnen Kreaturen mit einem Schluck Boni verleihen.</p>
<p>Kräuterkundeausrüstung enthält sechs Flakons, Scheren und Lederhandschuhe zum Sammeln von Pflanzen, Mörtel und Stößel und ein Bestimmungsbüchlein. Sie wiegt 3 Pfund und kostet 5 Gold.</p>
<h>Fertigkeiten</h>
<p>Unter anderem könnten folgende Fertigkeiten von Übung mit Kräuterkundeausrüstung profitieren:</p>
<p><b>Heilkunde.</b> Durch deine Profession kennst du dich mit allerlei Blessuren, Verletzungen, Giften und Krankheiten aus und weißt in den meisten Fällen auch, was man dagegen tun kann.</p>
<p><b>Überlebenskunst.</b> Da du dir viele deiner Zutaten selbst in der Natur besorgst, kennst du dich in der Wildnis aus und weißt sowohl an einen Ort zu gelangen wie auch unbeschadet davon zurückzukehren.</p>
<p><b>Wahrnehmung.</b> Die wenigsten Kräuter wachsen einfach am Wegesrand. Du verstehst dich darauf im Unterholz und dichter Vegetation das zu finden was du suchst und rechtzeitig zu bemerken, was dich sucht.</p>
<h>Kräuter sammeln</h>
<h>Sammeln</h>
<p>Um die Kräuter für deine Arzneien in der Wildnis zu sammeln, benötigst du mindestens 1 Stunde Zeit. Kräutersammeln zählt nicht als anstrengende Aktivität, weswegen du auch während einer Kurzen Rast Kräuter suchen und trotzdem die Effekte der Rast erhalten kannst. Nach der Stunde würfelst du 1W10 x Übungsbonus. Das Resultat zeigt dir die Kräuterarten an, die du gefunden hast.</p>
<p>Jedes Kraut besitzt einen eigene Effekttabelle. Nachdem bestimmt wurde welche Kräuter du findest, machst du einen Weisheit (Kräuterkundeausrüstung)-Wurf. Dessen Ergebnis zeigt dir an, wie viele Portionen du gefunden hast. Diese wiederum kannst du beliebig auf die gewürfelte Auswahl verteilen.</p>
<table><tr><td><b>W20</b></td><td><b>Kraut</b></td></tr><tr><td>1</td><td>Rüstflechte</td></tr><tr><td>2</td><td>Allwettermoos</td></tr><tr><td>3</td><td>Klingenblätter</td></tr><tr><td>4</td><td>Vitalblüten</td></tr><tr><td>5</td><td>Zitterstiele</td></tr><tr><td>6</td><td>Raschröschen</td></tr><tr><td>7</td><td>Kraftkaffee</td></tr><tr><td>8</td><td>Witterwurz</td></tr><tr><td>9</td><td>Stoika</td></tr><tr><td>10</td><td>Klärrauke</td></tr></table>
<h>Verarbeitung</h>
<p>Kräuter sind delikate und zarte Pflanzen. Sie verlieren ihre Effekte schnell, sobald sie gesammelt wurden und müssen von daher sofort verarbeitet werden. Die Verarbeitung der Kräuter in Tränke findet automatisch in der Zeit statt, die du für das Sammeln aufbringst und erfordert keinen Wurf.</p>
<p>Besitzt du einen Trank, der mit einem Kraut aus einer bestimmten Familie gefüllt ist und findest beim Sammeln ein anderes Kraut derselben Familie, kannst du dieses trotzdem in den bestehen Trank mischen. In diesem Falle erhältst du allerdings nur die Hälfte der gesammelten Portionen an Trankfortschritt. Hast du beispielsweise einen Vitalblüten-Trank und findest nun 10 Portionen Zitterstiele, kannst du diese trotzdem dem Vitalblüten-Trank beimischen. Der Trank erhält dadurch aber nur die Hälfte an Portionen, also 5.</p>
<h>Zwischen den Abenteuern</h>
<p>Wenn du zwischen Abenteuern Kräuter suchen möchtest, errechnet sich die Menge an Kräutern die du findest mit der folgenden Formel: <b>(Übungsbonus + Weisheitsmod.) x 3</b> pro Tag.</p>
<p>Im Gegensatz zum gewöhnlichen Kräutersammeln kannst du dir zwischen den Abenteuern aussuchen welches Kraut du an jedem Tag suchen möchtest.</p>
<h>Beispiel</h>
<p>Lilivas Gruppe reist einen Tag lang durch einen Wald. Da während der Reise nicht viel passiert, möchte Liliva 4 Stunden nutzen, um Kräuter zu sammeln.</p>
<p>Sie würfelt nun als Erstes 3W10, da sie einen Übungsbonus von +3 besitzt. Die Würfel zeigen eine 3, eine 8 und eine 10. Liliva findet also Klingenblätter, Witterwurze und Klärrauken.</p>
<p>Nun macht sie einen Weisheit (Kräuterkundeausrüstung)-Wurf mit einem Ergebnis von 13. Sie erhält also 13 Portionen, die sie beliebig auf die drei Kräuter verteilen kann. Liliva entscheidet sich dafür, 5 Klingenblätter, 2 Witterwurze und 6 Klärrauken zu erhalten.</p>
<p>Da sie gleich 4 Stunden zum Sammeln genutzt hat, wird dieser Prozess noch dreimal wiederholt.</p>
<h>Tränke</h>
<p>Die schlussendlich gesammelten Kräuter werden in Flakons gefüllt. Jeder Flakon kann nur mit einer Sorte Kraut gefüllt werden und du kannst nicht mehr als 6 Flakons gleichzeitig verwenden. Wird ein Flakon getrunken, ist er wieder leer und kann mit einem neuen Kraut gefüllt werden. Sein Inhalt kann auch jederzeit ausgeschüttet werden, wenn du ihn austauschen möchtest.</p>
<p>Jeder Trank kann aufgestuft werden, indem er mit mehr Kräutern derselben Sorte gefüllt wird. Höherstufige Effekte sind stärker, aber jede höhere Stufe benötigt mehr Portionen an Kräutern als die vorangehende.</p>
<p>Einen Trank einzunehmen oder einer anderen Kreatur einzuflößen benötigt eine Reaktion.</p>
<h>Kräuter / Effekte</h>
<p>Kräuter werden in sechs Familien eingeteilt, die wiederum verschiedene Effektbäume besitzen. Um einen Trank aufstufen zu können, muss er mit dem Kraut des jeweiligen Effektbaums verstärkt werden. Die Anzahl benötigter Kräuter ist in folgender Tabelle angegeben:</p>
<table><tr><td><b>Stufe</b></td><td><b>Benötigte Kräuterportionen</b></td></tr><tr><td>1</td><td>2</td></tr><tr><td>2</td><td>10</td></tr><tr><td>3</td><td>20</td></tr><tr><td>4</td><td>50</td></tr><tr><td>5</td><td>100</td></tr><tr><td>6</td><td>200</td></tr><tr><td>7</td><td>300</td></tr><tr><td>8</td><td>650</td></tr></table>
]] .. BetterToolsHerbalismManager.getEffectTablesText() .. [[
</formattedtext>]];
end

function getEffectTablesText()
	return [[
<h>Resistenzenbaum - Familie der Panzergewächse</h>
<table><tr><td><b>Stufe</b></td><td><b>Rüstflechte</b></td><td><b>Allwettermoos</b></td></tr>
<tr><td>1</td><td>Der nächste erlittene nichtmagische Schaden wird um 1W6 reduziert</td><td>Für die nächste Runde wird jeder erlittene nichtmagische Schaden um 1 reduziert</td></tr>
<tr><td>2</td><td>Der nächste erlittene nichtmagische Schaden wird um 3W6 reduziert</td><td>Für die nächste Runde wird jeder erlittene nichtmagische Schaden um 3 reduziert</td></tr>
<tr><td>3</td><td>Der nächste erlittene Schaden wird um 2W6 reduziert</td><td>Für die nächste Runde wird jeder erlittene Schaden um 2 reduziert</td></tr>
<tr><td>4</td><td>Der nächste erlittene Schaden wird um 3W6 reduziert</td><td>Für die nächste Runde wird jeder erlittene Schaden um 3 reduziert</td></tr>
<tr><td>5</td><td>Der nächste erlittene Schaden wird um 4W6 reduziert</td><td>Für die nächste Runde wird jeder erlittene Schaden um 4 reduziert</td></tr>
<tr><td>6</td><td>Der nächste erlittene Schaden wird um 5W6 reduziert</td><td>Für die nächste Runde wird jeder erlittene Schaden um 5 reduziert</td></tr>
<tr><td>7</td><td>Der nächste erlittene Schaden wird um 6W6 reduziert</td><td>Für die nächste Runde wird jeder erlittene Schaden um 6 reduziert</td></tr>
<tr><td>8</td><td>Der nächste erlittene Schaden wird negiert</td><td>Für die nächste Runde wird jeder erlittene Schaden halbiert</td></tr></table>
<h>Schadensbaum - Familie der Klingenblättler</h>
<table><tr><td><b>Stufe</b></td><td><b>Klingenblätter</b></td></tr>
<tr><td>1</td><td>+1 auf den nächsten Angriffs- und Schadenswurf. Kann nach dem Angriffswurf eingesetzt werden.</td></tr>
<tr><td>2</td><td>+2 auf den nächsten Angriffs- und Schadenswurf. Kann nach dem Angriffswurf eingesetzt werden.</td></tr>
<tr><td>3</td><td>+3 auf den nächsten Angriffs- und Schadenswurf. Kann nach dem Angriffswurf eingesetzt werden.</td></tr>
<tr><td>4</td><td>+4 auf Angriffs- und Schadenswürfe bis zu deinem nächsten Zug. Kann nach dem Angriffswurf eingesetzt werden.</td></tr>
<tr><td>5</td><td>+5 auf Angriffs- und Schadenswürfe bis zu deinem nächsten Zug. Kann nach dem Angriffswurf eingesetzt werden.</td></tr>
<tr><td>6</td><td>+6 auf Angriffs- und Schadenswürfe bis zu deinem nächsten Zug. Kann nach dem Angriffswurf eingesetzt werden.</td></tr>
<tr><td>7</td><td>+7 auf Angriffs- und Schadenswürfe bis zu deinem nächsten Zug. Kann nach dem Angriffswurf eingesetzt werden.</td></tr>
<tr><td>8</td><td>+8 auf Angriffs- und Schadenswürfe bis zu deinem nächsten Zug. Kann nach dem Angriffswurf eingesetzt werden.</td></tr></table>
<h>Attributsbaum - Familie der Vitalblüten</h>
<table><tr><td><b>Stufe</b></td><td><b>Vitalblüten</b></td><td><b>Zitterstiele</b></td></tr>
<tr><td>1</td><td>+2 auf den nächsten Attributswurf</td><td>+1 auf den nächsten Rettungswurf</td></tr>
<tr><td>2</td><td>+3 auf den nächsten Attributswurf</td><td>+1 auf Rettungswürfe für 1h</td></tr>
<tr><td>3</td><td>+4 auf den nächsten Attributswurf</td><td>+2 auf den nächsten Rettungswurf</td></tr>
<tr><td>4</td><td>+5 auf den nächsten Attributswurf</td><td>+2 auf Rettungswürfe 1h</td></tr>
<tr><td>5</td><td>+5 auf Attributswürfe für 8h</td><td>+3 auf Rettungswürfe für 1h</td></tr>
<tr><td>6</td><td>+6 auf Attributswürfe für 8h</td><td>+3 auf Rettungswürfe für 8h</td></tr>
<tr><td>7</td><td>+7 auf Attributswürfe für 8h</td><td>Vorteil auf Rettungswürfe für 1h</td></tr>
<tr><td>8</td><td>+8 auf Attributswürfe für 8h</td><td>Vorteil auf Rettungswürfe für 8h</td></tr></table>
<h>Energiebaum - Familie der Putschpflanzen</h>
<table><tr><td><b>Stufe</b></td><td><b>Raschröschen</b></td><td><b>Kraftkaffee</b></td></tr>
<tr><td>1</td><td>+5 ft. Bewegungsrate für 1min</td><td>Kreatur kann nicht eingeschläfert werden</td></tr>
<tr><td>2</td><td>+5 ft. Bewegungsrate für 8h</td><td>Vorangehende Effekte und du kannst bis zu 2 Trefferwürfel verwenden, um ihr Ergebnis in temp. TP zu erhalten</td></tr>
<tr><td>3</td><td>+10 ft. Bewegungsrate für 8h</td><td>Vorangehende Effekte und du kannst bis zu 3 Trefferwürfel verwenden, um ihr Ergebnis in temp. TP zu erhalten</td></tr>
<tr><td>4</td><td>+15 ft. Bewegungsrate für 8h</td><td>Vorangehende Effekte -1 Erschöpfung</td></tr>
<tr><td>5</td><td>Vorangehende Effekte plus deine Kletterbewegungsrate entspricht der normalen Bewegungsrate</td><td>Vorangehende Effekte -2 Erschöpfung</td></tr>
<tr><td>6</td><td>Vorangehende Effekte plus deine Schwimmbewegungsrate entspricht der normalen Bewegungsrate</td><td>Vorangehende Effekte -3 Erschöpfung</td></tr>
<tr><td>7</td><td>Vorangehende Effekte plus Immunität gegen bewegungsmindernde Effekte, solange sie die Bewegungsrate nicht auf 0 setzen</td><td>Vorangehende Effekte und du erhältst die Effekte einer Kurzen Rast</td></tr>
<tr><td>8</td><td>Vorangehende Effekte plus deine Flugbewegungsrate entspricht der normalen Bewegungsrate</td><td>Vorangehende Effekte plus Effekt des Wiederbeleben-Zaubers</td></tr></table>
<h>Zustandsbaum - Familie der Heilkräuter</h>
<table><tr><td><b>Stufe</b></td><td><b>Witterwurz</b></td><td><b>Stoika</b></td><td><b>Klärrauke</b></td></tr>
<tr><td>1</td><td>Heilt Taub</td><td>Heilt Bezaubert</td><td>Heilt Vergiftet</td></tr>
<tr><td>2</td><td>Immun gegen Taub für 1h</td><td>Immun gegen Bezaubert für 1h</td><td>Immun gegen Vergiftet für 1h</td></tr>
<tr><td>3</td><td>Immun gegen Taub für 8h</td><td>Immun gegen Bezaubert für 8h</td><td>Immun gegen Vergiftet für 8h</td></tr>
<tr><td>4</td><td>Vorangehende Effekte und heilt Blind</td><td>Vorangehende Effekte und heilt Verängstigt</td><td>Vorangehende Effekte und heilt Gelähmt</td></tr>
<tr><td>5</td><td>Vorangehende Effekte und Immun gegen Blind für 1h</td><td>Vorangehende Effekte und Immun gegen Verängstigt für 1h</td><td>Vorangehende Effekte und Immun gegen Gelähmt für 1h</td></tr>
<tr><td>6</td><td>Vorangehende Effekte und Immun gegen Blind für 8h</td><td>Vorangehende Effekte und Immun gegen Verängstigt für 8h</td><td>Vorangehende Effekte und Immun gegen Gelähmt für 8h</td></tr>
<tr><td>7</td><td>Vorangehende Effekte und Immun gegen Betäubt für 1h</td><td>Vorangehende Effekte und Immun gegen Kampfunfähig für 1h</td><td>Vorangehende Effekte und Immun gegen Versteinert für 1h</td></tr>
<tr><td>8</td><td>Vorangehende Effekte und Immun gegen Betäubt für 8h</td><td>Vorangehende Effekte und Immun gegen Kampfunfähig für 8h</td><td>Vorangehende Effekte und Immun gegen Versteinert für 8h</td></tr></table>
]];
end

function getHerbData(sHerb)
	return _tHerbs[sHerb or ""] or { label = "", family = "", effects = {}, codes = {} };
end

function getHerbLabel(sHerb)
	return BetterToolsHerbalismManager.getHerbData(sHerb).label or "";
end

function getHerbByRoll(nRoll)
	return _tHerbOrder[tonumber(nRoll) or 0] or "";
end

function getDieResult(tDie)
	if not tDie then
		return 0;
	end
	return tonumber(tDie.result) or tonumber(tDie.value) or 0;
end

function getLevel(nPortions)
	nPortions = tonumber(nPortions) or 0;
	local nLevel = 0;
	for i, nRequired in ipairs(_tLevelPortions) do
		if nPortions >= nRequired then
			nLevel = i;
		end
	end
	return nLevel;
end

function getNextPortionGoal(nPortions)
	local nLevel = BetterToolsHerbalismManager.getLevel(nPortions);
	return _tLevelPortions[nLevel + 1] or 0;
end

function getEffect(sHerb, nLevel)
	local tHerb = BetterToolsHerbalismManager.getHerbData(sHerb);
	return tHerb.effects[tonumber(nLevel) or 0] or "";
end

function copyCodeEffect(tCode)
	if type(tCode) == "string" then
		return { sName = tCode };
	end
	if type(tCode) ~= "table" then
		return nil;
	end

	local tEffect = {};
	for k, v in pairs(tCode) do
		if type(k) ~= "number" then
			if k == "tRemoveConditions" and type(v) == "table" then
				tEffect[k] = {};
				for _, sCondition in ipairs(v) do
					table.insert(tEffect[k], sCondition);
				end
			else
				tEffect[k] = v;
			end
		end
	end
	return tEffect;
end

function addCodeApplications(tApplications, vCode)
	if type(vCode) == "string" or (type(vCode) == "table" and (vCode.sName or vCode.tRemoveConditions)) then
		local tEffect = BetterToolsHerbalismManager.copyCodeEffect(vCode);
		if tEffect then
			table.insert(tApplications, tEffect);
		end
	elseif type(vCode) == "table" then
		for _, vSubCode in ipairs(vCode) do
			BetterToolsHerbalismManager.addCodeApplications(tApplications, vSubCode);
		end
	end
end

function getEffectApplications(sHerb, nLevel)
	local tHerb = BetterToolsHerbalismManager.getHerbData(sHerb);
	local n = tonumber(nLevel) or 0;
	local tApplications = {};
	if n <= 0 or not tHerb.codes then
		return tApplications;
	end

	BetterToolsHerbalismManager.addCodeApplications(tApplications, tHerb.codes[n]);
	return tApplications;
end

function getEffectCode(sHerb, nLevel)
	local tCodes = {};
	for _, tEffect in ipairs(BetterToolsHerbalismManager.getEffectApplications(sHerb, nLevel)) do
		if StringManager.trim(tEffect.sName or "") ~= "" then
			table.insert(tCodes, tEffect.sName);
		end
	end
	return table.concat(tCodes, " / ");
end

function isAutomatedEffectCode(sEffectCode)
	local sCode = StringManager.trim(sEffectCode or "");
	if sCode == "" then
		return false;
	end

	for _, sToken in ipairs({ "ATK:", "DMG:", "CHECK:", "SAVE:", "ADVSAV", "DMGR:", "RESIST:", "IMMUNE:", "Entfernt:" }) do
		if sCode:find(sToken, 1, true) then
			return true;
		end
	end
	return false;
end

function getActorFromToolNode(nodeHerbalism)
	local nodeChar = DB.getChild(nodeHerbalism, "...");
	return ActorManager.resolveActor(nodeChar), nodeChar;
end

function getCharacterNodeFromFlask(nodeFlask)
	if not nodeFlask then
		return nil;
	end

	local sPath = DB.getPath(nodeFlask);
	local sCharPath = sPath:match("^(.-)%.bettertools%.herbalism%.flasks%.");
	if sCharPath then
		return DB.findNode(sCharPath);
	end
	return DB.getChild(nodeFlask, ".....");
end

function getAdministrationTargets(rActor)
	local tTargets = {};
	if rActor then
		tTargets = TargetingManager.getFullTargets(rActor) or {};
		if #tTargets == 0 then
			table.insert(tTargets, rActor);
		end
	end
	return tTargets;
end

function getProficiencyBonus(rActor, nodeChar)
	local nProf = 2;
	if ActorManager5E and ActorManager5E.getAbilityBonus then
		nProf = ActorManager5E.getAbilityBonus(rActor, "prf");
	elseif nodeChar then
		nProf = DB.getValue(nodeChar, "profbonus", 2);
	end
	return math.max(tonumber(nProf) or 2, 0);
end

function getWisdomMod(nodeChar)
	return tonumber(DB.getValue(nodeChar, "abilities.wisdom.bonus", 0)) or 0;
end

function findHerbalismToolNode(nodeChar)
	if not nodeChar then
		return nil;
	end
	for _, nodeTool in ipairs(DB.getChildList(nodeChar, "toollist")) do
		if DB.getValue(nodeTool, "name", "") == "Kräuterkundeausrüstung" then
			return nodeTool;
		end
	end
	return nil;
end

function getHerbalismTotal(nodeChar)
	local nodeTool = BetterToolsHerbalismManager.findHerbalismToolNode(nodeChar);
	if nodeTool then
		return tonumber(DB.getValue(nodeTool, "total", 0)) or 0;
	end
	return BetterToolsHerbalismManager.getWisdomMod(nodeChar);
end

function performHarvest(nodeHerbalism, nHours)
	local rActor, nodeChar = BetterToolsHerbalismManager.getActorFromToolNode(nodeHerbalism);
	nHours = math.max(tonumber(nHours) or 1, 1);

	local nProf = BetterToolsHerbalismManager.getProficiencyBonus(rActor, nodeChar);
	if nProf <= 0 then
		ChatManager.SystemMessage("BetterTools: Kein Übungsbonus gefunden; Kräutersammeln abgebrochen.");
		return;
	end

	local nToolTotal = BetterToolsHerbalismManager.getHerbalismTotal(nodeChar);
	local sSession = tostring(os.time()) .. "-" .. tostring(math.random(1000000));
	_tHarvestSessions[sSession] = {
		nHours = nHours,
		nProf = nProf,
		nToolTotal = nToolTotal,
		nExpected = nHours * 2,
		nReceived = 0,
		tHours = {},
		tTotals = {},
	};

	for nHour = 1, nHours do
		_tHarvestSessions[sSession].tHours[nHour] = { nHour = nHour, nPortions = 0, tHerbs = {} };

		local tHerbDice = {};
		for _ = 1, nProf do
			table.insert(tHerbDice, "d10");
		end
		ActionsManager.performAction(nil, rActor, {
			sType = HARVEST_HERBS_ROLL_TYPE,
			sDesc = "[BetterTools] Kräuter sammeln - Stunde " .. nHour .. ": Kräuterarten",
			aDice = tHerbDice,
			nMod = 0,
			sSession = sSession,
			nHour = nHour,
		});

		ActionsManager.performAction(nil, rActor, {
			sType = HARVEST_PORTIONS_ROLL_TYPE,
			sDesc = "[BetterTools] Kräuter sammeln - Stunde " .. nHour .. ": Portionen",
			aDice = { "d20" },
			nMod = nToolTotal,
			sSession = sSession,
			nHour = nHour,
		});
	end
end

function getHarvestSession(rRoll)
	return _tHarvestSessions[rRoll.sSession or ""];
end

function onHarvestHerbsRoll(rSource, _, rRoll)
	local tSession = BetterToolsHerbalismManager.getHarvestSession(rRoll);
	if not tSession then
		return;
	end

	local nHour = tonumber(rRoll.nHour) or 1;
	local tHour = tSession.tHours[nHour] or { nHour = nHour, nPortions = 0, tHerbs = {} };
	tSession.tHours[nHour] = tHour;

	local tLines = {};
	for _, tDie in ipairs(rRoll.aDice or {}) do
		local nHerbRoll = BetterToolsHerbalismManager.getDieResult(tDie);
		local sHerb = BetterToolsHerbalismManager.getHerbByRoll(nHerbRoll);
		tHour.tHerbs[sHerb] = true;
		tSession.tTotals[sHerb] = (tSession.tTotals[sHerb] or 0) + 1;
		table.insert(tLines, nHerbRoll .. ": " .. BetterToolsHerbalismManager.getHerbLabel(sHerb));
	end

	local msg = ActionsManager.createActionMessage(rSource, rRoll);
	msg.text = msg.text .. "\rGefunden:\r" .. table.concat(tLines, "\r");
	Comm.deliverChatMessage(msg);

	BetterToolsHerbalismManager.completeHarvestRoll(rSource, rRoll.sSession);
end

function onHarvestPortionsRoll(rSource, _, rRoll)
	local tSession = BetterToolsHerbalismManager.getHarvestSession(rRoll);
	if not tSession then
		return;
	end

	local nHour = tonumber(rRoll.nHour) or 1;
	local tHour = tSession.tHours[nHour] or { nHour = nHour, nPortions = 0, tHerbs = {} };
	tSession.tHours[nHour] = tHour;

	local nD20 = BetterToolsHerbalismManager.getDieResult((rRoll.aDice or {})[1]);
	local nToolTotal = tonumber(rRoll.nMod) or tonumber(tSession.nToolTotal) or 0;
	local nPortions = math.max(nD20 + nToolTotal, 0);
	tHour.nPortions = nPortions;

	local msg = ActionsManager.createActionMessage(rSource, rRoll);
	msg.text = msg.text .. "\rPortionen: " .. nD20 .. " + " .. nToolTotal .. " = " .. nPortions;
	Comm.deliverChatMessage(msg);

	BetterToolsHerbalismManager.completeHarvestRoll(rSource, rRoll.sSession);
end

function completeHarvestRoll(rActor, sSession)
	local tSession = _tHarvestSessions[sSession or ""];
	if not tSession then
		return;
	end

	tSession.nReceived = (tSession.nReceived or 0) + 1;
	if tSession.nReceived < (tSession.nExpected or 0) then
		return;
	end

	local tHours = {};
	for nHour = 1, tSession.nHours do
		table.insert(tHours, tSession.tHours[nHour] or { nHour = nHour, nPortions = 0, tHerbs = {} });
	end
	_tHarvestSessions[sSession or ""] = nil;
	BetterToolsHerbalismManager.openHarvestResult(rActor, tHours);
end

function openHarvestResult(rActor, tHours)
	local nodeChar = ActorManager.getCreatureNode(rActor);
	local nodeHerbalism = nodeChar and DB.createChild(nodeChar, "bettertools.herbalism");
	if not nodeHerbalism then
		ChatManager.SystemMessage("BetterTools: Kräuterkundeausrüstung konnte nicht gefunden werden; Verteilfenster nicht geöffnet.");
		return;
	end

	local nodeResults = DB.createChild(nodeHerbalism, "harvestresults");
	local nodeResult = DB.createChild(nodeResults);
	if not nodeResult then
		return;
	end
	DB.setValue(nodeResult, "name", "string", "Kräuter verteilen");
	DB.setValue(nodeResult, "targetpath", "string", DB.getPath(nodeHerbalism));

	local nodeHours = DB.createChild(nodeResult, "hours");
	local nodeEntries = DB.createChild(nodeResult, "entries");
	for nHourIndex, tHour in ipairs(tHours or {}) do
		local nodeHour = DB.createChild(nodeHours);
		DB.setValue(nodeHour, "hour", "number", tHour.nHour or 0);
		DB.setValue(nodeHour, "remaining", "number", tHour.nPortions or 0);
		DB.setValue(nodeHour, "name", "string", "Stunde " .. (tHour.nHour or 0) .. " - Rest " .. (tHour.nPortions or 0));

		if nHourIndex > 1 then
			local nodeSpacer = DB.createChild(nodeEntries);
			DB.setValue(nodeSpacer, "isspacer", "number", 1);
			DB.setValue(nodeSpacer, "hour", "number", tHour.nHour or 0);
		end

		local nodeHeader = DB.createChild(nodeEntries);
		DB.setValue(nodeHeader, "isheader", "number", 1);
		DB.setValue(nodeHeader, "hour", "number", tHour.nHour or 0);
		DB.setValue(nodeHeader, "hourpath", "string", DB.getPath(nodeHour));
		DB.setValue(nodeHeader, "resultpath", "string", DB.getPath(nodeResult));
		DB.setValue(nodeHeader, "groupname", "string", "Stunde " .. (tHour.nHour or 0) .. " - Rest " .. (tHour.nPortions or 0));

		for _, sHerb in ipairs(_tHerbOrder) do
			if tHour.tHerbs and tHour.tHerbs[sHerb] then
				local nodeEntry = DB.createChild(nodeEntries);
				DB.setValue(nodeEntry, "hour", "number", tHour.nHour or 0);
				DB.setValue(nodeEntry, "hourpath", "string", DB.getPath(nodeHour));
				DB.setValue(nodeEntry, "resultpath", "string", DB.getPath(nodeResult));
				DB.setValue(nodeEntry, "herb", "string", sHerb);
				DB.setValue(nodeEntry, "herblabel", "string", BetterToolsHerbalismManager.getHerbLabel(sHerb));
				DB.setValue(nodeEntry, "remaining", "number", tHour.nPortions or 0);
				DB.setValue(nodeEntry, "groupname", "string", "Stunde " .. (tHour.nHour or 0) .. " - Rest " .. (tHour.nPortions or 0));
				DB.setValue(nodeEntry, "amount", "number", 0);
				DB.setValue(nodeEntry, "flaskno", "number", 0);
			end
		end
	end

	Interface.openWindow("bettertools_herbalism_harvest_result", nodeResult);
end

function syncHarvestEntryRemaining(nodeEntry)
	if not nodeEntry then
		return;
	end
	local nodeHour = DB.findNode(DB.getValue(nodeEntry, "hourpath", ""));
	local nRemaining = nodeHour and DB.getValue(nodeHour, "remaining", 0) or 0;
	DB.setValue(nodeEntry, "remaining", "number", nRemaining);
end

function syncHarvestResultRemaining(nodeResult, nHour, nRemaining)
	if not nodeResult then
		return;
	end
	for _, nodeEntry in ipairs(DB.getChildList(nodeResult, "entries")) do
		if DB.getValue(nodeEntry, "hour", 0) == nHour then
			DB.setValue(nodeEntry, "groupname", "string", "Stunde " .. (nHour or 0) .. " - Rest " .. nRemaining);
			if DB.getValue(nodeEntry, "isheader", 0) == 0 then
				DB.setValue(nodeEntry, "remaining", "number", nRemaining);
				if DB.getValue(nodeEntry, "amount", 0) > nRemaining then
					DB.setValue(nodeEntry, "amount", "number", nRemaining);
				end
			end
		end
	end
	for _, nodeHour in ipairs(DB.getChildList(nodeResult, "hours")) do
		if DB.getValue(nodeHour, "hour", 0) == nHour then
			DB.setValue(nodeHour, "remaining", "number", nRemaining);
			DB.setValue(nodeHour, "name", "string", "Stunde " .. (nHour or 0) .. " - Rest " .. nRemaining);
		end
	end
	if BetterToolsHerbalismManager.isHarvestResultComplete(nodeResult) then
		DB.setValue(nodeResult, "completed", "number", 1);
	elseif nRemaining <= 0 then
		BetterToolsHerbalismManager.hideCompletedHarvestHour(nodeResult, nHour);
	end
end

function deleteHarvestEntryNode(nodeEntry)
	if not nodeEntry then
		return;
	end
	local bDeleted = false;
	if DB.deleteNode then
		bDeleted = pcall(DB.deleteNode, nodeEntry);
		if not bDeleted then
			bDeleted = pcall(DB.deleteNode, DB.getPath(nodeEntry));
		end
	end
	if not bDeleted and nodeEntry.delete then
		pcall(nodeEntry.delete);
	end
end

function cleanupHarvestSpacers(nodeResult)
	if not nodeResult then
		return;
	end

	local bSawVisibleRow = false;
	local bPreviousSpacer = false;
	local tDelete = {};
	local tDeletePaths = {};
	local function addSpacerForDelete(nodeEntry)
		local sPath = DB.getPath(nodeEntry);
		if not tDeletePaths[sPath] then
			tDeletePaths[sPath] = true;
			table.insert(tDelete, nodeEntry);
		end
	end
	for _, nodeEntry in ipairs(DB.getChildList(nodeResult, "entries")) do
		local bSpacer = DB.getValue(nodeEntry, "isspacer", 0) == 1;
		if bSpacer then
			if not bSawVisibleRow or bPreviousSpacer then
				addSpacerForDelete(nodeEntry);
			end
			bPreviousSpacer = true;
		else
			bSawVisibleRow = true;
			bPreviousSpacer = false;
		end
	end
	if bPreviousSpacer then
		local tEntries = DB.getChildList(nodeResult, "entries");
		if #tEntries > 0 and DB.getValue(tEntries[#tEntries], "isspacer", 0) == 1 then
			addSpacerForDelete(tEntries[#tEntries]);
		end
	end

	for _, nodeEntry in ipairs(tDelete) do
		BetterToolsHerbalismManager.deleteHarvestEntryNode(nodeEntry);
	end
end

function hideCompletedHarvestHour(nodeResult, nHour)
	if not nodeResult then
		return;
	end

	local tDelete = {};
	for _, nodeEntry in ipairs(DB.getChildList(nodeResult, "entries")) do
		if DB.getValue(nodeEntry, "hour", 0) == nHour then
			table.insert(tDelete, nodeEntry);
		end
	end
	for _, nodeEntry in ipairs(tDelete) do
		BetterToolsHerbalismManager.deleteHarvestEntryNode(nodeEntry);
	end
	BetterToolsHerbalismManager.cleanupHarvestSpacers(nodeResult);
end

function refreshHarvestFlaskChoices(nodeResult)
	if not nodeResult then
		return;
	end
	for _, nodeEntry in ipairs(DB.getChildList(nodeResult, "entries")) do
		DB.setValue(nodeEntry, "compatibilitystamp", "number", DB.getValue(nodeEntry, "compatibilitystamp", 0) + 1);
	end
end

function isHarvestResultComplete(nodeResult)
	if not nodeResult then
		return false;
	end
	for _, nodeHour in ipairs(DB.getChildList(nodeResult, "hours")) do
		if DB.getValue(nodeHour, "remaining", 0) > 0 then
			return false;
		end
	end
	return DB.getChildCount(nodeResult, "hours") > 0;
end

function getFlaskByIndex(nodeHerbalism, nFlask)
	nFlask = math.max(tonumber(nFlask) or 1, 1);
	local nodeFlasks = DB.createChild(nodeHerbalism, "flasks");
	local tFlasks = DB.getChildList(nodeFlasks);
	for _ = #tFlasks + 1, 6 do
		table.insert(tFlasks, DB.createChild(nodeFlasks));
	end
	return tFlasks[math.min(nFlask, #tFlasks)];
end

function isFlaskCompatibleForHerb(nodeHerbalism, sHerb, nFlask)
	if not nodeHerbalism or (sHerb or "") == "" then
		return false;
	end
	nFlask = math.max(tonumber(nFlask) or 1, 1);
	if nFlask > 6 then
		return false;
	end

	local nodeFlask = BetterToolsHerbalismManager.getFlaskByIndex(nodeHerbalism, nFlask);
	if not nodeFlask then
		return false;
	end

	local sFlaskHerb = DB.getValue(nodeFlask, "herb", "");
	if sFlaskHerb == "" or sFlaskHerb == sHerb then
		return true;
	end

	local tFlaskHerb = BetterToolsHerbalismManager.getHerbData(sFlaskHerb);
	local tNewHerb = BetterToolsHerbalismManager.getHerbData(sHerb);
	return (tFlaskHerb.family or "") ~= "" and tFlaskHerb.family == tNewHerb.family;
end

function getPreferredFlaskForHerb(nodeHerbalism, sHerb)
	if not nodeHerbalism or (sHerb or "") == "" then
		return 0;
	end

	for i = 1, 6 do
		local nodeFlask = BetterToolsHerbalismManager.getFlaskByIndex(nodeHerbalism, i);
		if DB.getValue(nodeFlask, "herb", "") == sHerb then
			return i;
		end
	end
	for i = 1, 6 do
		if BetterToolsHerbalismManager.isFlaskCompatibleForHerb(nodeHerbalism, sHerb, i) then
			return i;
		end
	end
	return 0;
end

function isHarvestFlaskCompatible(nodeEntry, nFlask)
	if not nodeEntry or DB.getValue(nodeEntry, "isheader", 0) == 1 then
		return false;
	end
	nFlask = math.max(tonumber(nFlask) or 1, 1);
	if nFlask > 6 then
		return false;
	end

	local nodeResult = DB.findNode(DB.getValue(nodeEntry, "resultpath", ""));
	local nodeHerbalism = nodeResult and DB.findNode(DB.getValue(nodeResult, "targetpath", ""));
	if not nodeHerbalism then
		return false;
	end

	local sHerb = DB.getValue(nodeEntry, "herb", "");
	if sHerb == "" then
		return false;
	end

	return BetterToolsHerbalismManager.isFlaskCompatibleForHerb(nodeHerbalism, sHerb, nFlask);
end

function getPreferredHarvestFlask(nodeEntry)
	if not nodeEntry or DB.getValue(nodeEntry, "isheader", 0) == 1 then
		return 0;
	end

	local nodeResult = DB.findNode(DB.getValue(nodeEntry, "resultpath", ""));
	local nodeHerbalism = nodeResult and DB.findNode(DB.getValue(nodeResult, "targetpath", ""));
	if not nodeHerbalism then
		return 0;
	end

	local sHerb = DB.getValue(nodeEntry, "herb", "");
	if sHerb == "" then
		return 0;
	end

	return BetterToolsHerbalismManager.getPreferredFlaskForHerb(nodeHerbalism, sHerb);
end

function addPortionsToFlask(nodeHerbalism, sHerb, nAmount, nFlask)
	nAmount = math.max(tonumber(nAmount) or 0, 0);
	if not nodeHerbalism or (sHerb or "") == "" or nAmount <= 0 then
		return false, "BetterTools: Keine Portionen zum Einfüllen gefunden.", 0;
	end

	local nodeFlask = BetterToolsHerbalismManager.getFlaskByIndex(nodeHerbalism, nFlask);
	if not nodeFlask then
		return false, "BetterTools: Flakon nicht gefunden.", 0;
	end

	local sFlaskHerb = DB.getValue(nodeFlask, "herb", "");
	if sFlaskHerb ~= "" and sFlaskHerb ~= sHerb then
		local tFlaskHerb = BetterToolsHerbalismManager.getHerbData(sFlaskHerb);
		local tNewHerb = BetterToolsHerbalismManager.getHerbData(sHerb);
		if (tFlaskHerb.family or "") == "" or tFlaskHerb.family ~= tNewHerb.family then
			return false, "BetterTools: Dieser Flakon enthält ein Kraut aus einer anderen Familie.", 0;
		end
	end

	local nProgress = nAmount;
	if sFlaskHerb ~= "" and sFlaskHerb ~= sHerb then
		nProgress = math.floor(nAmount / 2);
		if nProgress <= 0 then
			return false, "BetterTools: Bei Familienmischung zählt nur die Hälfte; wähle mindestens 2 Portionen.", 0;
		end
	end

	if sFlaskHerb == "" then
		DB.setValue(nodeFlask, "herb", "string", sHerb);
		DB.setValue(nodeFlask, "herblabel", "string", BetterToolsHerbalismManager.getHerbLabel(sHerb));
	end
	DB.setValue(nodeFlask, "portions", "number", DB.getValue(nodeFlask, "portions", 0) + nProgress);

	return true, "", nProgress;
end

function allocateHarvestEntry(nodeEntry)
	if not nodeEntry then
		return;
	end

	local nodeResult = DB.findNode(DB.getValue(nodeEntry, "resultpath", ""));
	local nodeHerbalism = DB.findNode(DB.getValue(nodeResult, "targetpath", ""));
	local nodeHour = DB.findNode(DB.getValue(nodeEntry, "hourpath", ""));
	if not nodeHerbalism or not nodeHour then
		ChatManager.SystemMessage("BetterTools: Verteilziel nicht gefunden.");
		return;
	end

	local nAmount = math.max(DB.getValue(nodeEntry, "amount", 0), 0);
	local nRemaining = DB.getValue(nodeHour, "remaining", 0);
	if nAmount <= 0 then
		ChatManager.SystemMessage("BetterTools: Wähle zuerst eine Portionsmenge.");
		return;
	end
	if nAmount > nRemaining then
		ChatManager.SystemMessage("BetterTools: Diese Sammelstunde hat nur noch " .. nRemaining .. " Portionen übrig.");
		return;
	end

	local sHerb = DB.getValue(nodeEntry, "herb", "");
	local nFlask = DB.getValue(nodeEntry, "flaskno", 1);
	local bAdded, sError, nProgress = BetterToolsHerbalismManager.addPortionsToFlask(nodeHerbalism, sHerb, nAmount, nFlask);
	if not bAdded then
		ChatManager.SystemMessage(sError);
		return;
	end
	DB.setValue(nodeHour, "remaining", "number", nRemaining - nAmount);
	DB.setValue(nodeEntry, "amount", "number", 0);
	BetterToolsHerbalismManager.syncHarvestResultRemaining(nodeResult, DB.getValue(nodeEntry, "hour", 0), nRemaining - nAmount);
	BetterToolsHerbalismManager.refreshHarvestFlaskChoices(nodeResult);

	local sLine = nAmount .. " Portion(en) " .. BetterToolsHerbalismManager.getHerbLabel(sHerb) .. " in Flakon " .. nFlask;
	if nProgress ~= nAmount then
		sLine = sLine .. " (" .. nProgress .. " Fortschritt durch Familienmischung)";
	end
	ChatManager.SystemMessage("BetterTools: " .. sLine .. ".");
end

function canAddPortionsToFlaskState(tFlaskHerbs, nFlask, sHerb, nAmount)
	nFlask = math.max(tonumber(nFlask) or 1, 1);
	nAmount = math.max(tonumber(nAmount) or 0, 0);
	local sFlaskHerb = tFlaskHerbs[nFlask] or "";
	if sFlaskHerb ~= "" and sFlaskHerb ~= sHerb then
		local tFlaskHerb = BetterToolsHerbalismManager.getHerbData(sFlaskHerb);
		local tNewHerb = BetterToolsHerbalismManager.getHerbData(sHerb);
		if (tFlaskHerb.family or "") == "" or tFlaskHerb.family ~= tNewHerb.family then
			return false, "BetterTools: Flakon " .. nFlask .. " enthält ein Kraut aus einer anderen Familie.", 0;
		end
	end

	local nProgress = nAmount;
	if sFlaskHerb ~= "" and sFlaskHerb ~= sHerb then
		nProgress = math.floor(nAmount / 2);
		if nProgress <= 0 then
			return false, "BetterTools: Bei Familienmischung zählt nur die Hälfte; wähle mindestens 2 Portionen.", 0;
		end
	end
	if sFlaskHerb == "" then
		tFlaskHerbs[nFlask] = sHerb;
	end
	return true, "", nProgress;
end

function allocateHarvestHour(nodeHeader)
	if not nodeHeader then
		return;
	end
	local nodeResult = DB.findNode(DB.getValue(nodeHeader, "resultpath", ""));
	local nodeHerbalism = nodeResult and DB.findNode(DB.getValue(nodeResult, "targetpath", ""));
	local nodeHour = DB.findNode(DB.getValue(nodeHeader, "hourpath", ""));
	if not nodeResult or not nodeHerbalism or not nodeHour then
		ChatManager.SystemMessage("BetterTools: Verteilziel nicht gefunden.");
		return;
	end

	local nHour = DB.getValue(nodeHeader, "hour", 0);
	local nRemaining = DB.getValue(nodeHour, "remaining", 0);
	local nTotalAmount = 0;
	local tEntries = {};
	for _, nodeEntry in ipairs(DB.getChildList(nodeResult, "entries")) do
		if DB.getValue(nodeEntry, "isheader", 0) == 0 and DB.getValue(nodeEntry, "hour", 0) == nHour then
			local nAmount = math.max(DB.getValue(nodeEntry, "amount", 0), 0);
			if nAmount > 0 then
				nTotalAmount = nTotalAmount + nAmount;
				table.insert(tEntries, nodeEntry);
			end
		end
	end

	if #tEntries == 0 then
		ChatManager.SystemMessage("BetterTools: Für diese Stunde wurden keine Portionen eingetragen.");
		return;
	end
	if nTotalAmount > nRemaining then
		ChatManager.SystemMessage("BetterTools: Stunde " .. nHour .. " hat nur noch " .. nRemaining .. " Portionen übrig.");
		return;
	end

	local tFlaskHerbs = {};
	for i = 1, 6 do
		local nodeFlask = BetterToolsHerbalismManager.getFlaskByIndex(nodeHerbalism, i);
		tFlaskHerbs[i] = DB.getValue(nodeFlask, "herb", "");
	end

	local tPlanned = {};
	for _, nodeEntry in ipairs(tEntries) do
		local sHerb = DB.getValue(nodeEntry, "herb", "");
		local nAmount = math.max(DB.getValue(nodeEntry, "amount", 0), 0);
		local nFlask = DB.getValue(nodeEntry, "flaskno", 1);
		local bValid, sError, nProgress = BetterToolsHerbalismManager.canAddPortionsToFlaskState(tFlaskHerbs, nFlask, sHerb, nAmount);
		if not bValid then
			ChatManager.SystemMessage(sError);
			return;
		end
		table.insert(tPlanned, { nodeEntry = nodeEntry, sHerb = sHerb, nAmount = nAmount, nFlask = nFlask, nProgress = nProgress });
	end

	local tLines = { "BetterTools: Stunde " .. nHour .. " verteilt:" };
	for _, tPlan in ipairs(tPlanned) do
		local bAdded, sError, nProgress = BetterToolsHerbalismManager.addPortionsToFlask(nodeHerbalism, tPlan.sHerb, tPlan.nAmount, tPlan.nFlask);
		if not bAdded then
			ChatManager.SystemMessage(sError);
			return;
		end
		DB.setValue(tPlan.nodeEntry, "amount", "number", 0);
		local sLine = "- " .. tPlan.nAmount .. " " .. BetterToolsHerbalismManager.getHerbLabel(tPlan.sHerb) .. " -> Flakon " .. tPlan.nFlask;
		if nProgress ~= tPlan.nAmount then
			sLine = sLine .. " (" .. nProgress .. " Fortschritt)";
		end
		table.insert(tLines, sLine);
	end

	DB.setValue(nodeHour, "remaining", "number", nRemaining - nTotalAmount);
	BetterToolsHerbalismManager.syncHarvestResultRemaining(nodeResult, nHour, nRemaining - nTotalAmount);
	BetterToolsHerbalismManager.refreshHarvestFlaskChoices(nodeResult);
	ChatManager.SystemMessage(table.concat(tLines, "\r"));
end

function openHerbPicker(nodeTarget, sField)
	if not nodeTarget then
		return;
	end

	local nodePicker = DB.createChild(nodeTarget, "herbpicker");
	if not nodePicker then
		return;
	end
	DB.setValue(nodePicker, "name", "string", "Kraut auswählen");
	DB.setValue(nodePicker, "targetpath", "string", DB.getPath(nodeTarget));
	DB.setValue(nodePicker, "targetfield", "string", sField or "herb");
	Interface.openWindow("bettertools_herbalism_herb_picker", nodePicker);
end

function chooseHerb(nodePicker, sHerb)
	if not nodePicker then
		return;
	end
	local nodeTarget = DB.findNode(DB.getValue(nodePicker, "targetpath", ""));
	if not nodeTarget then
		return;
	end
	local sField = DB.getValue(nodePicker, "targetfield", "herb");
	DB.setValue(nodeTarget, sField, "string", sHerb or "");
	DB.setValue(nodeTarget, sField .. "label", "string", BetterToolsHerbalismManager.getHerbLabel(sHerb));
end

function performDowntime(nodeHerbalism, sHerb, nDays, nFlask)
	local rActor, nodeChar = BetterToolsHerbalismManager.getActorFromToolNode(nodeHerbalism);
	sHerb = sHerb or "";
	if sHerb == "" then
		ChatManager.SystemMessage("BetterTools: Wähle ein Kraut für die Downtime-Suche.");
		return;
	end

	nDays = math.max(tonumber(nDays) or 1, 1);
	nFlask = math.max(tonumber(nFlask) or 1, 1);
	local nProf = BetterToolsHerbalismManager.getProficiencyBonus(rActor, nodeChar);
	local nWisMod = BetterToolsHerbalismManager.getWisdomMod(nodeChar);
	local nPerDay = math.max((nProf + nWisMod) * 3, 0);
	local nTotal = nPerDay * nDays;
	local bAdded, sError, nProgress = BetterToolsHerbalismManager.addPortionsToFlask(nodeHerbalism, sHerb, nTotal, nFlask);
	if not bAdded then
		ChatManager.SystemMessage(sError);
		return;
	end

	local tLines = {
		"Kräutersuche zwischen Abenteuern:",
		BetterToolsHerbalismManager.getHerbLabel(sHerb) .. " für " .. nDays .. " Tag(e)",
		"(" .. nProf .. " Übungsbonus + " .. nWisMod .. " Weisheitsmod.) x 3 = " .. nPerDay .. " Portionen pro Tag",
		"Gesamt: " .. nTotal .. " Portionen",
		"Flakon " .. nFlask .. ": +" .. nProgress .. " Trankfortschritt",
	};
	if nProgress ~= nTotal then
		table.insert(tLines, "Familienmischung: Nur die Hälfte der Portionen zählt als Fortschritt.");
	end

	local msg = ChatManager.createBaseMessage(rActor);
	msg.text = table.concat(tLines, "\r");
	Comm.deliverChatMessage(msg);
end

function drinkFlask(nodeFlask)
	if not nodeFlask then
		return;
	end

	local sHerb = DB.getValue(nodeFlask, "herb", "");
	local nPortions = DB.getValue(nodeFlask, "portions", 0);
	local nLevel = BetterToolsHerbalismManager.getLevel(nPortions);
	if sHerb == "" or nLevel <= 0 then
		ChatManager.SystemMessage("BetterTools: Dieser Flakon enthält noch keinen fertigen Trank.");
		return;
	end

	local nodeChar = BetterToolsHerbalismManager.getCharacterNodeFromFlask(nodeFlask);
	local rActor = ActorManager.resolveActor(nodeChar);
	local tTargets = BetterToolsHerbalismManager.getAdministrationTargets(rActor);

	local sLabel = BetterToolsHerbalismManager.getHerbLabel(sHerb);
	local sEffect = BetterToolsHerbalismManager.getEffect(sHerb, nLevel);
	local sCode = BetterToolsHerbalismManager.getEffectCode(sHerb, nLevel);
	local tEffectApplications = BetterToolsHerbalismManager.getEffectApplications(sHerb, nLevel);
	local tLines = {
		"verabreicht " .. sLabel .. " Stufe " .. nLevel .. ":",
		sEffect,
	};

	if sCode ~= "" then
		if not BetterToolsHerbalismManager.isAutomatedEffectCode(sCode) then
			table.insert(tLines, "Hinweis: Dieser Eintrag ist eine Notiz und muss manuell abgehandelt werden.");
		end
	end

	local nApplied = 0;
	local nRemoved = 0;
	for _, rTarget in ipairs(tTargets) do
		for _, tEffect in ipairs(tEffectApplications) do
			for _, sCondition in ipairs(tEffect.tRemoveConditions or {}) do
				EffectManager.removeEffect(rTarget, sCondition);
				nRemoved = nRemoved + 1;
			end
			if StringManager.trim(tEffect.sName or "") ~= "" and not tEffect.bNoAdd then
				EffectManager.addEffectByTable(rTarget, {
					sName = tEffect.sName,
					sSource = ActorManager.getCTNodeName(rActor),
					nDuration = tEffect.nDuration,
					sExpiration = tEffect.sExpiration,
					sApply = tEffect.sApply,
					sInitSource = tEffect.sInitSource,
				});
				nApplied = nApplied + 1;
			end
		end
	end
	if nApplied > 0 then
		if BetterToolsHerbalismManager.isAutomatedEffectCode(sCode) then
			table.insert(tLines, "Angewendete automatisierbare Effekte: " .. nApplied .. ".");
		else
			table.insert(tLines, "Angewendete Notizen: " .. nApplied .. ".");
		end
	elseif nRemoved <= 0 then
		table.insert(tLines, "Kein FG-Code angewendet; Effekt bitte manuell abhandeln.");
	end
	if nRemoved > 0 then
		table.insert(tLines, "Entfernte Zustände: " .. nRemoved .. ".");
	end

	DB.setValue(nodeFlask, "herb", "string", "");
	DB.setValue(nodeFlask, "portions", "number", 0);
	DB.setValue(nodeFlask, "level", "number", 0);
	DB.setValue(nodeFlask, "effecttext", "string", "");
	DB.setValue(nodeFlask, "effectcode", "string", "");

	local msg = ChatManager.createBaseMessage(rActor);
	msg.text = table.concat(tLines, "\r");
	Comm.deliverChatMessage(msg);
end
