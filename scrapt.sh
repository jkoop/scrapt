#! /bin/bash
# scrapt by Joe Koop 2022 MIT lisence

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

apt-ftparchive packages . > Packages
echo "Created Packages file"

apt-ftparchive release . > Release
gpg --armor --detach-sign Release && mv Release.asc Release.gpg
gpg --clear-sign Release && mv Release.asc InRelease
echo "Created Release file"
