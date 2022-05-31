# Born2beroot - 42cursus

This project aims to introduce you to the wonderful world of virtualization.
You will create your first machine in VirtualBox under specific instructions.
Then, at the end of this project, you will be able to set up your own operating system while implementing strict rules.

## Table of Contents

6. [Bonus](#bonus)
   - [Installation](#1-installation)
   - [Linux Lighttpd MariaDB PHP _(LLMP)_ Stack](#2-linux-lighttpd-mariadb-php-llmp-stack)
     - [Step 1: Installing Lighttpd](#step-1-installing-lighttpd)
     - [Step 2: Installing & Configuring MariaDB](#step-2-installing--configuring-mariadb)
     - [Step 3: Installing PHP](#step-3-installing-php)
     - [Step 4: Downloading & Configuring WordPress](#step-4-downloading--configuring-wordpress)
     - [Step 5: Configuring Lighttpd](#step-5-configuring-lighttpd)
   - [File Transfer Protocol _(FTP)_](#3-file-transfer-protocol-ftp)
     - [Step 1: Installing & Configuring FTP](#step-1-installing--configuring-ftp)
     - [Step 2: Connecting to Server via FTP](#step-2-connecting-to-server-via-ftp)

## Bonus

### #1: Installation

In this part your partitions are different from the mandatory part, hence you need to install with bonus partitions if you need to do
the bonus part ( watch the bonus installation video mentioned above).

### #2: Linux Lighttpd MariaDB PHP _(LLMP)_ Stack

1. Lighttpd is an open-source web server optimized for speed-critical environments. You will use it as an HTTP server.

2. MariaDB is a community-developed, commercially supported fork of the MySQL relational database management system.

3. PHP is a general-purpose scripting language especially suited to web development. It will be used to maintain our Wordpress website.

#### Step 1: Installing Lighttpd

Install _lighttpd_ via `sudo apt install lighttpd`.

```
$ sudo apt install lighttpd
```

You can verify whether _lighttpd_ was successfully installed via `dpkg -l | grep lighttpd`.

```
$ dpkg -l | grep lighttpd
```

Allow incoming connections using Port 80 via `sudo ufw allow 80`.

```
$ sudo ufw allow 80
```

#### Step 2: Installing & Configuring MariaDB

Install _mariadb-server_ via `sudo apt install mariadb-server`.

```
$ sudo apt install mariadb-server
```

Verify whether _mariadb-server_ was successfully installed via `dpkg -l | grep mariadb-server`.

```
$ dpkg -l | grep mariadb-server
```

Start interactive script to remove insecure default settings via `sudo mysql_secure_installation`.

```
$ sudo mysql_secure_installation
Enter current password for root (enter for none): #Just press Enter (do not confuse database root with system root)
Set root password? [Y/n] n
Remove anonymous users? [Y/n] Y
Disallow root login remotely? [Y/n] Y
Remove test database and access to it? [Y/n] Y
Reload privilege tables now? [Y/n] Y
```

Now you have the MariaDB and we are going to create a database, and a user for our Wordpress server.
Log in to the MariaDB console via `sudo mariadb`.

```
$ sudo mariadb
MariaDB [(none)]>
```

Create new database via `CREATE DATABASE <database-name>;`.

```
MariaDB [(none)]> CREATE DATABASE <database-name>;
```

Create new database user and grant them full privileges on the newly-created database via `GRANT ALL ON <database-name>.* TO '<username-2>'@'localhost' IDENTIFIED BY '<password-2>' WITH GRANT OPTION;`. ()

```
MariaDB [(none)]> GRANT ALL ON <database-name>.* TO '<username-2>'@'localhost' IDENTIFIED BY '<password-2>' WITH GRANT OPTION;
```

Flush the privileges via `FLUSH PRIVILEGES;`.

```
MariaDB [(none)]> FLUSH PRIVILEGES;
```

Exit the MariaDB shell via `exit`.

```
MariaDB [(none)]> exit
```

Verify whether database user was successfully created by logging in to the MariaDB console via `mariadb -u <username-2> -p`.

```
$ mariadb -u <username-2> -p
Enter password: <password-2>
MariaDB [(none)]>
```

Confirm whether database user has access to the database via `SHOW DATABASES;`.

```
MariaDB [(none)]> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| <database-name>    |
| information_schema |
+--------------------+
```

Exit the MariaDB shell via `exit`.

```
MariaDB [(none)]> exit
```

#### Step 3: Installing PHP

Install _php-cgi_ & _php-mysql_ via `sudo apt install php-cgi php-mysql`.

```
$ sudo apt install php-cgi php-mysql
```

Verify whether _php-cgi_ & _php-mysql_ was successfully installed via `dpkg -l | grep php`.

```
$ dpkg -l | grep php
```

#### Step 4: Downloading & Configuring WordPress

In order to retrieve content from web servers we need to install wget.
Install _wget_ via `sudo apt install wget`.

```
$ sudo apt install wget
```

Download WordPress to `/var/www/html` via `sudo wget http://wordpress.org/latest.tar.gz -P /var/www/html`.

```
$ sudo wget http://wordpress.org/latest.tar.gz -P /var/www/html
```

Extract downloaded content via `sudo tar -xzvf /var/www/html/latest.tar.gz`.

```
$ sudo tar -xzvf /var/www/html/latest.tar.gz
```

After you extract the wordpress files you no more need the latest.tar.gz file.
Remove tarball via `sudo rm /var/www/html/latest.tar.gz`.

```
$ sudo rm /var/www/html/latest.tar.gz
```

Copy content of `/var/www/html/wordpress` to `/var/www/html` via `sudo cp -r /var/www/html/wordpress/* /var/www/html`.

```
$ sudo cp -r /var/www/html/wordpress/* /var/www/html
```

Remove `/var/www/html/wordpress` via `sudo rm -rf /var/www/html/wordpress`

```
$ sudo rm -rf /var/www/html/wordpress
```

Create WordPress configuration file from its sample via `sudo cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php`.

```
$ sudo cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
```

Configure WordPress to reference previously-created MariaDB database & user via `sudo vi /var/www/html/wp-config.php`.

```
$ sudo vi /var/www/html/wp-config.php
```

Replace the below

      ```
      23 define( 'DB_NAME', 'database_name_here' );^M
      26 define( 'DB_USER', 'username_here' );^M
      29 define( 'DB_PASSWORD', 'password_here' );^M
      ```

      with:

      ```
      23 define( 'DB_NAME', '<database-name>' );^M
      26 define( 'DB_USER', '<username-2>' );^M
      29 define( 'DB_PASSWORD', '<password-2>' );^M
      ```

#### Step 5: Configuring Lighttpd

Enable below modules via `sudo lighty-enable-mod fastcgi; sudo lighty-enable-mod fastcgi-php; sudo service lighttpd force-reload`.

```
$ sudo lighty-enable-mod fastcgi
$ sudo lighty-enable-mod fastcgi-php
$ sudo service lighttpd force-reload
```

### #3: File Transfer Protocol _(FTP)_

#### Step 1: Installing & Configuring FTP

Install FTP via `sudo apt install vsftpd`.

```
$ sudo apt install vsftpd
```

Verify whether _vsftpd_ was successfully installed via `dpkg -l | grep vsftpd`.

```
$ dpkg -l | grep vsftpd
```

Allow incoming connections using Port 21 via `sudo ufw allow 21`.

```
$ sudo ufw allow 21
```

Configure _vsftpd_ via `sudo vi /etc/vsftpd.conf`.

```
$ sudo vi /etc/vsftpd.conf
```

To enable any form of FTP write command, uncomment below line:

```
31 #write_enable=YES
```

To prevent user from accessing files or using commands outside the directory tree, uncomment below line:

```
114 #chroot_local_user=YES
```

To set root folder for FTP-connected user to `/home/<username>/ftp`, add below lines:

```
$ sudo mkdir /home/<username>/ftp
$ sudo mkdir /home/<username>/ftp/files
$ sudo chown nobody:nogroup /home/<username>/ftp
$ sudo chmod a-w /home/<username>/ftp
<~~~>
user_sub_token=$USER
local_root=/home/$USER/ftp
<~~~>
```

To whitelist FTP, add below lines:

```
$ sudo vi /etc/vsftpd.userlist
$ echo <username> | sudo tee -a /etc/vsftpd.userlist
<~~~>
userlist_enable=YES
userlist_file=/etc/vsftpd.userlist
userlist_deny=NO
<~~~>
```

#### Step 2: Connecting to Server via FTP

FTP into your virtual machine via `ftp <ip-address>`.

```
$ ftp <ip-address>
```

Terminate FTP session at any time via `CTRL + D`.
