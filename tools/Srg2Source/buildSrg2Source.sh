#!/usr/bin/env bash
# Copyright Max Qian 2016 GPLv2

cd "$(dirname "$0")"
if [ ! -d source ]; then
    git clone -b ease https://github.com/Maxqia/Srg2Source.git source
fi

cd source
git reset --hard origin/ease
git am ../*.patch
./gradlew build || exit 1
mv build/libs/Srg2Source-4.0-SNAPSHOT-all.jar ../../
