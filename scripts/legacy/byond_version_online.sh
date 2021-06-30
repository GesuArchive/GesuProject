
#!/usr/bin/env bash

process_release() {
	local VERSION=$1
	local MAJOR_VERSION=$(cut -d '.' -f 1 <<< "${VERSION}")
	echo "  Major version is: $MAJOR_VERSION"
	local MINOR_VERSION=$(cut -d '.' -f 2 <<< "${VERSION}")
	echo "  Minor version is: $MINOR_VERSION"
	return 0
}

filename="./byond_ver_cashed.txt"

if [ ! -e "$filename" ] ; then
    echo "File \"$filename\" doesn't existing, creationg..."
    touch "$filename"
fi

if [ ! -w "$filename" ] ; then
	chmod 777 "$filename"
	if [ ! -w "$filename" ] ; then
		echo "Error! Can not write to \"$filename\"."
		exit 1
	fi
fi

VERSIONS=($(curl -s http://www.byond.com/download/version.txt))
STABLE_VERSION=${VERSIONS[0]}
BETA_VERSION=${VERSIONS[1]}
EXIT=0
echo " Stable version is: ${STABLE_VERSION}"
process_release ${STABLE_VERSION}
EXIT=$(($?|${EXIT}))

if [ "${#VERSIONS[@]}" -gt "1" ] ; then
	echo " Beta version is: ${BETA_VERSION}"
	process_release ${BETA_VERSION}
	EXIT=$(($?|${EXIT}))
fi

exit ${EXIT}




#!/bin/sh

# Inspired: https://github.com/BYOND/byond-release-finder/blob/master/discover-releases.sh

filename="./byond_ver_cashed.txt"

touch "$filename"
chmod 777 "$filename"
curl "http://www.byond.com/download/version.txt" > "$filename"
#echo $'\n' >> "$filename"

while IFS= read -r line || [ -n "$line" ] ; do
	# reading each line
    printf '%s\n' "$line"
done < "$filename"

value=($(<$filename))
echo "$value"
