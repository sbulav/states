######################################################
#----State to set correct yum proxy      ------------#
#----based on pillar value and minion IP ------------#
######################################################
{% from "proxy/map.jinja" import proxy with context %}
#Remove old proxy from yum.conf
#Use regexp lookahead to gain state idempotency
delete_old_proxy:
  file.replace:
    - name: /etc/yum.conf
    - pattern: '^ *proxy *= *(?!{{proxy.http}}).*$'
    #- pattern: "^ *proxy *= *http://.*$"
    - repl: ''

#Remove empty lines from yum.conf
remove_empty_lines:
  file.replace:
    - name: /etc/yum.conf
    - pattern: '^\n'
    - repl: ''
    - bufsize: file
    - require:
      - file: delete_old_proxy

#Append new proxy to yum.conf
append_new_proxy:
  file.append:
    - name: /etc/yum.conf
    - text: proxy={{ proxy.http }}
    - require:
      - file: remove_empty_lines
