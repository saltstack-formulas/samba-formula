{% from "samba/map.jinja" import samba with context %}

  {% if samba.preinstall.cmd and grains.osmajorrelease in samba.preinstall.osreleases %}
samba_preinstall_cmd:
  cmd.run:
    - name: {{ samba.preinstall.cmd }}
    - require_in:
      - pkg: samba_service_install
  {% endif %}

samba_service_install:
  pkg.installed:
    - name: {{ samba.server }}
  service.running:
    - name: {{ samba.service }}
    - enable: True
    - require:
      - pkg: samba_service_install
