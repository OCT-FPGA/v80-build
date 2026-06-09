#!/usr/bin/env bash

mount_filesystems() {
    sudo mkdir -p /fpga/Intel /fpga/Xilinx /fpga/tools
    sudo mount -t nfs -o nolock ops.cloudlab.umass.edu:/fpga/Intel /fpga/Intel
    sudo mount -t nfs -o nolock ops.cloudlab.umass.edu:/fpga/Xilinx /fpga/Xilinx
    sudo mount -t nfs -o nolock ops.cloudlab.umass.edu:/fpga/tools /fpga/tools
}

setup_licenseserver(){
    bash -c "echo '198.22.255.6 octlm' >> /etc/hosts"
}

install_pkg(){
    sudo apt install -y cmake pkg-config ninja-build libxml2-dev libzmq3-dev libjsoncpp-dev zlib1g-dev libsystemd-dev libinih-dev libcli11-dev linux-headers-$(uname -r)
}

REMOTEDESKTOP=$1
TOOLVERSION=$2

sudo apt update

#sudo apt install -y libxml2-dev libzmq3-dev libjsoncpp-dev xvfb

# For VRT
#sudo apt install -y doxygen texlive-latex-base texlive-latex-extra texlive-latex-recommended

#sudo apt-get install libaio-dev

#Install AMI
#sudo apt install -y /fpga/tools/v80/vitis-flow/ami/ami_2.3.0-0.0bab29e5.20251021_amd64_22.04.deb 

#Install VRT software stack
#sudo apt install -y /fpga/tools/v80/vitis-flow/vrt/amd-vrt_1.0.0_2025-11-25-03-52-43_amd64.deb

#Install QDMA driver
#cp -r /fpga/tools/v80/vitis-flow/qdma_drv/linux-kernel/ /tmp && cd /tmp/linux-kernel/ && make && make install

BASE_DIR="/fpga"
VITIS_BASE_PATH="$BASE_DIR/Xilinx/2025.1/Vitis"

mount_filesystems
setup_licenseserver
install_pkg
bash -c "echo 'source $VITIS_BASE_PATH/settings64.sh' >> /etc/profile"

if [ $REMOTEDESKTOP == "True" ] ; then
    echo "Installing remote desktop software"
    apt install -y ubuntu-gnome-desktop
    echo "Installed gnome desktop"
    systemctl set-default multi-user.target
    apt install -y tigervnc-standalone-server
    echo "Installed vnc server"
fi
