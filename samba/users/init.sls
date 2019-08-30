{% if grains['os_family'] in ('RedHat', 'Suse', 'Debian') %}
include:
  - samba.client
{% endif %}

{% for login,user in salt['pillar.get']('samba:users', {}).items() %}
{{ login }}:
  user.present:
    - name: {{ login }}
    - fullname: {{ login }}
    - password: {{ user.password.passwd }}
  pdbedit.managed:
    - login: {{ login }}
    - password: {{ user.password.nt }}
    - password_hashed: True
{% endfor %}
