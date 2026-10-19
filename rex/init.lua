rex.bind("cmd+w", "pane.close")
rex.bind("cmd+shift+w", "session.close")

rex.bind("cmd+o", "session.switch")
rex.bind("cmd+l", "session.previous")

rex.bind("cmd+n", "pane.split", { direction = "down" })
rex.bind("cmd+shift+n", "pane.split", { direction = "right" })

rex.bind("cmd+z", "pane.zoom")

rex.bind("cmd+k", "pane.send_key", { key = "ctrl+l" })

rex.bind("cmd+shift+a", "session.new")

for _, direction in ipairs({ "left", "right", "up", "down" }) do
	rex.bind("cmd+" .. direction, "pane.focus", { direction = direction })
end

require("cmds.td")
