kafka:
  - version: 2.13-3.1.0
  - partition: 1
  - replication_factor: 1
  - data_path: /home/kafka/data
  - log_dir: /home/kafka/logs/kafka-logs

kafka_servers:
  - 1: 10.190.0.2
  - 2: 10.190.0.3

#kafka_topics:
#  topics:
#    - topic-1
#    - topic-2
#    - topic-3



