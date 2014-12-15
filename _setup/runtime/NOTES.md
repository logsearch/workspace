# Mounting the workspace volume 
mkdir /workspaces
   #only if its an empty volume   mkfs -t ext4 /dev/xvdf
Add to   /etc/fstab
   /dev/xvdf       /workspaces   ext4    defaults,nofail        0       2
mount -a
