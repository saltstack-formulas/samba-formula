{% from "samba/map.jinja" import samba with context %}

include:
  - samba

samba_config:
  file.managed:
    - name: {{ samba.config }}
    - source: {{ samba.config_src }}
    - template: jinja
    - watch_in:
      - service: samba
