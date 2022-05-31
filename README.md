# 42 Born2beroot

This project aims to introduce you to the wonderful world of virtualization.
You will create your first machine in VirtualBox under specific instructions.
Then, at the end of this project, you will be able to set up your own operating system while implementing strict rules.

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

• The architecture of your operating system and its kernel version.
• The number of physical processors.
• The number of virtual processors.
• The current available RAM on your server and its utilization rate as a percentage.
• The current available memory on your server and its utilization rate as a percentage.
• The current utilization rate of your processors as a percentage.
• The date and time of the last reboot.
• Whether LVM is active or not.
• The number of active connections.
• The number of users using the server.
• The IPv4 address of your server and its MAC (Media Access Control) address.
• The number of commands executed with the sudo program.

You can find the script monitoring.sh in this repository.

