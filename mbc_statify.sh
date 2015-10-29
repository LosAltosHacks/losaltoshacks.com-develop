#!/bin/bash

set -e

if [ $# -ne 1 ]; then
    echo "usage: $0 [static repo]"
    exit 1
fi

platform=$(uname)
devDir=$(pwd)

if [ $platform == "Darwin" ]; then
  staticDir=$(greadlink -f $1) # greadlink for mac (requires brew install coreutils)
else
  staticDir=$(readlink -f $1)
fi

#Does meteor-build-client exist?
command -v meteor-build-client > /dev/null 2>&1

if [ $? -ne 0 ]; then
    echo "Could not find meteor-build-client. Make sure it is installed."
    exit 1
fi

# Must be relative becomes meteor-build-client does not support absolute paths...
#mbcDir=$(mktemp -d --tmpdir=..) doesn't work on mac

# To support both darwin and linux: http://unix.stackexchange.com/questions/30091/fix-or-alternative-for-mktemp-in-os-x
mbcDir=$(mktemp -d 2>/dev/null || mktemp -d -t '/tmp/') # doesn't work

echo $mbcDir

cd $devDir
meteor-build-client $mbcDir

# Change to absolute path
if [ $platform == "Darwin" ]; then
  mbcDir=$(greadlink -f $mbcDir) # greadlink for mac (requires brew install coreutils)
else
  mbcDir=$(readlink -f $mbcDir)
fi

cd $mbcDir

# Rename css and js files
mv -v $(echo "*.css") "style.css"
sed index.html -i -e 's/href="\/.\+\.css?.\+true"/href="style\.css"/'

mv -v $(echo "*.js") "script.js"
sed index.html -i -e 's/src="\/.\+\.js"/src="script\.js"/'

cp -rf * $staticDir
cd ..
rm -rf $mbcDir

echo -e "\nFiles should now be updated in $staticDir. Please inspect them and commit when ready."
