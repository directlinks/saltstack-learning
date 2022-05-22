{% set version = salt['pillar.get']('version') %}
{% set server_port = salt['pillar.get']('server_port') %}

# download and unpack zookeeper
install_zookeeper:
  cmd.run:
    - names:
      - mkdir -p /opt/zookeeper
      - wget https://archive.apache.org/dist/zookeeper/zookeeper-{{ version }}/apache-zookeeper-{{ version }}-bin.tar.gz
      - mv apache-zookeeper-{{ version }}-bin.tar.gz /opt/zookeeper/
      - tar -zxf /opt/zookeeper/apache-zookeeper-{{ version }}-bin.tar.gz -C /opt/zookeeper
      - ls /opt/zookeeper/apache-zookeeper-{{ version }}-bin
      - mkdir -p /opt/zookeeper/apache-zookeeper-{{ version }}-bin/data
      - rm -rf /opt/zookeeper/apache-zookeeper-{{ version }}-bin.tar.gz

# create zoo.cgf
create_config:
  cmd.run:
    - name: |
       ls
       cat << EOF > /opt/zookeeper/apache-zookeeper-{{ version }}-bin/conf/zoo.cfg
       # The number of milliseconds of each tick
       tickTime= {{ pillar['conf']['ticktime']}}

       # The number of ticks that the initial 
       # synchronization phase can take
       initLimit={{ pillar['conf']['initlimit']}}

       # The number of ticks that can pass between 
       # sending a request and getting an acknowledgement
       syncLimit={{ pillar['conf']['synclimit']}}

       # the directory where the snapshot is stored.
       # do not use /tmp for storage, /tmp here is just 
       # example sakes.
       dataDir={{ pillar['conf']['data_dir']}}

       # the port at which the clients will connect
       clientPort={{ pillar['client_ports']['clientport'] }}
       admin.serverPort=8081

       # the maximum number of client connections.
       # increase this if you need to handle more clients
       maxClientCnxns={{ pillar['conf']['max_client_conn']}}

       4lw.commands.whitelist=*
    
       EOF

#add servers in zoo.cfg
{% set zookeeper_servers_ = salt['pillar.get']('zookeeper_servers') -%}
add_servers:
  cmd.run:
    - names:
{% for i in zookeeper_servers_ %}
  {% for j,k in i.items() %}
      - echo server.{{ j }}={{ k }}:{{ server_port }}:3788 >> /opt/zookeeper/apache-zookeeper-{{ version }}-bin/conf/zoo.cfg
  {%- endfor %}
{%- endfor %}


#add multi node config ids
create_id_file:
  file.managed:
    - name: /opt/zookeeper/apache-zookeeper-{{ version }}-bin/data/myid
    - source: salt://install_zookeeper/files/myid
    - user: root
    - group: root
    - mode: 644
    - template: jinja

# start zookeeper in background mode
run_zoo:
  cmd.run:
    - names:
      - /opt/zookeeper/apache-zookeeper-{{ version }}-bin/bin/zkServer.sh start