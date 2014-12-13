{% from "samba/map.jinja" import samba with context %}

samba:
  pkg.installed:
    - name: {{ samba.server }}
  service.running:
    - name: {{ samba.service }}
    - enable: True
    - require:
      - pkg: samba
