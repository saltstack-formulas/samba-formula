{% from "samba/map.jinja" import samba with context %}

samba_winbind_software:
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
    - mode: 0644
    - require_in:
      - service: samba_winbind_software
  service.enabled:
    - names:
      {% for service in samba.winbind.services %}
      -  {{ service }}
      {% endfor %}
    - require_in:
      - samba_winbind_services

samba_winbind_services:
  service.running:
    - unmask_runtime: true
    - names:
      - {{ samba.service }}
      {% for service in samba.winbind.services %}
      -  {{ service }}
      {% endfor %}

