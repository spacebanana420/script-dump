#!/bin/bash
create () {
    echo "Choose disk image size in MB"
    read size
    count=$(( $size * 1000 / 32 ))
    size=$((size / 1000))
    if [[ $2 != "" ]]
    then
        name=$2
    else
        name="diskimg${size}G"
    fi
    dd if=/dev/zero of=$name.img count=$count bs=32k
    echo "Mount disk image? (y/n)"
    read mountans
    if [[ $mountans == "y" || $mountains == "yes" ]]
    then
        echo "Loop device to mount? (default=0)"
        read loopnumber
        if [[ $loopnumber != ""  ]]
        then
            sudo losetup loop$loopnumber diskimg${size}G.img
        else
            sudo losetup loop0 diskimg${size}G.img
        fi
    fi
}

mountimg () {
    echo "Disk image file name?"
    read name
    echo "Loop device to mount? (default=0)"
    read loopnumber
    if [[ $loopnumber != ""  ]]
    then
        loopnumber=0
    else
    sudo losetup -P loop$loopnumber $name
    fi
}

unmountimg () {
    sudo losetup -D
}

compressimg () {
echo ""; echo "Files in current directory:"; ls; echo ""
echo "Pick a disk image file to compress (type 'all' or 'batch' to compress all)"
read imgfile
echo "Keep original? (y/n)"
read keepans
if [[ $keepans == "y" ]]
then
    keep="-k"
else
    keep=""
fi

if [[ $imgfile != "all" || $imgfile != "batch" ]]
then
    xz -2 -v $keep --threads=0 $imgfile
else
    for i in *
    do
        if [[ $i == *".img"* ]]
        then
            xz -2 -v $keep --threads=0 $i
        fi
    done

fi
}

case $1 in
    create)
        create
    ;;
    mount)
        mountimg
    ;;
    unmount)
        unmountimg
    ;;
    compress)
        compressimg
    ;;
    *)
    echo "Disk Image Management Utility (version 1.2)"; echo ""
    echo "Choose an action:"
    echo "create   mount   unmount  compress"
    read action
    case $action in
        create)
            create
        ;;
        mount)
            mountimg
        ;;
        unmount)
            unmountimg
        ;;
        compress)
            compressimg
        ;;
        *)
            echo "Wrong action"
        ;;
    esac
    ;;
esac
