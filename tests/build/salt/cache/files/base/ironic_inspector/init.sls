{%- from "ironic_inspector/map.jinja" import ironic_inspector with context %}
{%- if ironic_inspector.enabled %}

inspector_pkgs:
  pkg.installed:
    - names: {{ ironic_inspector.pkgs }}


/etc/ironic-inspector/inspector.conf:
  file.managed:
  - source: salt://ironic_inspector/files/ocata/inspector.conf
  - template: jinja
  - require:
    - pkg: inspector_pkgs

{{ ironic_inspector.tftp_root }}/pxelinux.cfg/default:
  file.managed:
  - source: salt://ironic_inspector/files/ocata/pxelinux.cfg_default
  - template: jinja
  - require:
    - pkg: inspector_pkgs


{%- endif %}
