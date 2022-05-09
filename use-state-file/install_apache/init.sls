install_apache:
  pkg.installed:
    - pkgs:
      - httpd

download_file_from_master:
  file.managed:
    - name: /var/www/html/index.html
    - user: apache
    - group: apache
    - source: salt://install_apache/template/index.html # salt is the directory where top.sls has been defined

apache_service:
  service.running:
    - name: httpd
    - enabled: True
