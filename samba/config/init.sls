{% from "samba/map.jinja" import samba with context %}

include:
  - samba.server

samba_config:
  file.managed:
    - name: {{ samba.config }}
    - source: {{ samba.config_src }}
    - template: jinja
    - watch_in:
      - service: samba_service_install
