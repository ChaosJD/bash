#!/bin/bash
# use bash -x YourBashScriptNameStandsHere.sh

# pip3 installation
sudo apt-get install python3-pip
sudo -H python3 -m pip3 install --upgrade setuptools


# pytorch
# nvidias solution

cd ~;
# old link https://nvidia.box.com/shared/static/#ncgzus5o23uck9i5oth2n8n06k340l6k.whl it dependences from the jetpack that is installed
sudo wget https://nvidia.box.com/shared/static/c3d7vm4gcs9m728j6o5vjay2jdedqb55.whl -O torch-1.6.0-cp36-cp36m-linux_aarch64.whl; # setVariable ???
sudo apt-get install -y python3-pip libopenblas-base libopenmpi-dev;
sudo -H python3 -m pip install --upgrade setuptools;
sudo -H python3 -m pip install Cython;
sudo -H python3 -m pip install numpy torch-1.6.0-cp36-cp36m-linux_aarch64.whl; # see below #for version of torchvision to download & set variable? befor 1.4.0

# important table for playing pytorch & torchvision. They must fit together.
# PyTorch v1.0 - torchvision v0.2.2
# PyTorch v1.1 - torchvision v0.3.0
# PyTorch v1.2 - torchvision v0.4.0
# PyTorch v1.3 - torchvision v0.4.2
# PyTorch v1.4 - torchvision v0.5.0
# PyTorch v1.5 - torchvision v0.6.0
# PyTorch v1.6 - torchvision v0.7.0-rc2


#check pytorch installation
sudo python3 -c "import torch; print(torch.__version__)";

# tensorbaordX installation
sudo -H python3 -m pip3 install tensorboardX;
# You can optionally install crc32c to speed up.
# sudo pip install crc32c

# check tensorbaordX installation
sudo -H python3 -c "import tensorboardX; print(tensorbaordX.__version__)";

# tqdm installation
sudo -H python3 -m pip install tqdm

# check tqdm installation
sudo python3 -c "import tqdm; print(tqdm.__version__)"

# scikit-learn installation
cd ~
sudo apt install -y python3-venv
#sudo python3 -m venv sklearn-venv
#source sklearn-venv/bin/activate
sudo python3 -m pip install --upgrade numpy
sudo -H python3 -m pip install -U scikit-learn

# check skikit-learn installation
# to see which version and where scikit-learn is installed"
sudo -H python3 -m pip show scikit-learn

# to see all packages installed in the active virtualenv
sudo -Hpython3 -m pip freeze
sudo python3 -c "import sklearn; sklearn.show_versions()"
