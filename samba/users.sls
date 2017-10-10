{% if grains['os_family'] in ('RedHat', 'Suse', 'Debian') %}
include:
  - samba.client
{% endif %}

{% for login,user in salt['pillar.get']('samba:users', {}).items() %}
{{ login }}:
  user.present:
    - fullname: {{ login }}
    - password: {{ user.password }}

smbpasswd-{{ login }}:
  cmd.run:
    - name: '(echo {{ user.password }}; echo {{ user.password }}) | smbpasswd -as {{ login }}'
{% endfor %}
