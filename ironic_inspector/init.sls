{%- if pillar.ironic_inspector is defined %}
include:
{%- if pillar.ironic_inspector.service is defined %}
- ironic_inspector.service
{%- endif %}
{%- if pillar.ironic_inspector.client is defined %}
- ironic_inspector.client
{%- endif %}
{%- endif %}
