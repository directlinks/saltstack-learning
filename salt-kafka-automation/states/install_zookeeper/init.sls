# download and unpack zookeeper
install_zookeeper:
  cmd.run:
    - names:
      - mkdir -p /opt/zookeeper
      - wget https://archive.apache.org/dist/zookeeper/zookeeper-3.8.0/apache-zookeeper-3.8.0-bin.tar.gz
      - mv apache-zookeeper-3.8.0-bin.tar.gz /opt/zookeeper/
      - tar -zxf /opt/zookeeper/apache-zookeeper-3.8.0-bin.tar.gz -C /opt/zookeeper
      - ls /opt/zookeeper/apache-zookeeper-3.8.0-bin
      - mkdir -p /opt/zookeeper/apache-zookeeper-3.8.0-bin/data
      - rm -rf /opt/zookeeper/apache-zookeeper-3.8.0-bin.tar.gz

# create zoo.cgf
create_config:
  cmd.run:
    - name: |
       ls
       cat << EOF > /opt/zookeeper/apache-zookeeper-3.8.0-bin/conf/zoo.cfg
       # The number of milliseconds of each tick
       tickTime=2000

       # The number of ticks that the initial 
       # synchronization phase can take
       initLimit=10

       # The number of ticks that can pass between 
       # sending a request and getting an acknowledgement
       syncLimit=5

       # the directory where the snapshot is stored.
       # do not use /tmp for storage, /tmp here is just 
       # example sakes.
       dataDir=/opt/zookeeper/apache-zookeeper-3.8.0-bin/data

       # the port at which the clients will connect
       clientPort=2181
       admin.serverPort=8081

       # the maximum number of client connections.
       # increase this if you need to handle more clients
       maxClientCnxns=60

       4lw.commands.whitelist=*
       
       server.1=10.190.0.2:2788:3788
       server.2=10.190.0.3:2788:3788
       server.3=localhost:2988:3988
       EOF

#add multi node config ids
create_id_file:
  file.managed:
    - name: /opt/zookeeper/apache-zookeeper-3.8.0-bin/data/myid
    - source: salt://install_zookeeper/files/myid
    - user: root
    - group: root
    - mode: 644
    - template: jinja

# start zookeeper in background mode
run_zoo:
  cmd.run:
    - names:
      - /opt/zookeeper/apache-zookeeper-3.8.0-bin/bin/zkServer.sh start