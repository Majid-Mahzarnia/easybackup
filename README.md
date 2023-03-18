# easybackup
easybackup script 
####
<br />What is easybackup script and what it use for?

<br />easybackup script is a simple bash script that helps you to make schedule jobs to copy from smb share folder to anothe one.

The main idea came from "navid.nejati@gmail.com" and it was about making an easy tool to backup huge MSSQL backup files on network share paths on specific time.
Then an intermediate platform is needed as a scheduler and a controller, also some logs to make sure everything is ok with your schedule jobs are needed too.
There are too many software to make it easy to you but, we'd rather using an opensource scripts because of flexibility and reliability. So, let's go:
####
####
How to use easybackup script?

**1- First an Ubuntu Server Version 20XX or higher is needed and then setup the following packeges on it:**
<br />apt update && apt upgrade -y
<br />apt install cifs-utils 
<br />reboot
<br />
**<br /> 2- Download and run the easybackup script from this repository:**
<br /> chmod 700 ./easybackup.sh 
<br />
./easybackup.sh

Explanation:
- Workplace directory is: a directory in which all backup job project files will be ctrated
- Secter directory is: a directory in which all secret files which are contain access credentials will be ctrated
- Source secret/Destination file is: a file that contain all credentials 
- Mount point is: a directory in which all source or destination will be mounted
- Source / Destination network share Path is: a smb networkpath like \\server\sharepath
- Source / Destination local mount Path is: a directory that network share Path 
####
####
If you need more help about the easybackup script, you can contact us via:
<br />mahzarnia@hotmail.com
<br />majid.mahzarnia@gmail.com
<br />navid.nejati@gmail.com
