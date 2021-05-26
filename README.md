# xen-to-pve
XenServer to Proxmox direct export script.
Version 2

PRs are welcome.

Basically, it directly export a VM from XS host to a PVE ZFS pool

In other words, the single export phase is the only phase needed,
no need for tarball extraction, merging and importing with "qm",
saving time.

To use:
- create a new VM on PVE
- remove all attached disks
- run migrate.sh xs-vm-uuid pve-vm-id host port user pass

Requirements: 
  - XCP-XE: http://mirror.yy.duowan.com:63782/ubuntu/pool/universe/x/xen-api/xcp-xe_1.3.2-5ubuntu1_amd64.deb
  - stunnel
