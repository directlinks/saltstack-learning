{% set broker_id_ = salt['pillar.get']('kafka_servers') %}
{% print(broker_id_[0].1) %}
{% print(broker_id_[1].2) %}

{% set count = 1 %}
{% for i in broker_id_ %}
    {% for j,k in i.items() %}
        {% if salt['cmd.shell']('hostname -i') == k and count == j %}
          {% set broker_id = count %}
          {% set count = count+1 %}
          {% print(broker_id) %}
        {% else %}
          pass
        {% endif %}
    {% endfor %}
{% endfor %}

{% print(broker_id) %}

