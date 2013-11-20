{% from "samba/map.jinja" import samba with context %}

smbclient:
  pkg:
    - installed
    - name: {{ samba.client }}
