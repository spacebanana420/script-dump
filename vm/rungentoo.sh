qemu-system-x86_64 -enable-kvm -cdrom install-amd64-minimal-20240307T183608Z.iso -hda gentoo.qcow2 -usb -smp cores=5 -vga qxl -vga std -m 5G -nic user,model=virtio-net-pci
