#!/bin/bash
sudo apt-get update 2>&1 > /dev/null
sudo apt-get install apache2 g++ python subversion gperf make devscripts fakeroot git curl netcat-traditional 2>&1 > /dev/null
sudo mv /bin/nc.traditional /usr/bin/nc
mkdir -p ~/bin
cd ~/bin
svn co http://src.chromium.org/svn/trunk/tools/depot_tools 2>&1 > /dev/null
mkdir ~/build_directory
cd ~/build_directory
~/bin/depot_tools/gclient config https://github.com/pagespeed/mod_pagespeed.git --unmanaged --name=src
git clone https://github.com/pagespeed/mod_pagespeed.git src
~/bin/depot_tools/gclient sync --force
cd src
CFLAGS="-Wno-sign-compare" CXXFLAGS="-Wno-sign-compare" make AR.host=`pwd`/build/wrappers/ar.sh AR.target=`pwd`/build/wrappers/ar.sh BUILDTYPE=Release
python build/gyp_chromium -Dchannel=beta
CFLAGS="-Wno-sign-compare" CXXFLAGS="-Wno-sign-compare" make BUILDTYPE=Release AR.host=`pwd`/build/wrappers/ar.sh AR.target=`pwd`/build/wrappers/ar.sh linux_package_deb
sudo dpkg -i out/Release/mod-pagespeed*.deb
