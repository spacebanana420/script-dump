#qemu-system-x86_64 -enable-kvm -cdrom NetBSD-9.3-amd64.iso -hda netbsd.qcow2 -usb -smp cores=5 -vga qxl -vga std -m 5G -nic user,model=virtio-net-pci
qemu-system-x86_64 -enable-kvm -hda netbsd.qcow2 -usb -smp cores=5 -vga qxl -vga std -m 5G -nic user,model=virtio-net-pci
