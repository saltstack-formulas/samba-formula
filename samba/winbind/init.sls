{% from "samba/map.jinja" import samba with context %}

samba_winbind_service:
  pkg.installed:
    - names:
      - {{ samba.winbind.server }}
        {%- if "utils" in samba.winbind and samba.winbind.utils %}
            {%- for pkg in samba.winbind.utils %}
      - {{ pkg }}
            {%- endfor %}
        {%- endif %}
        {% if "libnss" in samba.winbind and samba.winbind.libnss %}
      - {{ samba.winbind.libnss }}
        {%- endif %}
  file.managed:
    - name: {{ samba.winbind.pam_winbind.config }}
    - source: {{ samba.winbind.pam_winbind.config_src }}
    - template: jinja
    - user: root
    - group: {{ samba.get('root_group', 'root') }}
    - mode: '0644'
    - onlyif: test -f {{ samba.winbind.pam_winbind.config }}
  service.running:
    ### This state will fail if we have'nt joined the domain yet. Thats okay!
    - unmask_runtime: true
    - names:
      - {{ samba.service }}
        {% for service in samba.winbind.services %}
      - {{ service }}
        {% endfor %}
    - enable: True
