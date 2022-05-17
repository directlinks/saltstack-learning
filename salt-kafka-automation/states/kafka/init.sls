# set variables from pillar
{% set kafka_vars = salt['pillar.get']('kafka') %}
{% set kafka_version = kafka_vars%}
{% set partition = salt['pillar.get'](partition %}
  - partition:1
  - replication_factor: 1
  - data_path: /kafka/data

kafka_topics:
  topics:
    - topic-1
    - topic-2
    - topic-3


# Make server file for kafka

#  
