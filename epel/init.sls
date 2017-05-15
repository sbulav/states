{% from "epel/map.jinja" import epel_release,pkg with context %}

install_pubkey_epel:
  file.managed:
    - name: /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL
    - source: {{ salt['pillar.get']('epel:pubkey', pkg.key) }}
    - source_hash:  {{ salt['pillar.get']('epel:pubkey_hash', pkg.key_hash) }}


epel_release:
  pkg.installed:
    - sources:
      - epel-release: {{ salt['pillar.get']('epel:rpm', pkg.rpm) }}
    - require:
      - file: install_pubkey_epel

set_pubkey_epel:
  file.replace:
    - append_if_not_found: True
    - name: /etc/yum.repos.d/epel.repo
    - pattern: '^gpgkey=.*'
    - repl: 'gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL'
    - require:
      - pkg: epel_release

set_gpg_epel:
  file.replace:
    - append_if_not_found: True
    - name: /etc/yum.repos.d/epel.repo
    - pattern: 'gpgcheck=.*'
    - repl: 'gpgcheck=1'
    - require:
      - pkg: epel_release

{% if salt['pillar.get']('epel:disabled', False) %}
disable_epel:
  file.replace:
    - name: /etc/yum.repos.d/epel.repo
    - pattern: '^enabled=[0,1]'
    - repl: 'enabled=0'
{% else %}
enable_epel:
  file.replace:
    - name: /etc/yum.repos.d/epel.repo
    - pattern: '^enabled=[0,1]'
    - repl: 'enabled=1'
{% endif %}

{% if salt['pillar.get']('epel:testing', False) %}
enable_epel_testing:
  file.replace:
    - name: /etc/yum.repos.d/epel-testing.repo
    - pattern: '^enabled=[0,1]'
    - repl: 'enabled=1'
{% else %}
disable_epel_testing:
  file.replace:
    - name: /etc/yum.repos.d/epel-testing.repo
    - pattern: '^enabled=[0,1]'
    - repl: 'enabled=0'
{% endif %}
