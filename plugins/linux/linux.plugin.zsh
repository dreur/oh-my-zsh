mount_iso() {
  sudo mkdir /tmp/cdrom
  sudo mount -o loop,exec $1 /tmp/cdrom
}

umount_iso() {
  if ( sudo umount /tmp/cdrom ); then
    sudo rm -r /tmp/cdrom
  else
    lsof /tmp/cdrom
  fi
}
