local _bInitialized = false;

local _tDefaultTools = {
	{ name = "Schmiedewerkzeug", stat = "strength", tooltype = "smithing" },
	{ name = "Malerutensilien", stat = "dexterity" },
	{ name = "Freizeitset", stat = "" },
	{ name = "Gerberwerkzeug", stat = "constitution" },
	{ name = "Handwerkerausrüstung", stat = "strength" },
	{ name = "Navigationsausrüstung", stat = "wisdom" },
	{ name = "Stoff- & Lederwerkzeug", stat = "dexterity" },
	{ name = "Juwelierutensilien", stat = "dexterity" },
	{ name = "Diebeswerkzeug", stat = "dexterity" },
	{ name = "Fälschungsutensilien", stat = "intelligence" },
	{ name = "Verkleidungsset", stat = "charisma" },
	{ name = "Kräuterkundeausrüstung", stat = "wisdom", tooltype = "herbalism" },
	{ name = "Kochutensilien", stat = "wisdom", tooltype = "cooking" },
	{ name = "Brauerausrüstung", stat = "strength", tooltype = "brewing" },
	{ name = "Alchemistenausrüstung", stat = "intelligence", tooltype = "alchemy" },
	{ name = "Heilausrüstung", stat = "wisdom" },
	{ name = "Angelausrüstung", stat = "strength" },
	{ name = "Giftmischerutensilien", stat = "intelligence" },
	{ name = "Töpferutensilien", stat = "charisma" },
	{ name = "Feinhandwerkutensilien", stat = "dexterity" },
	{ name = "Glasbläserwerkzeug", stat = "constitution" },
	{ name = "Kalligraphieutensilien", stat = "charisma" },
};

function onInit()
	self.constructDefaultTools();
	_bInitialized = true;
end

function onChildWindowCreated(w)
	if _bInitialized then
		w.setCustom(true);
	end
end

function constructDefaultTools()
	local tExisting = {};

	for _, w in pairs(getWindows()) do
		local sLabel = StringManager.trim(w.name.getValue());
		if sLabel ~= "" then
			if not tExisting[sLabel] then
				tExisting[sLabel] = { w };
			else
				table.insert(tExisting[sLabel], w);
			end
		else
			w.setCustom(true);
		end
	end

	for _, tTool in ipairs(_tDefaultTools) do
		local tMatches = tExisting[tTool.name];
		if not tMatches then
			local w = createWindow();
			if w then
				w.name.setValue(tTool.name);
				w.stat.setValue(tTool.stat);
				tMatches = { w };
			end
		end

		local bCustom = false;
		for _, wMatch in pairs(tMatches or {}) do
			if not bCustom and tTool.stat ~= "" and wMatch.stat.getValue() == "" then
				wMatch.stat.setValue(tTool.stat);
			end
			if not bCustom and (tTool.tooltype or "") ~= "" then
				wMatch.tooltype.setValue(tTool.tooltype);
			end
			wMatch.setCustom(bCustom);
			bCustom = true;
		end
	end
end
