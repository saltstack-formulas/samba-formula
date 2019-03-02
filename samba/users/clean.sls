
{% if grains['os_family'] in ('RedHat', 'Suse', 'Debian') %}
include:
  - samba.client.clean
{% endif %}

{% for login,user in salt['pillar.get']('samba:users', {}).items() %}
samba_{{ login }}_clean:
  user.absent:
    - name: {{ login }}
{% endfor %}
