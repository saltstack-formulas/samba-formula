{% from "samba/map.jinja" import samba with context %}

{% if grains.os not in ('MacOS', 'Windows',) %}

  {% if samba.preinstall.cmd %}
    {% if grains.osmajorrelease in samba.preinstall.osreleases %}

samba_preinstall_cmd:
  cmd.run:
    - name: {{ samba.preinstall.cmd }}
    - require_in: pkg.samba

    {% endif %}
  {% endif %}

samba:
  pkg.installed:
    - name: {{ samba.server }}
  service.running:
    - name: {{ samba.service }}
    - enable: True
    - require:
      - pkg: samba

{% endif %}
