#!/bin/bash

# Credit: https://stackoverflow.com/a/246128
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [ "$1" == "" ];
then
	echo "usage: ./install.bash /path/to/svn-repo/"
	exit 1
fi

pushd "$1" > /dev/null
cd hooks/
echo installing post-commit in $PWD
ln -s $SCRIPT_DIR/post-commit
popd > /dev/null

