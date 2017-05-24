# Simple state to disable firewalld service
#
disable_firewalld:
  service.dead:
    - name: firewalld
    - enable: False
