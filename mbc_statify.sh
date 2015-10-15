#!/bin/bash

if [ $# -ne 1 ]; then
    echo "usage: $0 [static repo]"
    exit 1
fi

devDir=$(pwd)
staticDir=$(readlink -f $1)

#Does meteor-build-client exist?
command -v meteor-build-client > /dev/null 2>&1

if [ $? -ne 0 ]; then
    echo "Could not find meteor-build-client. Make sure it is installed."
    exit 1
fi

mbcDir=$(mktemp -d --tmpdir=..)

cd $devDir
meteor-build-client $mbcDir

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
