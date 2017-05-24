# Simple state to disable iptables service
#
disable_iptables:
  service.dead:
    - name: iptables
    - enable: False
