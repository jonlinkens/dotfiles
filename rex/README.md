```sh
mkdir -p "$HOME/.config/rex/cmds" "$HOME/Library/LaunchAgents"
cp rex/init.lua "$HOME/.config/rex/init.lua"
cp rex/cmds/td.lua "$HOME/.config/rex/cmds/td.lua"
cp rex/tab-titles.lua "$HOME/.config/rex/tab-titles.lua"
cp .zshrc "$HOME/.zshrc"
cp starship.toml "$HOME/.config/starship.toml"
cp rex/com.jonlinkens.rex-tab-titles.plist "$HOME/Library/LaunchAgents/com.jonlinkens.rex-tab-titles.plist"
rex config reload
launchctl bootstrap "gui/$(id -u)" "$HOME/Library/LaunchAgents/com.jonlinkens.rex-tab-titles.plist"
```
