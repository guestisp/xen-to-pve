# xen-to-pve
XenServer to Proxmox direct export script.

PRs are welcome.

Basically, it export a VM from XS host and, while transferring it,
automatically extract the tarball and convert to a raw image.

In other words, the single export phase is the only phase needed,
extraction and convertion are done on the fly during the exprort,
saving time.

After running the script, you'll end with 1 file for any exported disk.
Due to a qemu bug, each disk must be renamed to remove the ":" chars
from the filename.

Then, on PVE node:

```
qm importdisk 100 disk1.raw local-zfs
```

where `100` is the VM id, `disks1.raw` is the extracted (and renamed) disk
image and `local-zfs` is the local PVE storage name

and you are ready.

Just create a new VM (to get the VM-ID) without any attached disks. 
