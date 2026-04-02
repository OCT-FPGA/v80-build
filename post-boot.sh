REMOTEDESKTOP=$1
TOOLVERSION=$2

sudo apt update

sudo apt install -y libxml2-dev libzmq3-dev libjsoncpp-dev xvfb
sudo apt-get install libaio-dev

#Install AMI
sudo apt install -y /share/tools/v80/vitis-flow/ami/ami_2.3.0-0.0bab29e5.20251021_amd64_22.04.deb 

#Install VRT software stack
sudo apt install -y /share/tools/v80/vitis-flow/vrt/amd-vrt_1.0.0_2025-11-25-03-52-43_amd64.deb

#Install QDMA driver
cp -r /share/tools/v80/vitis-flow/qdma_drv/linux-kernel/ /tmp && cd /tmp/linux-kernel/ && make && make install


if [ $REMOTEDESKTOP == "True" ] ; then
    echo "Installing remote desktop software"
    apt install -y ubuntu-gnome-desktop
    echo "Installed gnome desktop"
    systemctl set-default multi-user.target
    apt install -y tigervnc-standalone-server
    echo "Installed vnc server"
fi
