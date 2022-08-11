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

### [start] deb file fetching
#############################

# micro text editor
micro="https://github.com/zyedidia/micro/releases"
curl -s $micro | egrep -o '/zyedidia/micro/releases/download/v[^>]+\.deb' | wget --continue --quiet --show-progress --base=$micro --input-file=/dev/stdin

### [end] deb file fetching
###########################

cd ../

apt-ftparchive packages . > Packages
echo "Created Packages file"

apt-ftparchive release . > Release
echo "Created Release file"
