#!/bin/bash
# Generate maps
map_files=(
    "./maps/relic_base/relicbase-1.dmm"
    "./maps/relic_base/relicbase-2.dmm"
    "./maps/relic_base/relicbase-3.dmm"
    "./maps/relic_base/relicbase-4.dmm"
    "./maps/relic_base/relicbase-5.dmm"
    "./maps/relic_base/relicbase-6.dmm"
    "./maps/relic_base/relicbase-7.dmm"
    "./maps/relic_base/relicbase-8.dmm"
    "./maps/relic_base/relicbase-9.dmm"
    "./maps/relic_base/relicbase-10.dmm"
    "./maps/relic_base/relicbase-11.dmm"
    "./maps/relic_base/relicbase-12.dmm"
    "./maps/relic_base/relicbase-13.dmm"
)

~/dmm-tools minimap "${map_files[@]}"

# Move and rename files so the game understands them
cd "data/minimaps"

convert "relicbase-1-1.png" -resize 2240x2240 "relicbase_nanomap_z1.png"
convert "relicbase-2-1.png" -resize 2240x2240 "relicbase_nanomap_z2.png"
convert "relicbase-3-1.png" -resize 2240x2240 "relicbase_nanomap_z3.png"
convert "relicbase-4-1.png" -resize 2240x2240 "relicbase_nanomap_z4.png"
convert "relicbase-5-1.png" -resize 2240x2240 "relicbase_nanomap_z5.png"
convert "relicbase-6-1.png" -resize 2240x2240 "relicbase_nanomap_z6.png"
convert "relicbase-7-1.png" -resize 2240x2240 "relicbase_nanomap_z7.png"
convert "relicbase-8-1.png" -resize 2240x2240 "relicbase_nanomap_z8.png"
convert "relicbase-9-1.png" -resize 2240x2240 "relicbase_nanomap_z9.png"
convert "relicbase-10-1.png" -resize 2240x2240 "relicbase_nanomap_z10.png"
convert "relicbase-11-1.png" -resize 2240x2240 "relicbase_nanomap_z11.png"
convert "relicbase-12-1.png" -resize 2240x2240 "relicbase_nanomap_z12.png"
convert "relicbase-13-1.png" -resize 2240x2240 "relicbase_nanomap_z13.png"

rm -rf "relicbase-1-1.png"
rm -rf "relicbase-2-1.png"
rm -rf "relicbase-3-1.png"
rm -rf "relicbase-4-1.png"
rm -rf "relicbase-5-1.png"
rm -rf "relicbase-6-1.png"
rm -rf "relicbase-7-1.png"
rm -rf "relicbase-8-1.png"
rm -rf "relicbase-9-1.png"
rm -rf "relicbase-10-1.png"
rm -rf "relicbase-11-1.png"
rm -rf "relicbase-12-1.png"
rm -rf "relicbase-13-1.png"

cd "../../"
cp data/minimaps/* "icons/_nanomaps/"
