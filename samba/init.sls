samba:
  pkg:
    - installed
  file:
    - managed
    - name: /etc/samba/smb.conf
    - source: salt://samba/files/smb.conf
  service:
    - running
    - name: smbd
    - enable: True
    - require:
      - pkg: samba
    - watch:
      - file: samba
