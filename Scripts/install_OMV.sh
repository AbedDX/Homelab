#!/bin/bash


# Function to display error messages
function error {
  echo -e "\e[91mError: $1\e[39m"
  exit 1
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
echo "Script execution completed."


