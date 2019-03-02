{% from "samba/map.jinja" import samba with context %}

  {% if grains.os_family in ('Debian',) %}
samba_winbind_pam_mkhomedir_clean:
  file.absent:
    - name: {{ samba.winbind.pam_mkhomedir }}
    
      {% for pam_config in ['winbind', 'mkhomedir',] %}
samba_winbind_pamforget_{{ pam_config }}_clean:
  file.line:
    - name: {{ samba.winbind.pam_seen }}
    - match: {{ pam_config }}
    - mode: delete
    - onlyif: test -f {{ samba.winbind.pam_seen }}
      {% endfor %}
  {% endif %}

samba_winbind_nsswitch_usermap_clean:
  cmd.run:
    - name: cp /etc/nsswitch.conf.salt.bak /etc/nsswitch.conf
    - onlyif:
      - test -f /etc/nsswitch.conf.salt.bak
      - {{ grains.os_family in ('Debian', 'Suse',) }}
  file.absent:
    - name: {{ samba.winbind.usermap }}
    - onlyif: {{ samba.winbind.usermap }}
