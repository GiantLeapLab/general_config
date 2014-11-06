general_config
==============

General configuration to simplify the local web development 

Preparing an Using
------------------

Foexample for user **wellic**:

* create developers catalog: /home/wellic/sites/var 
 ```bash
mkdir -p /home/wellic/sites/var
```

* add log and www directories:
  * /home/wellic/sites/var/log
  ```bash
mkdir -p /home/wellic/sites/var/log
```
  * /home/wellic/sites/var/www
  ```bash
mkdir -p /home/wellic/sites/var/www
```

* add project catalog `my.domain.com`:
  ```bash
mkdir -p /home/wellic/sites/var/my.domain.com
```
* add local domen to /etc/hosts:
  ```bash
cd /home/wellic/sites/var/my.domain.com
vhost_add.sh
```

* load or create files in your project directory:
  * vim index.html
  * etc.

* type in browser http://my.domain.com/ 


