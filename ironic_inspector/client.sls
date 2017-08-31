{%- from "ironic_inspector/map.jinja" import ironic_inspector with context %}
{%- if ironic_inspector.client.enabled %}

ironic_inspector_client_pkg:
  pkg.installed:
    - names: {{ ironic_inspector.client_pkgs }}
    - install_recommends: False

{%- endif %} # end if client.enabled
