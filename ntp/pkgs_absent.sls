{% for pkg in pillar.get('absent_pkgs', []) %}
{{ pkg }}.absent:
  pkg.removed:
    - require_in:
      - pkg: ntp
{% endfor %}
