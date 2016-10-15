#!/usr/bin/env bash
# Copyright Max Qian 2016 GPLv2

cd "$(dirname "$0")"

if [ ! -d source ]; then
    git clone https://github.com/MylesIsCool/ViaVersion.git source
fi

cd source
git reset origin/1.11-DEV --hard
git checkout 1.11-DEV
git pull

git am ../*.patch

mvn clean
mvn install
cp jar/target/ViaVersion* ../../../build
