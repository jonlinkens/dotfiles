local terminal = "com.superlogical.terminal"
local environment_dots = {
	production = "🔴",
	staging = "🟠",
	dev = "🔵",
	edge = "🔵",
	infra = "🟣",
}

local function session_letter(index)
	local letters = ""
	while index > 0 do
		index = index - 1
		letters = string.char(97 + index % 26) .. letters
		index = math.floor(index / 26)
	end
	return letters
end

local function rename_sessions()
	local sessions = rex.call("session.list").sessions
	table.sort(sessions, function(a, b)
		return a.session_id < b.session_id
	end)
	for index, session in ipairs(sessions) do
		local _, attach_error = rex.session.attach({ session_id = session.session_id })
		if attach_error then
			error(attach_error)
		end
		local label = session_letter(index)
		if session.label ~= label then
			local _, rename_error = rex.session.set_label({
				session_id = session.session_id,
				label = label,
			})
			if rename_error then
				error(rename_error)
			end
		end
	end
	return sessions
end

local function update_window(session_id, window)
	local block_id = window.focused_block_id
	if not block_id then
		return
	end

	local process = rex.block.call(terminal, "process", {
		session_id = session_id,
		block_id = block_id,
	})
	local cwd = process and process.foreground and process.foreground.cwd
	if not cwd then
		local reported = rex.block.call(terminal, "pwd", {
			session_id = session_id,
			block_id = block_id,
		})
		cwd = reported and reported.pwd and reported.pwd:match("^file://[^/]*(/.*)$")
	end

	local folder = cwd and cwd:match("([^/]+)/?$")
	local program = process and process.foreground and process.foreground.name
	local label = folder and program and (program == "zsh" and folder or (folder .. " • " .. program))
	if label then
		local status = rex.block.call(terminal, "program_status", {
			session_id = session_id,
			block_id = block_id,
		})
		for _, record in ipairs(status.records) do
			local dot = record.id == "seneca-env" and environment_dots[record.title]
			if dot then
				label = dot .. " " .. label
				break
			end
		end
	end
	if label and label ~= window.label then
		rex.session.set_window_label({
			session_id = session_id,
			window_id = window.window_id,
			label = label,
		})
	end
end

local function update_session(session_id)
	local view = rex.session.view({ session_id = session_id })
	if not view then
		return
	end
	for _, window in ipairs(view.windows) do
		update_window(session_id, window)
	end
end

rex.on("session_view_changed", function(ctx)
	update_session(ctx.session_id)
end)
rex.on("terminal.pwd_changed", function(ctx)
	update_session(ctx.session_id)
end)
rex.on("terminal.process_changed", function(ctx)
	update_session(ctx.session_id)
end)
rex.on("terminal.program_status_changed", function(ctx, ev)
	if ev.id == "seneca-env" then
		update_session(ctx.session_id)
	end
end)
rex.on("terminal.program_status_removed", function(ctx, ev)
	for _, id in ipairs(ev.ids) do
		if id == "seneca-env" then
			update_session(ctx.session_id)
			break
		end
	end
end)
rex.on("session_created", function(_, ev)
	rename_sessions()
	update_session(ev.session.session_id)
end)
rex.on("session_destroyed", function()
	rename_sessions()
end)
rex.on("session_label_changed", function()
	rename_sessions()
end)

for _, session in ipairs(rename_sessions()) do
	update_session(session.session_id)
end
