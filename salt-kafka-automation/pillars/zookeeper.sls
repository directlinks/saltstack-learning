zookeeper:
  servers:
    - localhost
    - localhost
    - localhost
  server_ports:
    - port1: 2788
    - port2: 3788
    - port3: 4788
  client_ports:
    - clientport1: 2181
    - clientport2: 2182
    - clientport3: 2183
  conf:
    - ticktime: 2000
    - initlimit: 10
    - synclimit: 5
    - data_dir: /home/kafka/apache-zookeeper-3.8.0-bin/data
    - max_client_conn: 60 
  version: 3.8.0

