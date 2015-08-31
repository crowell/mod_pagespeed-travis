#!/bin/bash
sudo apt-get install apache2 g++ python subversion gperf make devscripts fakeroot git curl
mkdir -p ~/bin
cd ~/bin
svn co http://src.chromium.org/svn/trunk/tools/depot_tools
mkdir ~/modpagespeed
~/bin/depot_tools/gclient config https://github.com/pagespeed/mod_pagespeed.git --unmanaged --name=src
git clone https://github.com/pagespeed/mod_pagespeed.git src
~/bin/depot_tools/gclient sync --force
cd src
make AR.host=`pwd`/build/wrappers/ar.sh AR.target=`pwd`/build/wrappers/ar.sh \
      BUILDTYPE=Release mod_pagespeed_test pagespeed_automatic_test

