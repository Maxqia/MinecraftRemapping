#!/usr/bin/env bash
# Copyright Max Qian 2016 GPLv2

cd "$(dirname "$0")"

cat ../../mappings/v1_10_R1/{vcb2pore,vcb2mcp}.srg > combined.srg
../../tools/Srg2Source/buildSrg2Source.sh || exit 1
srgjar=$(realpath ../../tools/Srg2Source*.jar)
if [ ! -d source ]; then
    git clone https://github.com/ProtocolSupport/ProtocolSupport.git source
fi

cd source
git am --abort
git reset origin/master --hard
git pull
./gradlew clean

./gradlew build || exit 1
java -cp $srgjar net.minecraftforge.srg2source.ast.RangeExtractor . none ../ProtocolSupport.range
java -cp $srgjar net.minecraftforge.srg2source.rangeapplier.RangeApplier --srcRangeMap ../ProtocolSupport.range --srcRoot . --srgFiles ../combined.srg

git add .
git commit -m "Initial Srg2Source Remap"
git am ../*.patch

./gradlew build || exit 1
cp target/* ../../../build/
rm ../combined.srg ../ProtocolSupport.range
