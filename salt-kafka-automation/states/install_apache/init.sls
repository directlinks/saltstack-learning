install_apache:
  pkg.installed:
    - pkgs:
      - apache2

download_file_from_master:
  file.managed:
    - name: /var/www/html/index.html
    - user: www-data
    - group: www-data
    - source: salt://install_apache/template/index.html # salt is the directory where top.sls has been defined

apache_service:
  service.running:
    - name: apache2
    - enable: True
