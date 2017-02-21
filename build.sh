#!/bin/bash
set -e
yum install -y sed git make autoconf libtool automake rpm-build gcc gcc-c++ zlib-devel glib2-devel libpcap-devel c-ares-devel flex bison
git clone -b master-2.0 https://github.com/wireshark/wireshark ~/wireshark
cd ~/wireshark
patch -p1 < /srv/without-gui.patch
./autogen.sh
./configure --disable-wireshark
make rpm-package
find packaging/rpm/RPMS -name '*.rpm' | xargs -I{} cp {} /srv/
