swayimg.set_mode("gallery")

swayimg.gallery.on_key("h", function()
	swayimg.gallery.switch_image("left")
end)

swayimg.gallery.on_key("l", function()
	swayimg.gallery.switch_image("right")
end)

swayimg.gallery.on_key("k", function()
	swayimg.gallery.switch_image("up")
end)

swayimg.gallery.on_key("j", function()
	swayimg.gallery.switch_image("down")
end)

swayimg.gallery.on_key("Ctrl-u", function()
	swayimg.gallery.switch_image("pgup")
end)

swayimg.gallery.on_key("Ctrl-d", function()
	swayimg.gallery.switch_image("pgdown")
end)

swayimg.gallery.on_key("j", function()
	swayimg.gallery.switch_image("down")
end)

swayimg.viewer.on_key("Escape", function()
	swayimg.set_mode("gallery")
end)

swayimg.viewer.on_key("q", function()
	swayimg.set_mode("gallery")
end)

swayimg.gallery.on_key("Escape", function()
	-- swayimg.set_mode("gallery")
end)

swayimg.gallery.on_key("q", function()
	swayimg.exit()
end)

swayimg.viewer.on_mouse("ScrollUp", function()
	local pos = swayimg.get_mouse_pos()
	local scale = swayimg.viewer.get_scale()
	scale = scale + scale / 10
	swayimg.viewer.set_abs_scale(scale, pos.x, pos.y)
end)

swayimg.viewer.on_mouse("ScrollDown", function()
	local pos = swayimg.get_mouse_pos()
	local scale = swayimg.viewer.get_scale()
	scale = scale - scale / 10
	swayimg.viewer.set_abs_scale(scale, pos.x, pos.y)
end)

swayimg.viewer.on_key("i", function()
	local pos = swayimg.get_mouse_pos()
	local scale = swayimg.viewer.get_scale()
	scale = scale + scale / 10
	swayimg.viewer.set_abs_scale(scale, pos.x, pos.y)
end)

swayimg.viewer.on_key("o", function()
	local pos = swayimg.get_mouse_pos()
	local scale = swayimg.viewer.get_scale()
	scale = scale - scale / 10
	swayimg.viewer.set_abs_scale(scale, pos.x, pos.y)
end)

swayimg.viewer.on_key("h", function()
	local wnd = swayimg.get_window_size()
	local pos = swayimg.viewer.get_position()
	swayimg.viewer.set_abs_position(math.floor(pos.x + wnd.width / 10), pos.y)
end)

swayimg.viewer.on_key("l", function()
	local wnd = swayimg.get_window_size()
	local pos = swayimg.viewer.get_position()
	swayimg.viewer.set_abs_position(math.floor(pos.x - wnd.width / 10), pos.y)
end)

swayimg.viewer.on_key("k", function()
	local wnd = swayimg.get_window_size()
	local pos = swayimg.viewer.get_position()
	swayimg.viewer.set_abs_position(pos.x, math.floor(pos.y + wnd.width / 10))
end)

swayimg.viewer.on_key("j", function()
	local wnd = swayimg.get_window_size()
	local pos = swayimg.viewer.get_position()
	swayimg.viewer.set_abs_position(pos.x, math.floor(pos.y - wnd.width / 10))
end)

-- TODO delete etc
