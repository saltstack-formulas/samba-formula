{% from "samba/map.jinja" import samba with context %}

samba_client:
  pkg.installed:
    - name: {{ samba.client }}
