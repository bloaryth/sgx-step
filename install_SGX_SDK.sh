set -e
#git clone https://github.com/intel/linux-sgx.git
cd linux-sgx
./download_prebuilt.sh

# sudo apt-get install build-essential ocaml automake autoconf libtool wget python # 16.04
sudo apt-get install build-essential ocaml ocamlbuild automake autoconf libtool wget python libssl-dev - # 18.04

sudo apt-get install libssl-dev libcurl4-openssl-dev protobuf-compiler libprotobuf-dev -y
sudo apt-get install build-essential python -y
sudo apt-get install libssl-dev libcurl4-openssl-dev libprotobuf-dev -y
sudo apt-get install alien -y
sudo apt-get install uuid-dev libxml2-dev cmake pkg-config -y

make -j`nproc`
make sdk_install_pkg
make deb_pkg

cd linux/installer/bin/
sudo ./sgx_linux_x64_psw_*.bin
cd ../deb
sudo dpkg -i ./libsgx-urts_*-*_amd64.deb ./libsgx-enclave-common_*-*_amd64.deb << EOF
no
/opt/intel
EOF

echo "SGX SDK succesfully installed!"
