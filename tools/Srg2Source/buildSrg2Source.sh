#!/bin/bash
# Copyright Max Qian 2016 GPLv2
cd "$(dirname "$0")"
if [ -f ../Srg2Source-4.0-SNAPSHOT-all.jar ]; then
    printf "Srg2Source already built\n"
    exit 0
fi

git clone -b ease https://github.com/Maxqia/Srg2Source.git source
cd source
git am ../*.patch
./gradlew build
mv build/libs/Srg2Source-4.0-SNAPSHOT-all.jar ../../
