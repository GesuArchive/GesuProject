#!/bin/sh


# BEGINNING
{
	# Any subsequent(*) commands which fail will cause the shell script to exit immediately
	set -e;
	#echo "Script executed from: $(pwd)";
};

# DEPENDENCIES
{
	sudo apt update && sudo apt dist-upgrade -y && sudo apt autoremove -y
	sudo dpkg --add-architecture i386
	sudo apt update && sudo apt install git language-pack-ru libc6:i386 libncurses5:i386 libssl-dev:i386 libstdc++6:i386 make mariadb-server python3 screen unzip zlib1g:i386 -y
};

# LOCALE (Rus)
{
	# Original: LANG=C.UTF-8
	sudo echo "LANG=ru_RU.UTF-8" > "/etc/default/locale"
};


# COMPULE
{
	dm -l -verbose GesuProject.dme
};

# END
{
	echo "Goodbye!";
	exit $?;
};
