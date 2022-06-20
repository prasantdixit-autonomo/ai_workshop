# Install dependencies
sudo apt-get update && sudo apt-get install -y curl gpg-agent software-properties-common

# Register OpenVINO toolkit APT repository
curl https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB | sudo apt-key add -
echo "deb https://apt.repos.intel.com/openvino/2022 `. /etc/os-release && echo ${UBUNTU_CODENAME}` main" | sudo tee /etc/apt/sources.list.d/intel-openvino-2022.list

# Install OpenVINO toolkit and recommended version of OpenCL driver
#sudo apt-get install -y ocl-icd-libopencl1
#sudo -E ./install_NEO.sh
sudo apt-get update && sudo apt-get install -y openvino-libraries-dev-2022.1.0
sudo apt-get update && sudo apt-get install -y libopenvino-python-2022.1.0
sudo -E /opt/intel/openvino_2022/install_dependencies/install_NEO_OCL_driver.sh

# Install Intel® DL Streamer and recommended version of media driver
sudo apt-get update && sudo apt-get install -y intel-dlstreamer-dev
sudo -E /opt/intel/dlstreamer/install_dependencies/install_media_driver.sh

# Setup OpenVINO and Intel® DL Streamer environment
source /opt/intel/openvino_2022/setupvars.sh
source /opt/intel/dlstreamer/setupvars.sh

echo "Installation Complete !"
