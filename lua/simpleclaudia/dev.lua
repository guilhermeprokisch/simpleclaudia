local M = {}

-- Store the original colorscheme function
local original_colorscheme

-- Function to reload the color scheme
local function reload_colorscheme()
	print("Attempting to reload the color scheme...")
	package.loaded["simpleclaudia"] = nil
	package.loaded["simpleclaudia.utils"] = nil
	local success, simpleclaudia = pcall(require, "simpleclaudia")
	if success then
		if type(simpleclaudia) == "table" and type(simpleclaudia.load) == "function" then
			simpleclaudia.load()
			print("SimpleClaudia: Color scheme reloaded successfully.")
		else
			print("Error: simpleclaudia.load is not a function. simpleclaudia:", vim.inspect(simpleclaudia))
		end
	else
		print("Error reloading SimpleClaudia: " .. tostring(simpleclaudia))
	end
end

-- Function to start development mode
function M.start()
	print("Starting SimpleClaudia development mode...")

	-- Store the original colorscheme
	original_colorscheme = vim.g.colors_name
	print("Original colorscheme: " .. tostring(original_colorscheme))

	-- Set up autocommands for real-time updates
	vim.cmd([[
        augroup SimpleClaudiaDev
            autocmd!
            autocmd BufWritePost */lua/simpleclaudia/*.lua lua require('simpleclaudia.dev').reload()
        augroup END
    ]])

	print("SimpleClaudia development mode started. Edit files and save to see real-time updates.")
end

-- Function to stop development mode
function M.stop()
	print("Stopping SimpleClaudia development mode...")

	-- Remove autocommands
	vim.cmd([[
        augroup SimpleClaudiaDev
            autocmd!
        augroup END
    ]])

	-- Restore original colorscheme
	if original_colorscheme then
		vim.cmd("colorscheme " .. original_colorscheme)
		print("Restored original colorscheme: " .. original_colorscheme)
	else
		print("No original colorscheme to restore.")
	end

	print("SimpleClaudia development mode stopped.")
end

-- Function to reload the colorscheme (can be called manually or by autocommand)
function M.reload()
	print("Manual reload triggered.")
	local status, err = pcall(reload_colorscheme)
	if not status then
		print("Error in reload_colorscheme: " .. tostring(err))
		print(debug.traceback())
	end
end

return M
