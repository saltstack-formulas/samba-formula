{% from "samba/map.jinja" import samba with context %}

## Note: If pkg.installed fails try removing `libnss` and `libpam` first.
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
      - file: samba_winbind_services
  file.managed:
    - name: {{ samba.winbind.pam_winbind.config }}
    - source: {{ samba.winbind.pam_winbind.config_src }}
    - template: jinja
    - user: root
    - group: {{ samba.get('root_group', 'root') }}
    - mode: '0644'
    - require_in:
      - service: samba_winbind_services
  service.running:
    ### This state will fail if we have'nt joined the domain yet. Thats okay!
    - unmask_runtime: true
    - names:
      {% for service in samba.winbind.services %}
      -  {{ service }}
      {% endfor %}
      - {{ samba.service }}
    - enable: True
