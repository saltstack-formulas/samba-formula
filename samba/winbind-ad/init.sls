{% from "samba/map.jinja" import samba with context %}

include:
  - samba.winbind

  {% if grains.os_family in ('Debian',) %}

samba_winbind_pam_mkhomedir:
  file.managed:
    - name: {{ samba.winbind.pam_mkhomedir }}
    - source: {{ samba.winbind.pam_mkhomedir_src }}
    - template: jinja
    - create: True
    
    {% for pam_config in ['winbind', 'mkhomedir',] %}
samba_winbind_pamforget_{{ pam_config }}:
  file.line:
    - name: {{ samba.winbind.pam_seen }}
    - match: {{ pam_config }}
    - mode: delete
    - require:
      - file: samba_winbind_pam_mkhomedir
    - require_in:
      - cmd: samba_winbind_ad_authconfig
    {% endfor %}
{% endif %}

  {% if grains.os_family in ('Debian', 'Suse',) %}
    {% for config in samba.winbind.nsswitch.regex %}

samba_winbind_nsswitch_{{ config[0] }}:
  file.replace:
    - name: /etc/nsswitch.conf
    - pattern: {{ config[1] }}
    - repl: {{ config[2] }}
    - backup: '.salt.bak'
    - require_in:
      - cmd: samba_winbind_ad_authconfig

    {% endfor %}
  {% endif %}

  {% if samba.winbind.usermap %}
samba_winbind_ad_usermap:
  file.managed:
    - name: {{ samba.winbind.usermap }}
    - source: {{ samba.winbind.usermap_src }}
    - mode: 755
    - create: True
    - template: jinja
    - context:
      workgroup: {{ samba.conf.sections.global.workgroup }}
  {% endif %}    

  {% if grains.os_family in ('RedHat', 'Debian', 'Suse',) %}
samba_winbind_ad_authconfig:
  cmd.run:
    - name: {{ samba.winbind.pam_authconfig }}
    - onlyif: test -f {{ samba.winbind.pam_authconfig_cmd }}
    - watch_in:
      - service: samba_winbind_service
  {% endif %}
