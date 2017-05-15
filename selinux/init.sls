# Simple state to configure SELinux mode
# Default to enforcning
# Disabling SElinux requires system reboot
set_selinux_mode:
  selinux.mode:
    - name: {{ salt['pillar.get']('selinux:mode','enforcing') }}
