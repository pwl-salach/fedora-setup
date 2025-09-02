local wezterm = require("wezterm")
local mux = wezterm.mux

wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)
return {
	font_rules = {
		{
			intensity = "Bold",
			italic = false,
			font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Bold" }),
		},
		{
			intensity = "Bold",
			italic = true,
			font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Bold", style = "Italic" }),
		},
		{
			intensity = "Normal",
			italic = true,
			font = wezterm.font("JetBrainsMono Nerd Font Mono", { style = "Italic" }),
		},
		{
			intensity = "Normal",
			italic = false,
			font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Regular" }),
		},
	},
	enable_tab_bar = false,
	default_prog = { "/bin/bash", "-c", "${SETUP_REPO_PATH}/tmux-start.sh" },
	window_decorations = "RESIZE",
	window_padding = { left = 0, right = 0, top = 0, bottom = 0 }, -- optional: remove padding
	term = "xterm-256color",
	color_scheme = "GruvboxDarkHard",
}
