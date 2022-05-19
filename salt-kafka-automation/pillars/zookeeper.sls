zookeeper_servers:
  - 1: 10.190.0.2
  - 2: 10.190.0.3

server_ports:
  - port: 2788

client_ports:
  - clientport: 2181

conf:
  - ticktime: 2000
  - initlimit: 10
  - synclimit: 5
  - data_dir: /opt/zookeeper/apache-zookeeper-3.8.0-bin/data
  - max_client_conn: 60 

version: 3.8.0

