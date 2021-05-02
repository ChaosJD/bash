#!/bin/bash
# use sudo bash -x shellScriptName
# to log the process use ((sudo bash -x bashScriptName) 2>&1 ) | tee logFileName
# use (( source bashScriptName ) 2>&1 | tee logFileName
# use sudo -s source !!!!

# What does:
# pyhton3 setuptools:
# The setup tools are a collection of utilities for Python, with the help of which one can easily build and install Python modules.

# Variables
# important table for playing pytorch & torchvision. They must fit together.
# PyTorch v1.0 - torchvision v0.2.2
# PyTorch v1.1 - torchvision v0.3.0
# PyTorch v1.2 - torchvision v0.4.0
# PyTorch v1.3 - torchvision v0.4.2
# PyTorch v1.4 - torchvision v0.5.0
# PyTorch v1.5 - torchvision v0.6.0 
# PyTorch v1.6 - torchvision v0.7.0         PyTorch 1.6 is a production release

# PyTorch v1.0 
# PyTorch v1.1 
# PyTorch v1.2 
# PyTorch v1.3 
# PyTorch v1.4 
# PyTorch v1.5    https://nvidia.box.com/shared/static/3ibazbiwtkl181n95n9em3wtrca7tdzp.whl, torch-1.5.0-cp36-cp36m-linux_aarch64.whl
# PyTorch v1.6    https://nvidia.box.com/shared/static/9eptse6jyly1ggt9axbja2yrmj6pbarc.whl, torch-1.6.0-cp36-cp36m-linux_aarch64.whl

DOWNLOAD_LINK_TORCH_VERSION_WHEEL="https://nvidia.box.com/shared/static/9eptse6jyly1ggt9axbja2yrmj6pbarc.whl"
TORCH_VERSION_WHEEL="torch-1.6.0-cp36-cp36m-linux_aarch64.whl"
TORCHVISION_VERSION="v0.7.0"


# START timing
start=$SECONDS


# << 'MULTILINE-COMMENT'
# MULTILINE-COMMENT


# TODO
# set opsetversion from 10 to 11 in online-demo/main.py?


# pip3 installation
sudo apt-get install -y python3-pip;
sudo pip3 install --upgrade setuptools pip; # pip was not updated, problems by onnxruntime # -H  => set HOME variable to target user's home dir

#1 check the verson of OpenCv 4.X is installed -> @ end!

#2 export command
export PYTHONPATH=/usr/local/python; # before python

# DON'T install pytorch docker image  & machineLearning docker image. NO DOCKER!!!


# INSTALLATION PyTorch
cd ~;


# INSTALL pyTorch
wget $DOWNLOAD_LINK_TORCH_VERSION_WHEEL -O $TORCH_VERSION_WHEEL;
sudo apt-get install -y libopenblas-base libopenmpi-dev;
sudo pip3 install Cython;
sudo pip3 install numpy $TORCH_VERSION_WHEEL;

# INSTALL torchvision
sudo apt-get install -y libjpeg-dev zlib1g-dev;

cd ~;
git clone --branch $TORCHVISION_VERSION https://github.com/pytorch/vision torchvision;
cd torchvision;
export BUILD_VERSION=${TORCHVISION_VERSION:1};
sudo python3 setup.py install;
cd ../;


#5 Build TVM
#install llvm which is required by tvm
sudo apt-get install -y llvm;
cd ~;
git clone -b v0.6 https://github.com/apache/incubator-tvm.git;
cd incubator-tvm;
git submodule update --init;
mkdir build;

sudo cp cmake/config.cmake ./build/;
cd build;

# TODO make a Function
# edit build/config.make to change
sed 's/set(USE_CUDA OFF)/set(USE_CUDA ON)/' config.cmake > config.cmake2;

# I have to save in extra file, because you can't use the same file for input & output
sed 's/set(USE_LLVM OFF)/set(USE_LLVM ON)/' config.cmake2 > config.cmake3;
sudo rm config.cmake config.cmake2;
mv config.cmake3 config.cmake;

cmake ..;
make -j4;
cd ..;

# python setup.py passage
cd python;
sudo python3 setup.py install;
cd ..;

# topy python setup.py passage
cd topi/python;
sudo python3 setup.py install;
cd ../..;


# Install ONNX
cd ~;
sudo pip3 install onnxruntime;
sudo apt-get install -y protobuf-compiler libprotoc-dev;
sudo pip3 install onnx;


# INSTALL onnx-simplifier
cd ~;
git clone https://github.com/daquexian/onnx-simplifier;
cd onnx-simplifier;

