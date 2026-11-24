rex.bind("cmd+w", "pane.close")
rex.bind("cmd+shift+w", "session.close")

rex.bind("cmd+o", "session.switch")
rex.bind("cmd+l", "session.previous")

rex.bind("cmd+n", "pane.split", { direction = "down" })
rex.bind("cmd+shift+n", "pane.split", { direction = "right" })

rex.bind("cmd+z", "pane.zoom")

rex.bind("cmd+k", "pane.send_key", { key = "ctrl+l" })

rex.bind("cmd+shift+a", "session.new")

rex.action({
	name = "session_tab_goto",
	title = "Go to Tab in Session",
	args = { index = "integer" },
	run = function(ctx, args)
		local windows = rex.session.view({}).windows
		local window = windows[args.index == -1 and #windows or args.index]
		if window then
			rex.client.queue("session.select", { session_id = ctx.session_id, window_id = window.window_id })
		end
	end,
})

for i = 1, 9 do
	rex.bind("cmd+" .. i, "session_tab_goto", { index = i })
end

for _, direction in ipairs({ "left", "right", "up", "down" }) do
	rex.bind("cmd+" .. direction, "pane.focus", { direction = direction })
end

require("cmds.td")
