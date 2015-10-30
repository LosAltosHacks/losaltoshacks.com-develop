#!/bin/bash

# Exit if command returns non-zero value or unset variable is used
set -eu

if [ $# -ne 1 ]; then
    echo "usage: $0 [path to static repo]"
    exit 1
fi

if [ ! -d "$1" ]; then
    echo "Static repo directory \"$1\" does not exist."
    exit 1
fi

staticDir=$1

#Does meteor-build-client exist?
if ! command -v meteor-build-client > /dev/null 2>&1; then
    echo "Could not find meteor-build-client. Make sure it is installed."
    exit 1
fi

# Must be relative becomes meteor-build-client does not support absolute paths
# Provide explicit template for compatibility with BSD mktemp
mbcDir=$(mktemp -d tmp.XXXXXXXXXX)

meteor-build-client $mbcDir

cd $mbcDir

# Rename css and js files
# -i option isn't used because of differences between GNU and BSD implementations
temp=$(mktemp tmp.XXXXXXXXXX)

mv -v $(echo "*.css") "style.css"
sed -Ee 's/href="\/.+\.css?.+true"/href="style\.css"/' index.html > $temp
mv $temp index.html

mv -v $(echo "*.js") "script.js"
sed -Ee 's/src="\/.+\.js"/src="script\.js"/' index.html > $temp
mv $temp index.html

# temp is not rm'd because it is renamed by mv

cd ..

# Copy the contents of mbcDir to staticDir recursively, only copying changed files
# Trailing slash needed for rsync to copy contents of directory, not directory itself
rsync -tr $mbcDir/ $staticDir
rm -rf $mbcDir

echo -e "\nFiles should now be updated in $staticDir. Please inspect them and commit when ready."
