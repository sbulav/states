#Disabling CTRL+ALT+DEL PRESS
/usr/lib/systemd/system/ctrl-alt-del.target:
  file.symlink:
    - target: /dev/null