sed '17d' setup.py > setup2.py; # remove requirement 'onnxruntime >= 1.2.0' in setup.py, as it is not actually used
mv setup2.py setup.py;

sudo pip3 install .;

# export cuda toolkit binary to path variable
export PATH=$PATH:/usr/local/cuda/bin;



# download the temporal shift module into ~ from: https://github.com/mit-han-lab/temporal-shift-module
cd ~;
git clone https://github.com/mit-han-lab/temporal-shift-module.git;




# for the usb camera
# ---> sudo apt-get install -y libcanberra-gtk-module libcanberra-gtk3-module;
#sudo -H python3 -m pip install onnxruntime;
#sudo -H python3 -m pip install onnxsim;
#sudo -H python3 -m pip install pip install onnx-simplifier;




# change main.py from the online online_demo
#cd ~/temporal-shift-module/online_demo;


#removed the line 13 for onnx
#sudo sed '13d' main.py > main2.py;
#sudo rm main.py;
#sudo mv main2.py main.py;


# add onnx after import 
#sudo sed '/import cv2/ a import onnx' main.py > main2.py;
#sudo rm main.py;
#sudo mv main2.py main.py;


# insert 
#sudo sed '/onnx_model = onnx.load_model(buffer)/ a onnx_model, _ = simplify(onnx_model)' main.py > main2.py;
#sudo rm main.py;
#sudo mv main2.py main.py;

# set tvm.relay.build to tvm.relay.build_module.build
#sudo sed '/tvm.relay.build_config(opt_level=3):/ c with tvm.relay.build_module.build_config(opt_level=3):' main.py > main2.py;
#sudo rm main.py;
#sudo mv main2.py main.py;


# add varibles to ~/.bashrc
# --> echo "export PATH=/usr/local/cuda/bin:$PATH" >> ~/.bashrc;
# --> echo "export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH" >> ~/.bashrc;
# --> source ~/.bashrc;
# echo "PLEASE REBOOT!!!


#echo "export USE_NCCL=0" >> ~/.bashrc;
#echo "export USE_DISTRIBUTED=0" >> ~/.bashrc;                          # skip setting this if you want to enable OpenMPI backend
#echo "export USE_QNNPACK=0" >> ~/.bashrc;
#echo "export USE_PYTORCH_QNNPACK=0" >> ~/.bashrc;
#echo "export TORCH_CUDA_ARCH_LIST='5.3;6.2;7.2'" >> ~/.bash.rc;


#echo "export PYTORCH_BUILD_VERSION=1.6.0" >> ~/.bashrc;               # without the leading 'v', e.g. 1.3.0 for PyTorch v1.3.0
#echo "export PYTORCH_BUILD_NUMBER=1" >> ~/.bashrc; 


echo -e "\nTEST versions:";

echo -e "\nTorch version:";
sudo  python3 -c "import torch; print(torch.__version__)";

echo -e "\nIs CUDA available?";
sudo python3 -c 'import torch; print("CUDA available: " + str(torch.cuda.is_available()))';

echo -e "\ncuDNN version:";
sudo python3 -c 'import torch; print("cuDNN version: " + str(torch.backends.cudnn.version()))';

echo -e "\nTorchvision version:";
sudo python3 -c "import torchvision; print(torchvision.__version__)";

echo -e "\nJetPack Version:";
sudo apt-cache show nvidia-jetpack;

echo -e "\ntvm version:";
sudo python3 -c "import tvm; print(tvm.__version__)";

#python3 checkOpenCV4.Version.py # checks only the with import and *.__version__eval ????
echo -e "\nOpenCv version:";
sudo  python3 -c "import cv2; print(cv2.__version__)";

# TIMING end
duration=$(( SECONDS - start ));
durationMin=$duration/60.0;
echo "Duration $durationMin";



#start the module
#cd temporal-shift-module
#cd online_demo

#eval python3 main.py

# export LD_LIBRARY_PATH=<your_python_packages_install_path>/topi-0.6.dev0-py3.6.egg/topi für online demo main.py
# sudo vim ~/.bashrc

# export PATH=/usr/local/cuda/bin:$PATH export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

# source ~/.bashrc

# failure: "ImportError: cannot import name 'bilinear_sample_nchw'
# you have 2 solutions either add topi to lib path which should be cleanest solution or copy the file incubator-tvm/build/libtvm_topi.so to the tvm directory : usr/local/lib/python3.6/dist-packages/tvm-0.6.0-py3.6-linux-aarch64.egg/tvm/
