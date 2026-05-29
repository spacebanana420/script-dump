if [[ $1 == "mount" ]]
then
    echo "Disk image file name?"
    read name
    sudo losetup -P /dev/loop0 $name
elif [[ $1 == "unmount" ]]
then
    sudo losetup -D
else
    echo "Choose an argument when executing the script (mount; unmount)"
fi
