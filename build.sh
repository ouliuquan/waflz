#!/bin/bash
# ----------------------------------------------------------------------------
# Copyright (C) 2016 Verizon.  All Rights Reserved.
# All Rights Reserved
#
#   Author: Reed P Morrison
#   Date:   09/13/2016
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# Requirements to build...
# ------------------------------------------------------------------------------
which cmake g++ make || {
    echo "Failed to find required build packages. Please install with: sudo apt-get install cmake make g++"
    exit 1
}
# This is necessary in scenarios where the URL of the remote for a given submodule has changed.
git submodule sync || {
    echo "FAILED TO SYNC IS2 LIB"
    exit 1
}
git submodule update -f --init || {
    echo "FAILED TO UPDATE TO LATEST IS2 LIB"
    exit 1
}
# ------------------------------------------------------------------------------
# Build waflz
# ------------------------------------------------------------------------------
mkdir -p build
pushd build && \
    cmake ../ \
    -DBUILD_SYMBOLS=ON \
    -DBUILD_APPS=ON \
    -DBUILD_UBUNTU=ON \
    -DBUILD_RATE_LIMITING=ON \
    -DCMAKE_INSTALL_PREFIX=/usr && \
    make -j$(nproc) && \
    make test && \
    umask 0022 && chmod -R a+rX . && \
    make package && \
popd && \
exit $?
