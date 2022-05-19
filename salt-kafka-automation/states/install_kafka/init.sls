
# install java for centos
#include:
#  - java

# create a group for kafka
create_kafka_group:
  group.present:
    - name: kafka
    - gid: 4000
    - system: True

# create a user for kafka
create_kafka_user:
  user.present:
    - name: kafka
    - home: /home/kafka
    - shell: /bin/bash
    - uid: 4000
    - gid: 4000
    - groups:
      - kafka

# download and unpack kafka
install_kafka:
  cmd.run:
    - names:
      - cd /home/kafka
      - wget http://apache.osuosl.org/kafka/3.1.0/kafka_2.13-3.1.0.tgz
      - tar -xvzf kafka_2.13-3.1.0.tgz
      - ls
      - pwd
      - cp -r kafka_2.13-3.1.0/* /home/kafka/
      - rm -rf ./kafka_2.13-3.1.0

# create a server.properties file
create_server_file:
  file.managed:
    - name: /home/kafka/config/server.properties
    - source: salt://install_kafka/files/server.properties
    - user: kafka
    - group: kafka
    - mode: 644
    - template: jinja
      

# run kafka
run_kafka:
  cmd.run:
    - names:
      - /home/kafka/bin/kafka-server-start.sh -daemon /home/kafka/config/server.properties

# create topic
create_topic:
  cmd.run:
    - names:
      - /home/kafka/bin/kafka-topics.sh --bootstrap-server $(hostname -i):9092 --create --topic topic-$(hostname) --partitions 1 --replication-factor 1

# list topics
list_topic:
  cmd.run:
    - names:
      - /home/kafka/bin/kafka-topics.sh --bootstrap-server $(hostname -i):9092 --list
  


