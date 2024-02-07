#!/bin/bash
echo "Type 1 for Server sort, 2 for Pagination, 3 for both"
read -p 'Option: ' number

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_16.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

sudo apt update
sudo apt install -y nodejs
npm i -g yarn # Install Yarn

cd /var/www/pterodactyl
yarn # Installs panel build dependencies

if [ "$number" -eq "1" ]; then
  yarn add react-beautiful-dnd
  curl -L -f https://www.dropbox.com/scl/fi/5mdgeh0e596i6h76d6apy/DashboardContainer.tsx?rlkey=hwexoub3l63isxag31g577q71 > /var/www/pterodactyl/resources/scripts/components/dashboard/DashboardContainer.tsx
elif [ "$number" -eq "2" ]; then
  curl -L -f https://www.dropbox.com/scl/fi/1x6ma2ww4x24v0w9equ2n/FileManagerContainer.tsx?rlkey=bvk8gj7qxqietg54gggot71dc > /var/www/pterodactyl/resources/scripts/components/server/files/FileManagerContainer.tsx
elif [ "$number" -eq "3" ]; then
  curl -L -f https://www.dropbox.com/scl/fi/5mdgeh0e596i6h76d6apy/DashboardContainer.tsx?rlkey=hwexoub3l63isxag31g577q71 > /var/www/pterodactyl/resources/scripts/components/dashboard/DashboardContainer.tsx
  curl -L -f https://www.dropbox.com/scl/fi/1x6ma2ww4x24v0w9equ2n/FileManagerContainer.tsx?rlkey=bvk8gj7qxqietg54gggot71dc > /var/www/pterodactyl/resources/scripts/components/server/files/FileManagerContainer.tsx
  yarn add react-beautiful-dnd
fi

yarn build:production
