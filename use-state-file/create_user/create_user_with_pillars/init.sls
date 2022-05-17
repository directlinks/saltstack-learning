{% for user, data in pillar.get('user_data',{}).items() %}
{{ user }}
  user.present
  - name: data['fullname']
  - shell: /bin/bash
  - uid: data['uid']
  - gid_from_name: data['gid_from_name']
  - groups: data['groups']
  - home: data['home']
{% endfor %}
