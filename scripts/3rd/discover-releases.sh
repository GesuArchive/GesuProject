#!/usr/bin/env bash

# https://github.com/BYOND/byond-release-finder/blob/master/discover-releases.sh

process_release() {
	local FOLDER=$1
	local VERSION=$2
	local MAJOR_VERSION=$(cut -d '.' -f 1 <<< "${VERSION}")

	if [ ! -d "${FOLDER}/${VERSION}" ]; then
		mkdir -p ${FOLDER}/${VERSION}
		curl -o ${FOLDER}/${VERSION}/${VERSION}_byond_linux.zip http://www.byond.com/download/build/${MAJOR_VERSION}/${VERSION}_byond_linux.zip
		return 1
	fi
	return 0
}

VERSIONS=($(curl -s http://www.byond.com/download/version.txt))
STABLE_VERSION=${VERSIONS[0]}
BETA_VERSION=${VERSIONS[1]}
EXIT=0
echo "Stable version is ${STABLE_VERSION}"
process_release /data/stable ${STABLE_VERSION}
EXIT=$(($?|${EXIT}))

# https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html
#  Rus: https://www.opennet.ru/docs/RUS/bash_scripting_guide/x4462.html
#       https://www.opennet.ru/docs/RUS/bash_scripting_guide/x2565.html
if [ "${#VERSIONS[@]}" -gt "1" ]; then
	echo "Beta version is ${BETA_VERSION}"
	process_release /data/beta ${BETA_VERSION}
	EXIT=$(($?|${EXIT}))
fi

exit ${EXIT}
