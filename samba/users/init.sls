{% if grains['os_family'] in ('RedHat', 'Suse', 'Debian') %}
include:
  - samba.client
{% endif %}

{% for login,user in salt['pillar.get']('samba:users', {}).items() %}
samba_{{ login }}:
  user.present:
    - name: {{ login }}
    - fullname: {{ login }}
    - password: {{ user.password }}

samba_smbpasswd_{{ login }}:
  cmd.run:
    - name: "(echo '{{ user.password }}'; echo '{{ user.password }}') | smbpasswd -as {{ login }}"
{% endfor %}
