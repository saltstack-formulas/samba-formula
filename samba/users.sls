{% for user, passwd in pillar.get('samba_users', {}).items() %}
smbpasswd-{{ user }}:
  cmd.run:
    - name: '(echo {{ passwd }}; echo {{ passwd }}) | smbpasswd -as {{ user }}'
{% endfor %}
