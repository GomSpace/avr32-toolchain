#!/bin/bash
function check_install_file {
	install_file=$1
	if [ ! -f "$install_file" ]; then
		echo "Installation file $install_file not found"
		exit 1
	fi
	#return 1
}

set -e
dry_run="no"
while test $# -gt 0; do
	arg=$1
	if [ "$arg" == "-d" ]; then
		dry_run="yes"
	fi
	if [ "$arg" == "-h" ]; then
		echo "Usage: $0 [-d] [-h]"
		echo "       -d   : dry run, dont install, just test"
		echo "       -h   : print this help text"
		exit 2
	fi
	shift
done
package_name="AVR32 Tool Chain"
arch=`uname -m`

echo "Verifying $package_name installation files ($arch)"
check_install_file avr32-gnu-toolchain-3.4.2.435-linux.any.$arch.tar.gz
check_install_file avr32-utilities-$arch.tar.gz
check_install_file atmel-headers-6.1.3.1475.zip
echo "$package_name installation files verified OK"

if [ $dry_run == "yes" ]; then
echo "Installation is possible"
else
echo "Installing $package_name Binaries for $arch"
tar xfz avr32-gnu-toolchain-3.4.2.435-linux.any.$arch.tar.gz
if [ ! -d /usr/local/avr32 ]; then
sudo mkdir /usr/local/avr32
fi
sudo cp -ra avr32-gnu-toolchain-linux_$arch/* /usr/local/avr32/
rm -rf ./avr32-gnu-toolchain-linux_$arch

echo "Installing $package_name Utilities for $arch"
tar xfz avr32-utilities-$arch.tar.gz
sudo cp -ra avr32-utilities-$arch/bin/* /usr/bin
sudo cp -ra avr32-utilities-$arch/share/* /usr/share
sudo cp -ra avr32-utilities-$arch/etc/* /etc
rm -rf avr32-utilities-$arch

echo "Installing $package_name Headers"
unzip -q atmel-headers-6.1.3.1475.zip
sudo cp -ra atmel-headers-6.1.3.1475/avr32/ /usr/local/avr32/avr32/include/
rm -rf atmel-headers-6.1.3.1475

echo "Checking environment"
# Setup path
add_to_path='/usr/local/avr32/bin'
if ! grep -q "PATH.*$add_to_path" ~/.profile; then
echo "Setting up PATH: Adding $add_to_path to PATH"
echo "PATH=\$PATH:$add_to_path" >> ~/.profile
export PATH=\$PATH:$add_to_path
echo $PATH
fi
# Setup aliases
if ! grep -q "alias waf" ~/.bash_aliases; then
echo "Setting up aliases"
echo "alias waf=./waf" >> ~/.bash_aliases
echo "alias a=ack-grep" >> ~/.bash_aliases
fi
echo "$package_name installation completed OK"
fi

