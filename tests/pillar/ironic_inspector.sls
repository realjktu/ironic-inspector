ironic_inspector:
    service:
      enabled: true
    tftp_root: /tmp/tftp
    database:
      engine: mysql
      host: 127.0.0.1
      port: 3306
      name:
        main_database: ironic-inspector
      user: ironic-inspector
      password: passw0rd
    identity:
      engine: keystone
      host: 127.0.0.1
      port: 35357
      tenant: service
      user: ironic-inspector
      password: passw0rd
      auth_type: password
      project_domain_id: default
      protocol: http
      region: RegionOne
      user_domain_id: default
    api_url: http://192.168.100.10:5050
    dhcp_pool: 192.168.100.100,192.168.100.200
ironic:
  api:
    api_type: public
    bind:
      address: 127.0.0.1
      port: 6385
      protocol: http
    database:
      engine: mysql
      host: 127.0.0.1
      name: ironic
      password: passw0rd
      port: 3306
      user: ironic
    enabled: True
    identity:
      auth_type: password
      engine: keystone
      host: 127.0.0.1
      password: workshop
      port: 35357
      project_domain_id: default
      protocol: http
      region: RegionOne
      tenant: service
      user: ironic
      user_domain_id: default
    message_queue:
      engine: rabbitmq
      host: 127.0.0.1
      password: workshop
      port: 5672
      user: openstack
      virtual_host: /openstack
    version: ocata
  client:
    enabled: True
mysql:
  client:
    enabled: true
    version: '5.7'
    admin:
      host: localhost
      port: 3306
      user: admin
      password: password
      encoding: utf8
  server:
    enabled: true
    version: "5.7"
    force_encoding: utf8
    bind:
      address: 0.0.0.0
      port: 3306
      protocol: tcp
    database:
      ironic-inspector:
        encoding: utf8
        users:
        - host: '%'
          name: ironic-inspector 
          password: passw0rd
          rights: all
        - host: 127.0.0.1
          name: ironic-inspector
          password: passw0rd
          rights: all
      ironic:
        encoding: utf8
        users:
        - host: '%'
          name: ironic
          password: passw0rd
          rights: all
        - host: 127.0.0.1
          name: ironic
          password: passw0rd
          rights: all

