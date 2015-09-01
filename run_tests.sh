#!/bin/bash
cd ~/build_directory/src
./out/Release/mod_pagespeed_test
./out/Release/pagespeed_automatic_test
cd install
sudo -E ./ubuntu.sh apache_debug_restart
sudo -E ./ubuntu.sh apache_vm_system_tests
