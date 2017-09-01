{%- from "ironic_inspector/map.jinja" import ironic_inspector with context %}
{%- if ironic_inspector.service.enabled %}

inspector_pkgs:
  pkg.installed:
    - names: {{ ironic_inspector.pkgs }}

/etc/ironic-inspector/inspector.conf:
  file.managed:
    - source: salt://ironic_inspector/files/ocata/inspector.conf
    - template: jinja
    - require:
      - pkg: inspector_pkgs

/etc/ironic-inspector/rootwrap.conf:
  file.managed:
    - source: salt://ironic_inspector/files/ocata/rootwrap.conf
    - template: jinja
    - require:
      - pkg: inspector_pkgs

/etc/ironic-inspector/rootwrap.d/ironic-inspector-firewall.filters:
  file.managed:
    - source: salt://ironic_inspector/files/ocata/ironic-inspector-firewall.filters
    - template: jinja
    - require:
      - pkg: inspector_pkgs

/etc/sudoers.d/ironic-inspector-rootwrap:
  file.managed:
    - source: salt://ironic_inspector/files/ocata/ironic-inspector-rootwrap
    - template: jinja
    - require:
      - pkg: inspector_pkgs

ironic_inspector_install_database:
  cmd.run:
    - names:
      - ironic-inspector-dbsync --config-file /etc/ironic-inspector/inspector.conf upgrade
    {%- if grains.get('noservices') %}
    - onlyif: /bin/false
    {%- endif %}
    - require:
      - file: /etc/ironic-inspector/inspector.conf

ironic-inspector:
  service.running:
    - enable: true
    - full_restart: true
    {%- if grains.get('noservices') %}
    - onlyif: /bin/false
    {%- endif %}
    - watch:
      - file: /etc/ironic-inspector/inspector.conf

ironic_inspector_dirs:
  file.directory:
    - names:
      - {{ ironic_inspector.tftp_root }}/pxelinux.cfg
      makedirs: True
      user: 'ironic'
      group: 'ironic'
    - require:
      - pkg: inspector_pkgs

{{ ironic_inspector.tftp_root }}/ironic-agent.kernel:
  file.managed:
    - source: http://tarballs.openstack.org/ironic-python-agent/tinyipa/files/tinyipa-stable-ocata.vmlinuz
    - skip_verify: true
    - template: jinja
    - require:
      - pkg: inspector_pkgs

{{ ironic_inspector.tftp_root }}/ironic-agent.initramfs:
  file.managed:
    - source: http://tarballs.openstack.org/ironic-python-agent/tinyipa/files/tinyipa-stable-ocata.gz
    - skip_verify: true
    - template: jinja
    - require:
      - pkg: inspector_pkgs

/etc/dnsmasq.d/ironic-inspector:
  file.managed:
    - source: salt://ironic_inspector/files/ocata/dnsmasq_ironic_inspector
    - template: jinja
    - require:
      - pkg: inspector_pkgs

dnsmasq:
  service.running:
    - enable: true
    - full_restart: true
    {%- if grains.get('noservices') %}
    - onlyif: /bin/false
    {%- endif %}
    - watch:
      - file: /etc/dnsmasq.d/ironic-inspector

{{ ironic_inspector.tftp_root }}/pxelinux.cfg/default:
  file.managed:
    - source: salt://ironic_inspector/files/ocata/pxelinux.cfg_default
    - template: jinja
    - require:
      - pkg: inspector_pkgs

{%- endif %}

