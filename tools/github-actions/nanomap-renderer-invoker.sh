#!/bin/bash
BASEDIR=$PWD
#Put directories to get maps from here. One per line.
mapdirs=(
<<<<<<< HEAD
        "maps/relic_base"
=======
    "maps/southern_cross"
>>>>>>> c542e3bac0 (Make nanomap renderer script cool again (#8164))
)
#DO NOT TOUCH THIS VARIABLE. It will automatically fill with any maps in mapdirs that are form MAPNAME-n.dmm where n is the z level.
map_files=()

#Fill up mapfiles list
for mapdir in ${mapdirs[@]}; do
<<<<<<< HEAD
        echo "Scanning $mapdir..."
        FULLMAPDIR=$BASEDIR/$mapdir
        map_files+=($FULLMAPDIR/*-*[0-9].dmm)
=======
    echo "Scanning $mapdir..."
    FULLMAPDIR=$BASEDIR/$mapdir
    map_files+=($FULLMAPDIR/*-*[0-9].dmm)
>>>>>>> c542e3bac0 (Make nanomap renderer script cool again (#8164))
done

#Print full map list
echo "Full map list:"
for map in ${map_files[@]}; do
<<<<<<< HEAD
        echo $map
=======
    echo $map
>>>>>>> c542e3bac0 (Make nanomap renderer script cool again (#8164))
done

printf "\n\n\n"
echo "Rendering maps..."

#Render maps to initial images
~/dmm-tools minimap "${map_files[@]}"

cd data/minimaps

printf "\n\n\n"
echo "Starting image resizing..."

#Resize images to proper size and move them to the correct place
for map in ./*.png; do
<<<<<<< HEAD
        j=$(echo $map | sed -n "s/^\.\/\(.*\)-\([0-9]*\)\-1.png$/\1_nanomap_z\2.png/p")
        echo "Resizing $map and moving to icons/_nanomaps/$j"
        convert $map -resize 2240x2240 "$BASEDIR/icons/_nanomaps/$j"
=======
    j=$(echo $map | sed -n "s/^\.\/\(.*\)-\([0-9]*\)\-1.png$/\1_nanomap_z\2.png/p")
    echo "Resizing $map and moving to icons/_nanomaps/$j"
    convert $map -resize 2240x2240 "$BASEDIR/icons/_nanomaps/$j"
>>>>>>> c542e3bac0 (Make nanomap renderer script cool again (#8164))
done
