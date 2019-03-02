{% from "samba/map.jinja" import samba with context %}

samba_client_clean:
  pkg.removed:
    - name: {{ samba.client }}
