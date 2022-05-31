# 42 Born2beroot

This project aims to introduce you to the wonderful world of virtualization.
You will create your first machine in VirtualBox under specific instructions.
Then, at the end of this project, you will be able to set up your own operating system while implementing strict rules.

> ⚠️ **Warning**: Don't copy/paste anything you don't understand: it's bad for you, and for the school.

## Born2BeRoot Guide

This project contains vast amount of information and requires a lot of reading. I created a 
[guide](Born2BeRoot_Guide.pdf) for the project which can be found in this repository. The guide contains the exact
steps which result in the project complition. It is highly suggested to read a lot and gather information before 
reading the guide.

## Monitoring Script

You have to create a simple script called monitoring.sh. It must be developed in bash. At server startup, the 
script will display some information (listed below) on all terminals every 10 minutes (take a look at wall). 
The banner is optional. No error must be visible. Your script must always be able to display the following 
information:

- The architecture of your operating system and its kernel version.
- The number of physical processors.
- The number of virtual processors.
- The current available RAM on your server and its utilization rate as a percentage.
- The current available memory on your server and its utilization rate as a percentage.
- The current utilization rate of your processors as a percentage.
- The date and time of the last reboot.
- Whether LVM is active or not.
- The number of active connections.
- The number of users using the server.
- The IPv4 address of your server and its MAC (Media Access Control) address.
- The number of commands executed with the sudo program.

You can find the script monitoring.sh in this repository.

## Resources

You can find some links and books below that might be useful during the project. You can find all the books in 
resources folder. Note that you do not have to read the books completly but you will find a lot of useful 
information there.

Books

- [Basic Introduction](https://github.com/42YerevanProjects/42_Born2beroot/tree/master/resources)
- [Linux CLI Basics](https://github.com/42YerevanProjects/42_Born2beroot/tree/master/resources)
- [Bash Scripting](https://github.com/42YerevanProjects/42_Born2beroot/tree/master/resources)

Vidoes

- [Linux Basics](https://youtube.com/playlist?list=PLIhvC56v63IJIujb5cyE13oLuyORZpdkL)
- [SSH Crash Course](https://youtu.be/hQWRp-FdTpc)
- [UFW Guide](https://youtu.be/-CzvPjZ9hp8)
- [What is tty](https://youtu.be/SYwbEcNrcjI)

Links

- [Linux Essentials](https://www.netacad.com/courses/os-it/ndg-linux-essentials)
- [How to create VMs](https://www.howtogeek.com/196060/beginner-geek-how-to-create-and-use-virtual-machines/)
- [Open or close server ports](https://docs.bitnami.com/virtual-machine/faq/administration/use-firewall/)
- [Sudo Usage](https://phoenixnap.com/kb/linux-sudo-command)
- [Sudoers File](https://linuxfoundation.org/blog/classic-sysadmin-configuring-the-linux-sudoers-file/)
- [What is TTY](https://www.howtogeek.com/428174/what-is-a-tty-on-linux-and-how-to-use-the-tty-command/)

## Additional information

The information provided by this repository is not the only thing you should learn. Do not limit yourself with 
this information only. Please do not follow the instructions without understanding them.
