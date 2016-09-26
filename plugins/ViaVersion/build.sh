#!/usr/bin/env bash
# Copyright Max Qian 2016 GPLv2

cd "$(dirname "$0")"

if [ ! -d source ]; then
    git clone https://github.com/MylesIsCool/ViaVersion.git source
fi

cd source
git reset origin/master --hard

git am ../*.patch
mvn install
mv target/ViaVersion* ../../../build
