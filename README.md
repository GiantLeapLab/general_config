general_config
==============

General configuration to simplify the local web development using Apache 2.+

Installation
===================
1. Add ```Include `<your path with config>/mysite_universal.conf` ``` in Apache config file
2. Copy `vhost_add.sh` in your bin path 

Preparing and Using
===================

For example for user **wellic**:

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

or 

sudo vim vhost_add.sh
and add
127.1.0.1 my.domain.com.loc
```

* load or create files in your project directory:
  * vim index.html
  * etc.

* type in browser http://my.domain.com.loc/ or http://localhost/my.domain.com/

Customization
=============

Replace in the file `mysite_universal.conf` text `/home/wellic/sites/var` on your path.

