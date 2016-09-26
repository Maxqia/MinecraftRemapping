#!/usr/bin/env bash
cd "$(dirname "$0")"

if [ -d source ]; then
    printf "ProtocolSupport is already built\n"
    exit
fi

cat ../../mappings/v1_10_R1/{vcb2pore,vcb2mcp}.srg > combined.srg
bash ../../tools/Srg2Source/buildSrg2Source.sh
cd "$(dirname "$0")"

if [ ! -d source ]; then
    git clone https://github.com/ProtocolSupport/ProtocolSupport.git source
fi

cd source
git reset origin/master --hard

./gradlew build
java -cp ../../../tools/Srg2Source-4.0-SNAPSHOT-all.jar net.minecraftforge.srg2source.ast.RangeExtractor . none ../ProtocolSupport.range
java -cp ../../../tools/Srg2Source-4.0-SNAPSHOT-all.jar net.minecraftforge.srg2source.rangeapplier.RangeApplier --srcRangeMap ../ProtocolSupport.range --srcRoot . --srgFiles ../combined.srg

git add .
git commit -m "Inital Srg2Source Remap"
git am ../*.patch

./gradlew build
mv target/* ../../../build/
rm ../combined.srg ../ProtocolSupport.range
