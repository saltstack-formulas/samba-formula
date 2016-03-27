{% if grains['os_family']=='RedHat' %}
include:
  - samba.client
{% endif %}

{% for login,user in pillar.get('samba_users', {}).items() %}
smbpasswd-{{ login }}:
  cmd.run:
    - name: '(echo {{ user.password }}; echo {{ user.password }}) | smbpasswd -as {{ login }}'
{% endfor %}
