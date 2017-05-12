#Disabling symlinks on RHEL according to 
#https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/Networking_Guide/sec-Disabling_Consistent_Network_Device_Naming.html
/etc/udev/rules.d/80-net-name-slot.rules:
  file.symlink:
    - target: /dev/null
