efibootmgr --create --disk /dev/nvme0n1 --part 1 --label "Arch Linux" --loader /vmlinuz-linux --unicode 'root=UUID=868edd19-d531-4ee8-94a9-e7e31ccd4b3a rw initrd=\initramfs-linux.img quiet loglevel=3 udev.log_level=3 vt.global_cursor_default=0 systemd.show_status=auto rd.udev.log_level=3'