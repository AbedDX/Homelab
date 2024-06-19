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

# Function to install Docker
function install_docker {
  echo "Installing Docker..."
  curl -fsSL https://get.docker.com -o get-docker.sh || error "Failed to download Docker installation script."
  sudo sh get-docker.sh || error "Failed to install Docker."
  sudo usermod -aG docker $USER || error "Failed to add user to the Docker usergroup."
  echo "Docker installed successfully. Remember to logoff/reboot for the changes to take effect."
}

# Function to install Portainer
function install_portainer {
  echo "Installing Portainer..."
  # Pull the Portainer image
  sudo docker pull portainer/portainer-ce || error "Failed to pull Portainer image."
  # Run the Portainer container
  sudo docker run -d -p 9000:9000 -p 9443:9443 --name=portainer --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce \
    || error "Failed to run Portainer container."
  echo "Portainer installed successfully."
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
install_docker
install_portainer
echo "Installation complete. Remember to logoff/reboot for the changes to take effect."
