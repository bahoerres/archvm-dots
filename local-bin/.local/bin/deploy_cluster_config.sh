#!/bin/bash
# Comprehensive configuration deployment for Proxmox cluster

# Cluster configuration
declare -A SERVERS=(
    ["pvenet"]="192.168.0.101"
    ["pveserv"]="192.168.0.102"
    ["pvetop"]="192.168.0.103"
)

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}Starting cluster configuration deployment...${NC}"

# Create temporary directory for configs
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR" || exit 1

# Function to create all configuration files
create_config_files() {
    # Create directory structure
    mkdir -p {.config/nvim,.vim/undodir}
    
    # 1. Create inputrc
    cat > .inputrc << 'EOL'
[Previous inputrc content from our discussion]
EOL

    # 2. Create bash_aliases
    cat > .bash_aliases << 'EOL'
[Previous bash_aliases content from our discussion]
EOL

    # 3. Create bashrc
    cat > .bashrc << 'EOL'
[Previous bashrc content from our discussion]
EOL

    # 4. Create nvim config
    cat > .config/nvim/init.lua << 'EOL'
[Previous init.lua content from our discussion]
EOL

    # 5. Create installation script
    cat > install.sh << 'EOL'
#!/bin/bash

# Backup existing configs
backup_dir="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$backup_dir"
for file in .bashrc .bash_aliases .inputrc .config/nvim/init.lua; do
    if [ -f "$HOME/$file" ]; then
        mkdir -p "$backup_dir/$(dirname $file)"
        cp "$HOME/$file" "$backup_dir/$file"
    fi
done

# Create necessary directories
mkdir -p ~/.config/nvim ~/.vim/undodir ~/.local/bin

# Install neovim appimage
curl -L https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -o ~/.local/bin/nvim
chmod u+x ~/.local/bin/nvim

# Deploy configurations
cp -r .inputrc .bash_aliases .bashrc "$HOME/"
cp -r .config/nvim/init.lua "$HOME/.config/nvim/"

# Update PATH if needed
grep -q "$HOME/.local/bin" ~/.bashrc || echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

# Source new configurations
source ~/.bashrc

echo "Configuration deployment complete!"
echo "Please run 'source ~/.bashrc' or restart your shell."
EOL

    chmod +x install.sh
}

# Create all configuration files
echo -e "${BLUE}Creating configuration files...${NC}"
create_config_files

# Deploy to each server
for server in "${!SERVERS[@]}"; do
    ip="${SERVERS[$server]}"
    echo -e "${BLUE}Deploying to $server ($ip)...${NC}"
    
    # Create archives of configs
    tar czf config.tar.gz .inputrc .bash_aliases .bashrc .config install.sh
    
    # Test SSH connection
    if ! ssh -q "$ip" exit; then
        echo -e "${RED}Cannot connect to $server ($ip). Skipping...${NC}"
        continue
    fi
    
    # Copy and extract configs
    scp config.tar.gz "$ip":~/
    ssh "$ip" "cd ~ && tar xzf config.tar.gz && ./install.sh && rm config.tar.gz install.sh"
    
    echo -e "${GREEN}Deployment to $server complete!${NC}"
done

# Cleanup
cd
rm -rf "$TEMP_DIR"

echo -e "${GREEN}All deployments complete!${NC}"
echo -e "${BLUE}Remember to:${NC}"
echo "1. Source the new configurations on each server: source ~/.bashrc"
echo "2. Start nvim on each server to initialize plugins"
echo "3. Check that all configurations are working as expected"

# Optional: Test connections
echo -e "${BLUE}Testing connections after deployment:${NC}"
for server in "${!SERVERS[@]}"; do
    ip="${SERVERS[$server]}"
    echo -n "Testing $server ($ip): "
    if ssh -q "$ip" "which nvim > /dev/null && echo 'Neovim installed' || echo 'Neovim missing'"; then
        echo -e "${GREEN}Success${NC}"
    else
        echo -e "${RED}Failed${NC}"
    fi
done
