#!/usr/bin/env bash
# Copyright Max Qian 2016 GPLv2

cd "$(dirname "$0")"

cat ../../mappings/v1_10_R1/{vcb2pore,vcb2mcp}.srg > combined.srg
../../tools/Srg2Source/buildSrg2Source.sh || exit 1

if [ ! -d source ]; then
    git clone https://github.com/ProtocolSupport/ProtocolSupport.git source
fi

cd source
git reset origin/master --hard

./gradlew build || exit 1
java -cp ../../../tools/Srg2Source-4.0-SNAPSHOT-all.jar net.minecraftforge.srg2source.ast.RangeExtractor . none ../ProtocolSupport.range
java -cp ../../../tools/Srg2Source-4.0-SNAPSHOT-all.jar net.minecraftforge.srg2source.rangeapplier.RangeApplier --srcRangeMap ../ProtocolSupport.range --srcRoot . --srgFiles ../combined.srg

git add .
git commit -m "Inital Srg2Source Remap"
git am ../*.patch

./gradlew build || exit 1
mv target/* ../../../build/
rm ../combined.srg ../ProtocolSupport.range
