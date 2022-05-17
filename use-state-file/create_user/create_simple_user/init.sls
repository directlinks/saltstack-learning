create_users:
  user.present
    - name: rishabhtest
    - home: /home/rishabhtest
    - shell: /bin/bash
    - uid: 4000
    - gid_from_name: True
    - groups:
      - wheel

