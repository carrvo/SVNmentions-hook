#!/bin/bash

# Credit: https://stackoverflow.com/a/246128
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# ensure:
# 1) has a value
# 2) ends with slash (/)
if [[ "$1" == "" || "$1" != */ ]];
then
	echo "usage: ./install.bash /path/to/svn-repo/ https://example.com/apache2/webspace/path"
	exit 1
fi

# ensure:
# 1) has a value
# 2) starts with http (for http:// or https://)
# 3) does NOT end with slash (/)
if [[ "$2" == "" || "$2" != http* || "$2" == */ ]];
then
	echo "usage: ./install.bash /path/to/svn-repo/ https://example.com/apache2/webspace/path"
	exit 1
fi

if [ "$3" == "" ];
then
    CLIENT_ID=WebmentionsHook
else
    CLIENT_ID="$3"
fi

pushd "$1" > /dev/null
cd hooks/
echo installing post-commit in $PWD
ln -s $SCRIPT_DIR/post-commit
echo "$2" > $PWD/apache2.path
echo "$CLIENT_ID" > $PWD/apache2.id
if [ ! -f $PWD/apache2.path ];
then
    echo "Please manually create apache2.path"
    echo "echo $2 > $PWD/apache2.path"
fi
if [ ! -f $PWD/apache2.id ];
then
    echo "Please manually create apache2.id"
    echo "echo $CLIENT_ID > $PWD/apache2.id"
fi
popd > /dev/null

