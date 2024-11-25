# -----------------------------------------------------
# FISH SHELL CONFIGURATION
# -----------------------------------------------------
# Define configuration directory
set -l CONFIG_DIR ~/.config/fish

# Starship configuration
set -gx STARSHIP_CONFIG "$HOME/starship.toml"

# Source modular configs in order
for config in $CONFIG_DIR/conf.d/*.fish
    source $config
end

# Add local bins to PATH
fish_add_path $HOME/.local/bin
fish_add_path /usr/lib/ccache/bin

# Initialize Starship prompt
starship init fish | source

set -gx ANTHROPIC_API_KEY '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'

set -gx OPENAI_API_KEY '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'
