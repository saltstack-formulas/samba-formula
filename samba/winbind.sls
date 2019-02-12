{% from "samba/map.jinja" import samba with context %}

samba_winbind_software:
  pkg.installed:
    - name: {{ samba.winbind.server }}
    - refresh: True
    - require_in:
      - pkg: samba_winbind_services

samba_winbind_services:
  pkg.installed:
    - names:
      - {{ samba.winbind.server }}
      {% if samba.winbind.libnss %}
      - {{ samba.winbind.libnss }}
      {% endif %}
      {% for pkg in samba.winbind.utils %}
      - {{ pkg }}
      {% endfor %}
    - require_in:
      - file: samba_winbind_software
  file.managed:
    - name: {{ samba.winbind.pam_winbind.config }}
    - source: {{ samba.winbind.pam_winbind.config_src }}
    - template: jinja
    - user: root
    - group: {{ samba.get('root_group', 'root') }}
    - mode: '0644'
    - require_in:
      - service: samba_winbind_software
  service.running:
    - unmask_runtime: true
    - names:
      {% for service in samba.winbind.services %}
      -  {{ service }}
      {% endfor %}
      - {{ samba.service }}
    - enable: True
