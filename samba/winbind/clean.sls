{% from "samba/map.jinja" import samba with context %}

samba_winbind_services_clean:
  service.dead:
    - names:
      {% for service in samba.winbind.services %}
      -  {{ service }}
      {% endfor %}
      - {{ samba.service }}
    - enable: False
  file.absent:
    - name: {{ samba.winbind.pam_winbind.config }}
  pkg.removed:
    - names:
      {% if samba.winbind.libnss %}
      - {{ samba.winbind.libnss }}
      {% endif %}
      {% for pkg in samba.winbind.utils %}
      - {{ pkg }}
      {% endfor %}
      - {{ samba.winbind.server }}
    - require:
      - file: samba_winbind_services_clean
