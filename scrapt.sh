#! /bin/bash
# scrapt by Joe Koop 2022 MIT license
# https://github.com/jkoop/scrapt

if [ -z "$1" ]; then
    echo "Usage: $0 <repo-dir>"
    exit 1
fi

cd $1
mkdir -pv all/
cd all/

echo "Fetching missing deb files"
../fetchAll.sh

cd ../

apt-ftparchive packages . | tee Packages | gzip -9 > Packages.gz
echo "Created Packages file"

apt-ftparchive release . > Release
gpg --armor --detach-sign Release && mv Release.asc Release.gpg
gpg --clear-sign Release && mv Release.asc InRelease
echo "Created Release file"

tac Packages |
        egrep '^(Filename|Description):' |
        sed 's/^Filename: \.\/all\//'\'' /g' |
        sed 's/Description: /AddDescription '\''/g' |
        sed 's/\s*$//g' |
        tr "\n" "\a" |
        sed 's/\a'\''/'\''/g' |
        sed 's/\a/\n/g' > all/.htaccess
echo "Created all/.htaccess"
