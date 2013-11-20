{% from "samba/map.jinja" import samba with context %}

samba:
  pkg:
    - installed
    - name: {{ samba.server }}
  file:
    - managed
    - name: /etc/samba/smb.conf
    - source: salt://samba/files/smb.conf
  service:
    - running
    - name: {{ samba.service }}
    - enable: True
    - require:
      - pkg: samba
    - watch:
      - file: samba
