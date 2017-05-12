#Set up sysctl values,disable ipv6
{% for sysvalue in ['net.ipv6.conf.all.disable_ipv6', 'net.ipv6.conf.default.disable_ipv6'] %}
disable_{{ sysvalue }}:
  sysctl.present:
    - name: {{ sysvalue }}
    - value: 1
{% endfor %}
