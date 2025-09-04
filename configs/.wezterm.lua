local wezterm = require("wezterm")
local mux = wezterm.mux
local config = wezterm.config_builder()
local action = wezterm.action

wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

local is_macos = wezterm.target_triple:find("darwin") ~= nil
local direction_keys = {
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(key)
	return {
		key = key,
		mods = "CTRL",
		action = wezterm.action.ActivatePaneDirection(direction_keys[key]),

		-- action = wezterm.action_callback(function(win, pane)
		-- if pane:get_users_vars().IS_NVIM == "true" then
		-- -- pass the keys through to vim/nvim
		-- win:perform_action(wezterm.action.SendKey({ key = key, mods = "CTRL" }), pane)
		-- else
		-- win:perform_action(wezterm.action.ActivatePaneDirection(direction_keys[key]), pane)
		-- end
		-- end),
	}
end

config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 }

config.keys = {
	{
		key = "-",
		mods = "LEADER",
		action = action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "\\",
		mods = "LEADER",
		action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{ key = "x", mods = "LEADER", action = action.CloseCurrentPane({ confirm = true }) },
	split_nav("h"),
	split_nav("j"),
	split_nav("k"),
	split_nav("l"),
	{
		key = "h",
		mods = "CTRL|SHIFT",
		action = action.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "l",
		mods = "CTRL|SHIFT",
		action = action.AdjustPaneSize({ "Right", 5 }),
	},
	{
		key = "j",
		mods = "CTRL|SHIFT",
		action = action.AdjustPaneSize({ "Down", 5 }),
	},
	{
		key = "k",
		mods = "CTRL|SHIFT",
		action = action.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "m",
		mods = "LEADER",
		action = action.TogglePaneZoomState,
	},
	{ key = "[", mods = "LEADER", action = action.ActivateCopyMode },
	{
		key = "c",
		mods = "LEADER",
		action = action.SpawnTab("CurrentPaneDomain"),
	},

	{
		key = "p",
		mods = "LEADER",
		action = action.ActivateTabRelative(-1),
	},
	{
		key = "n",
		mods = "LEADER",
		action = action.ActivateTabRelative(1),
	},
}

for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = action.ActivateTab(i - 1),
	})
end

config.font_rules = {
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
}
-- config.enable_tab_bar = false
-- default_prog = { "/bin/bash", "-c", "source ~/.zprofile && ${SETUP_REPO_PATH}/tmux-start.sh" },
config.window_decorations = "TITLE|RESIZE"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 } -- optional: remove padding
config.font_size = 12
config.term = "xterm-256color"
config.color_scheme = "GruvboxDarkHard"
config.colors = {
	tab_bar = {
		background = "#282828", -- tmux status bg

		active_tab = {
			bg_color = "#d65d0e", -- Gruvbox orange
			fg_color = "#fbf1c7", -- light fg
			intensity = "Bold",
		},

		inactive_tab = {
			bg_color = "#3c3836",
			fg_color = "#a89984",
		},
	},
}
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
wezterm.on("format-tab-title", function(tab)
	return "  " .. (tab.tab_index + 1) .. ": " .. tab.active_pane.title .. "  "
end)
return config
