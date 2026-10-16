rex.action({
	name = "td_layout",
	title = "Open project layout",
	args = { dir = "string" },
	run = function(_, args)
		local shell = "com.superlogical.terminal.shell"
		local function terminal(options)
			return rex.layout.block({ flavor = shell, options = options })
		end
		local function new_window(layout)
			local _, err = rex.session.new_window({ layout = layout, focus = false })
			if err then
				error(err, 0)
			end
		end

		local dir = args.dir
		new_window(rex.layout.horizontal(0.5, terminal({ cwd = dir }), terminal({ cwd = dir })))
		new_window(terminal({
			cwd = dir,
			shell = "none",
			command = { "zsh", "-lic", "opencode; exec zsh -l" },
		}))
		new_window(terminal({
			cwd = dir,
			shell = "none",
			command = { "zsh", "-lic", "hunk diff; exec zsh -l" },
		}))
	end,
})
