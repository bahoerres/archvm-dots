#!/bin/bash
# Generate and distribute SSH keys across your network

# Step 1: Generate key if it doesn't exist
if [ ! -f ~/.ssh/id_ed25519 ]; then
    echo "Generating new SSH key..."
    ssh-keygen -t ed25519 -C "$(whoami)@$(hostname)"
fi

# Define your network topology
declare -A SERVERS=(
    ["pvenet"]="192.168.0.101"
    ["pveserv"]="192.168.0.102"
    ["pvetop"]="192.168.0.103"
)

WORKSTATIONS=(
    "192.168.0.63"  # Desktop
    "192.168.0.13"  # Laptop wired
    "192.168.20.13" # Laptop wifi
)

# Create authorized_keys if it doesn't exist
mkdir -p ~/.ssh
touch ~/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys

# Function to copy key to a remote host
copy_key() {
    local host=$1
    local name=$2
    echo "Attempting to copy key to $name ($host)..."
    
    # Try to copy the key
    if ssh-copy-id -i ~/.ssh/id_ed25519.pub "$host" 2>/dev/null; then
        echo "Successfully copied key to $host"
        return 0
    else
        echo "Could not automatically copy key to $host"
        echo "You may need to manually copy this key:"
        cat ~/.ssh/id_ed25519.pub
        return 1
    fi
}

# Deploy keys
echo "Starting key distribution..."
for server in "${!SERVERS[@]}"; do
    copy_key "${SERVERS[$server]}" "$server"
done

for workstation in "${WORKSTATIONS[@]}"; do
    copy_key "$workstation" "workstation-$workstation"
done

echo "Key setup complete!"
echo "If any hosts were unreachable, run this script again when they're available"

# Optional: create ~/.ssh/config for easier access
cat > ~/.ssh/config << EOL
# Proxmox Cluster
Host pvenet
    HostName 192.168.0.101
    User $(whoami)
    IdentityFile ~/.ssh/id_ed25519

Host pveserv
    HostName 192.168.0.102
    User $(whoami)
    IdentityFile ~/.ssh/id_ed25519

Host pvetop
    HostName 192.168.0.103
    User $(whoami)
    IdentityFile ~/.ssh/id_ed25519

# Workstations
Host desktop
    HostName 192.168.0.63
    User $(whoami)
    IdentityFile ~/.ssh/id_ed25519

Host laptop-wired
    HostName 192.168.0.13
    User $(whoami)
    IdentityFile ~/.ssh/id_ed25519

Host laptop-wifi
    HostName 192.168.20.13
    User $(whoami)
    IdentityFile ~/.ssh/id_ed25519
EOL

chmod 600 ~/.ssh/config
