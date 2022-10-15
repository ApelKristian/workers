#! /bin/bash

#call this comment on the VPS:
# wget -O - https://raw.githubusercontent.com/ApelKristian/workers/main/setup.sh | bash

#wait for all processes to finish
tail --pid=$pid -f /dev/null

#basic stuff
sudo apt-get install build-essential -y
sudo apt --fix-broken install -y && sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y
sudo apt-get install libcurl4-openssl-dev libssl-dev libxml2-dev libgit2-dev libpq-dev -y

#install R
sudo apt update -qq
sudo apt install --no-install-recommends software-properties-common dirmngr
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"

sudo apt install --no-install-recommends r-base -y

#install R packages
sudo add-apt-repository ppa:c2d4u.team/c2d4u4.0+
sudo apt install --no-install-recommends r-cran-tidyverse -y

sudo R -e 'install.packages(c("lubridate", "httr2"))'

#create directories
cd ~
mkdir -p ~/Documents/{input,output,scripts}
mkdir -p ~/Documents/scripts/data

#download user agents for workers
cd ~/Documents/scripts/data
wget https://raw.githubusercontent.com/ApelKristian/workers/master/agents.csv
cd

#download R scripts
cd ~/Documents/scripts
wget https://raw.githubusercontent.com/ApelKristian/workers/master/common_functions.R
wget https://raw.githubusercontent.com/ApelKristian/workers/master/init_setup_R.R
Rscript init_setup_R.R

