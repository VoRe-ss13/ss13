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
)

tools/github-actions/nanomap-renderer minimap -w 2240 -h 2240 "${map_files[@]}"

# Move and rename files so the game understands them
cd "data/nanomaps"

mv "talon1_nanomap_z1.png" "tether_nanomap_z13.png"
mv "talon2_nanomap_z1.png" "tether_nanomap_z14.png"
mv "relicbase-1_nanomap_z1.png" "relicbase_nanomap_z1.png"
mv "relicbase-2_nanomap_z1.png" "relicbase_nanomap_z2.png"
mv "relicbase-3_nanomap_z1.png" "relicbase_nanomap_z3.png"
mv "relicbase-4_nanomap_z1.png" "relicbase_nanomap_z4.png"
mv "relicbase-5_nanomap_z1.png" "relicbase_nanomap_z5.png"
mv "relicbase-6_nanomap_z1.png" "relicbase_nanomap_z6.png"
mv "relicbase-7_nanomap_z1.png" "relicbase_nanomap_z7.png"
mv "relicbase-8_nanomap_z1.png" "relicbase_nanomap_z8.png"
mv "relicbase-9_nanomap_z1.png" "relicbase_nanomap_z9.png"
mv "relicbase-10_nanomap_z1.png" "relicbase_nanomap_z10.png"

cd "../../"
cp data/nanomaps/* "icons/_nanomaps/"
