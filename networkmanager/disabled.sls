# Simple state to disable NetworkManager service
#
disable_networkmanager:
  service.dead:
    - name: NetworkManager
    - enable: False
