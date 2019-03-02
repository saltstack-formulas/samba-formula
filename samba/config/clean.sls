{% from "samba/map.jinja" import samba with context %}

samba_config_clean:
  file.absent:
    - name: {{ samba.config }}
