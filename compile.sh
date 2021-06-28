#!/bin/sh


# BEGINNING
{
	# Any subsequent(*) commands which fail will cause the shell script to exit immediately
	set -e;
	#echo "Script executed from: $(pwd)";
};


# END
{
	echo "Goodbye!";
	exit $?;
};
