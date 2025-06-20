local M = {}

function M.setup()
	local highlights =
		vim.tbl_extend("error", require("andromeda.groups.editor").get(), require("andromeda.groups.syntax").get())

	-- Apply highlights
	for group, opts in pairs(highlights) do
		vim.api.nvim_set_hl(0, group, opts)
	end
end

vim.api.nvim_create_user_command("AndromedaCompile", function()
	for name, _ in pairs(package.loaded) do
		if name:match("^andromeda.") then
			package.loaded[name] = nil
		end
	end
	M.setup()
	vim.notify("Andromeda (info): compiled cache!", vim.log.levels.INFO)
	vim.cmd.colorscheme("andromeda")
end, {})

return M
