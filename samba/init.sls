{% from "samba/map.jinja" import samba with context %}

  {% if grains.os not in ('MacOS', 'Windows',) %}

samba:
  pkg.installed:
    - name: {{ samba.server }}
  service.running:
    - name: {{ samba.service }}
    - enable: True
    - require:
      - pkg: samba

  {% endif %}
