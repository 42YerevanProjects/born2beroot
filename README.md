# Born2beroot - 42cursus

This project aims to introduce you to the wonderful world of virtualization.
You will create your first machine in VirtualBox under specific instructions.
Then, at the end of this project, you will be able to set up your own operating system while implementing strict rules.

## Table of Contents

1. [Installation](#installation)
2. [_sudo_](#sudo)
   - [Step 1: Installing _sudo_](#step-1-installing-sudo)
   - [Step 2: Adding User to _sudo_ Group](#step-2-adding-user-to-sudo-group)
   - [Step 3: Running _root_-Privileged Commands](#step-3-running-root-privileged-commands)
   - [Step 4: Configuring _sudo_](#step-4-configuring-sudo)
3. [SSH](#ssh)
   - [Step 1: Installing & Configuring SSH](#step-1-installing--configuring-ssh)
   - [Step 2: Installing & Configuring UFW](#step-2-installing--configuring-ufw)
   - [Step 3: Connecting to Server via SSH](#step-3-connecting-to-server-via-ssh)
4. [User Management](#user-management)
   - [Step 1: Setting Up a Strong Password Policy](#step-1-setting-up-a-strong-password-policy)
     - [Password Age](#password-age)
     - [Password Strength](#password-strength)
   - [Step 2: Creating a New User](#step-2-creating-a-new-user)
   - [Step 3: Creating a New Group](#step-3-creating-a-new-group)
5. [_cron_](#cron)
   - [Setting Up a _cron_ Job](#setting-up-a-cron-job)
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

## Installation

You must choose as an operating system either the latest stable version of Debian, or the latest stable version of CentOS. Debian is highly recommended if you are new to system administration.

I created the server using the Debian operating system. At the time of writing, the latest stable version of Debian is _Debian 10 Buster_ which can be downloaded from [here](https://www.debian.org).
You can find the _bonus_ installation walkthrough _(no audio)_ [here](https://youtu.be/2w-2MX5QrQw).

## _sudo_

### Step 1: Installing Sudo

Switch to _root_ and its environment by the help of following command.

```
$ su -
Password:
#
```

Next install _sudo_ by typing the following command.

```
# apt install sudo
```

Verify whether _sudo_ was successfully installed via `dpkg -l | grep sudo`.

```
# dpkg -l | grep sudo
```

### Step 2: Adding User to _sudo_ Group

Add user to _sudo_ group via `adduser <username> sudo`.

```
# adduser <username> sudo
```

> Alternatively, you can add user to _sudo_ group via `usermod -aG sudo <username>`.
>
> ```
> # usermod -aG sudo <username>
> ```
>
> Verify whether user was successfully added to _sudo_ group via `getent group sudo`.

```
$ getent group sudo
```

You should `reboot` the system for changes to take effect, then log in and verify _sudopowers_ via `sudo -v`.

### Step 3: Running _root_-Privileged Commands

From here on out, you can run _root_-privileged commands via prefix `sudo`. For instance:

```
$ sudo apt update
```

### Step 4: Configuring _sudo_

In order to configure sudo you need to create a sudo conig file in sudoers.d directory. Create a sudo config file via `sudo vi /etc/sudoers.d/<filename>`. `<filename>` shall not end in `~` or contain `.`.

```
$ sudo vi /etc/sudoers.d/<filename>
```

We need to add some lines to the sudo config file in order to have the sudo policy required by the project. You need to

      1.  Limit authentication using _sudo_ to 3 attempts _(defaults to 3 anyway)_ in the event of an incorrect password

      2.  Add a custom error message in the event of an incorrect password

      3.  Log all _sudo_ commands to `/var/log/sudo/<filename>`: (firstly you need to create /var/log/sudo directory via `sudo mkdir /var/log/sudo`)

      4.  Require _TTY_

      5.  Set _sudo_ paths to `/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin`

At the end your sudo config file should have the following content:

```
Defaults        passwd_tries=3
Defaults        badpass_message="<custom-error-message>"
Defaults        logfile="/var/log/sudo/<filename>"
Defaults        requiretty
Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"

```

## SSH

### Step 1: Installing & Configuring SSH

In order to be able to use the ssh connection you have to install _openssh-server_.

Install _openssh-server_ via `sudo apt install openssh-server`.

```
$ sudo apt install openssh-server
```

ou can verify whether _openssh-server_ was successfully installed via `dpkg -l | grep ssh`.

```
$ dpkg -l | grep ssh
```

In order to change the shh port and restrict root access wyou need to change the sshd_config file.
Open the SSH configuration file via `sudo vi /etc/ssh/sshd_config`.

```
$ sudo vi /etc/ssh/sshd_config
```

To set up SSH using Port 4242, replace below line:

      ```
      13 #Port 22
      ```

      with:

      ```
      13 Port 4242
      ```

To disable SSH login as _root_ irregardless of authentication mechanism, replace below line

      ```
      32 #PermitRootLogin prohibit-password
      ```

      with:

      ```
      32 PermitRootLogin no
      ```

Check SSH status via `sudo service ssh status`.

```
$ sudo service ssh status
```

> Alternatively, check SSH status via `systemctl status ssh`.
>
> ```
> $ systemctl status ssh
> ```

### Step 2: Installing & Configuring UFW

UFW stands for Uncomplicated Firewall, whuch is a program for managing a netfilter firewall and designed to be easy to use. You need to install and enable it.
Install _ufw_ via `sudo apt install ufw`.

```
$ sudo apt install ufw
```

You can verify whether _ufw_ was successfully installed via `dpkg -l | grep ufw`.

```
$ dpkg -l | grep ufw
```

Enable Firewall via `sudo ufw enable`.

```
$ sudo ufw enable
```

In order to be able to connect to the server via ssh our firewall need to allow the port we set up for ssh.
Allow incoming connections using Port 4242 via `sudo ufw allow 4242`.

```
$ sudo ufw allow 4242
```

Check UFW status via `sudo ufw status`.

```
$ sudo ufw status
```

### Step 3: Connecting to Server via SSH

Now you can use another device ( for example your host machine) to connect to our Debian server.
In order to ssh to your server you need you machines username and ip address (tHe command `hostname -I` will give you the ip address).You can SSH into your virtual machine using Port 4242 by openning a terminal and typing the following command:

```
$ ssh <username>@<ip-address> -p 4242
```

Terminate SSH session at any time via `logout`.

```
$ logout
```

> Alternatively, terminate SSH session via `exit`.
>
> ```
> $ exit
> ```

## User Management

### Step 1: Setting Up a Strong Password Policy

#### Password expiration and warning age

You need to:

      1. Set password to expire every 30 days

      2. Set minimum number of days between password changes to 2 days

      3. Send user a warning message 7 days _(defaults to 7 anyway)_ before password expiry

To do so, go ahead and open the login.defs file in text editor via `sudo vi /etc/login.defs`

Replace below lines

      ```
      160 PASS_MAX_DAYS   99999
      161 PASS_MIN_DAYS   0
      162 PASS_WARN_AGE   7
      ```

      with:

      ```
      160 PASS_MAX_DAYS   30
      161 PASS_MIN_DAYS   2
      162 PASS_WARN_AGE   7
      ```

#### Password Strength

Secondly, to set up policies in relation to password strength, install the _libpam-pwquality_ package.

```
$ sudo apt install libpam-pwquality
```

To strengthen the password policy you need to add some lines i the common-password file in pam.d directory.
Go ahead and open the /etc/pam.d/common-password file in text editor via `sudo vi /etc/pam.d/common-password` and navigate to line 25

You need to

      1. Set password minimum length to 10 characters (add `minlen=10`)
      2. Require password to contain at least an uppercase character and a numeric character (add `ucredit=-1 dcredit=-1`)
      3. Set a maximum of 3 consecutive identical characters (add `maxrepeat=3`)
      4. Reject the password if it contains `<username>` in some form (add `reject_username`)
      5. Set the number of changes required in the new password from the old password to 7 (add `difok=7`)
      6. Implement the same policy on _root_ (add `enforce_for_root`)

Finally, it should look like the below:

```
password        requisite                       pam_pwquality.so retry=3 minlen=10 ucredit=-1 dcredit=-1 maxrepeat=3 reject_username difok=7 enforce_for_root
```

### Step 2: Creating a New User

Create new user via `sudo adduser <username>`.

```
$ sudo adduser <username>
```

Verify whether user was successfully created via `getent passwd <username>`.

```
$ getent passwd <username>
```

Verify newly-created user's password expiry information via `sudo chage -l <username>`.

```
$ sudo chage -l <username>
Last password change					: <last-password-change-date>
Password expires					: <last-password-change-date + PASS_MAX_DAYS>
Password inactive					: never
Account expires						: never
Minimum number of days between password change		: <PASS_MIN_DAYS>
Maximum number of days between password change		: <PASS_MAX_DAYS>
Number of days of warning before password expires	: <PASS_WARN_AGE>
```

### Step 3: Creating a New Group

Create new _user42_ group via `sudo addgroup user42`.

```
$ sudo addgroup user42
```

Add user to _user42_ group via `sudo adduser <username> user42`.

```
$ sudo adduser <username> user42
```

> Alternatively, add user to _user42_ group via `sudo usermod -aG user42 <username>`.
>
> ```
> $ sudo usermod -aG user42 <username>
> ```
>
> Verify whether user was successfully added to _user42_ group via `getent group user42`.

```
$ getent group user42
```

## _cron_

### Setting Up a _cron_ Job

You need to write a shell script which should display some info about the system according to the project. Once you are done
with the script you need to make it run every 10 minutes and you need to do that with the help of crontab (Make sure to see my script).

Configure _cron_ as _root_ via `sudo crontab -u root -e`.

```
$ sudo crontab -u root -e
```

To schedule a shell script to run every 10 minutes, replace below line

      ```
      23 # m h  dom mon dow   command
      ```

      with:

      ```
      23 */10 * * * * sh /path/to/script
      ```

Check _root_'s scheduled _cron_ jobs via `sudo crontab -u root -l`.

```
$ sudo crontab -u root -l
```

After the this do not forget to add the script to `.bashrc` to make it run at reboot.

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
