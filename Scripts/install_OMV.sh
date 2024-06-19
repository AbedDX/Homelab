#!/bin/bash


# Function to display error messages
function error {
  echo -e "\e[91mError: $1\e[39m"
  exit 1
}

# Check log file for specific error message
function check_log_for_error {
  if grep -q "Unsupported version.  Only 11 (Bullseye) and 12 (Bookworm) are supported" "$LOG_FILE"; then
    error "Unsupported version detected in log. OpenMediaVault installation failed."
  else
    echo "OpenMediaVault installed successfully."
  fi
}

# Check network connectivity
function check_internet() {
  echo "Checking internet connection..."
  if ping -q -c 1 -W 1 google.com >/dev/null; then
    echo "Online. Proceeding with the installation."
  else
    error "No network connection. Please check your network settings."
  fi
}

# Install OpenMediaVault
function install_openmediavault() {
  echo "Installing OpenMediaVault..."
  sudo wget -O - https://github.com/OpenMediaVault-Plugin-Developers/installScript/raw/master/install | sudo bash
  
  # Check if installation failed due to unsupported version
  check_log_for_error
  
}


# Display ASCII art for Homelab
function show_ascii_Homelab() {
    echo -e "
      :::    :::  ::::::::    :::   :::   :::::::::: :::            :::     ::::::::: 
     :+:    :+: :+:    :+:  :+:+: :+:+:  :+:        :+:          :+: :+:   :+:    :+: 
    +:+    +:+ +:+    +:+ +:+ +:+:+ +:+ +:+        +:+         +:+   +:+  +:+    +:+  
   +#++:++#++ +#+    +:+ +#+  +:+  +#+ +#++:++#   +#+        +#++:++#++: +#++:++#+    
  +#+    +#+ +#+    +#+ +#+       +#+ +#+        +#+        +#+     +#+ +#+    +#+    
 #+#    #+# #+#    #+# #+#       #+# #+#        #+#        #+#     #+# #+#    #+#     
###    ###  ########  ###       ### ########## ########## ###     ### #########       
"
}


# Main script execution starts here
show_ascii_Homelab
check_internet
install_openmediavault


