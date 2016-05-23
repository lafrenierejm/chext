#!/bin/sh

#
# chext installation script
#

# Prompt for the installation path
printf "%b"\
	"Please choose an installation location:\n"\
	"1 for /usr/local/bin (default, may require sudo permissions)\n"\
	"2 for $HOME/bin\n"\
	"or type another path: "
read -r path_input

case ${path_input:-$1} in
	1|"")
		install_path="/usr/local"
		;;
	2)
		install_path="$HOME"
		;;
	*)
		install_path=$path_input
		;;
esac

printf "%s\n" "Installing to ${install_path}/bin..."

# Install the executable
if [ ! -e "${install_path}/bin" ]; then
	mkdir -p "${install_path}/bin"
fi
cp chext "${install_path}/bin"

# Install the man page
if [ ! -e "${install_path}/share/man/man1" ]; then
	mkdir -p "${install_path}/share/man/man1"
fi
cp chext.1 "${install_path}/share/man/man1"

# Run unit tests
if hash bats 2> /dev/null; then
	printf "BATS found, testing chext...\n"
	bats chext.bats
fi
