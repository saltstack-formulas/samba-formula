{% from "samba/map.jinja" import samba with context %}

samba_service_clean:
  service.dead:
    - name: {{ samba.service }}
    - enable: False
  pkg.removed:
    - name: {{ samba.server }}
