{%- set zookeeper_servers_ = salt['pillar.get']('zookeeper_servers')%}
{% print(zookeeper_servers_[0].1) %}
{% print(zookeeper_servers_[1].2) %}


{% set id = [] %}
{% for i in zookeeper_servers_ %}
  {% for j,k in i.items() %}
    {% if salt['cmd.shell']('hostname -i') == k %}
      {% set temp = id.append(j) %}
    {% else %}
      {% print('pass') %}
    {% endif %}
  {% endfor %}
{% endfor %}

{% print(id[0]) %}