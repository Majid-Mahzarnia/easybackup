#! /bin/bash

# GOTO function 

# Colors
NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHTGRAY='\033[0;37m'
DARKGRAY='\033[1;30m'
LIGHTRED='\033[1;31m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTBLUE='\033[1;34m'
LIGHTPURPLE='\033[1;35m'
LIGHTCYAN='\033[1;36m'
WHITE='\033[1;37m'
# Colors/

function goto
{
   label=$1
   cmd=$(sed -n "/$label:/{:a;n;p;ba};" $0 | grep -v ':$')
   eval "$cmd"
   exit
}
# GOTO function/

# Start
startFunc=${1:-"startFunc"}
goto $startFunc
startFunc:
# Start/

# GET WORKPLACE PATH (WORKING DIRECTORY)
workplace:
echo -e "${LIGHTCYAN}Enter the workplace directory path: ${LIGHTPURPLE}(example: /home/username/backup_jobs)${NOCOLOR}"
read -e workplace_path dir
echo
if [ -d "$workplace_path" ]; then
  echo -e "$workplace_path ${RED} does exist. Please chosoe another path${NOCOLOR}"
  goto workplace
else
    echo -e "${LIGHTCYAN}The workplace directory path is ${NOCOLOR}$workplace_path${LIGHTCYAN} is it correct? (Y/N)"
    echo
    read -r -p "Are you sure? [y/N] " response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
    then
        echo -e "${LIGHTCYAN}workplace directory path is confirmed${NOCOLOR}"
        echo
        mkdir -p $workplace_path
        chmod 700 $workplace_path
    else
        echo -e "${LIGHTCYAN}workplace directory path is not confirmed${NOCOLOR}"
        echo
        goto workplace
    fi
    fi
# GET WORKPLACE PATH (WORKING DIRECTORY)/

# GET SECRET PATH (CREDENTIALS)
default_secretpath:
echo -e "${LIGHTCYAN}The default secret directory path is ${NOCOLOR}$workplace_path/secrets ${LIGHTCYAN}is it correct? (Y/N)"
echo
read -r -p "Are you sure? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    echo -e "${LIGHTCYAN}default secret directory path is confirmed${NOCOLOR}"
    echo
    secret_path=$workplace_path/secrets
    mkdir -p $secret_path
    chmod 700 $secret_path
else
    echo -e "${LIGHTCYAN}secret directory path is not confirmed${NOCOLOR}"
    echo
    echo -e "${LIGHTCYAN}Enter the secret directory path: ${LIGHTPURPLE}(example: /home/username/backup_secrets)${NOCOLOR}"
    read -e secret_path dir
    echo
    echo -e "${LIGHTCYAN}The secret directory path is ${NOCOLOR}$secret_path ${LIGHTCYAN} is it correct? (Y/N)"
    echo
    read -r -p "Are you sure? [y/N] " response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
    then
        echo -e "${LIGHTCYAN}secret directory path is confirmed${NOCOLOR}"
        echo
        mkdir -p $secret_path
        chmod 700 $secret_path
    else
        echo -e "${LIGHTCYAN}secret directory path is not confirmed${NOCOLOR}"
        echo
        goto default_secretpath
    fi
    fi
# GET SECRET PATH (CREDENTIALS)/

# SOURCE SECRET FILE NAME
source_secret_file_name:
echo -e "${LIGHTCYAN}Enter the source secret file name: ${LIGHTPURPLE}(it will be created in $secret_path)${NOCOLOR}"
read -e source_secret_file_name dir
echo
if [ -d "$secret_path/$source_secret_file_name" ]; then
  echo -e "$secret_path/$source_secret_file_name ${RED} does exist and you can edit it manually or Please chosoe another path${NOCOLOR}"
  goto source_secret_file_name
else
    echo -e "${LIGHTCYAN}The source secret file name is ${NOCOLOR}$secret_path/$source_secret_file_name ${LIGHTCYAN} is it correct? (Y/N)"
    echo
    read -r -p "Are you sure? [y/N] " response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
    then
        echo -e "${LIGHTCYAN}source secret file name is confirmed${NOCOLOR}"
        echo
        touch $secret_path/$source_secret_file_name
        chmod 600 $secret_path/$source_secret_file_name
    else
        echo -e "${LIGHTCYAN}source secret file name is not confirmed${NOCOLOR}"
        echo
        goto source_secret_file_name
    fi
    fi
# SOURCE SECRET FILE NAME/

# DESTINATION SECRET FILE NAME
destination_secret_file_name:
echo -e "${LIGHTCYAN}Enter the destination secret file name: ${LIGHTPURPLE}(it will be created in $secret_path)${NOCOLOR}"
read -e destination_secret_file_name dir
echo
if [ -d "$secret_path/$destination_secret_file_name" ]; then
  echo -e "$secret_path/$destination_secret_file_name ${RED} does exist and you can edit it manually or Please chosoe another path${NOCOLOR}"
  goto destination_secret_file_name
else
    echo -e "${LIGHTCYAN}The destination secret file name is ${NOCOLOR}$secret_path/$destination_secret_file_name ${LIGHTCYAN} is it correct? (Y/N)"
    echo
    read -r -p "Are you sure? [y/N] " response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
    then
        echo -e "${LIGHTCYAN}destination secret file name is confirmed${NOCOLOR}"
        echo
        touch $secret_path/$destination_secret_file_name
        chmod 600 $secret_path/$destination_secret_file_name
    else
        echo -e "${LIGHTCYAN}source secret file name is not confirmed${NOCOLOR}"
        echo
        goto destination_secret_file_name
    fi
    fi
# DESTINATION SECRET FILE NAME/

# SOURCE CREDENTIALS
source_credential:
echo -e "${LIGHTCYAN}Enter source username: ${NOCOLOR}"
echo -e ${ORANGE}
read source_username
echo -e ${ORANGE}
echo -e "${LIGHTCYAN}Enter source password: ${NOCOLOR}"
echo -e ${ORANGE}
read source_password
echo -e ${ORANGE}
echo -e "${LIGHTCYAN}Enter source domain name: ${NOCOLOR}"
echo -e ${ORANGE}
read source_domain_name
echo
echo -e "${LIGHTCYAN}The source username is ${NOCOLOR}$source_username ${LIGHTCYAN}the source password is ${NOCOLOR}$source_password ${LIGHTCYAN}the source domain name is ${NOCOLOR}$source_domain_name  ${LIGHTCYAN}are they correct? (Y/N)"
echo
read -r -p "Are you sure? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    echo -e "${LIGHTCYAN}source credentials is confirmed${NOCOLOR}"
    echo
    printf "username=$source_username\n" >> $secret_path/$source_secret_file_name
    printf "password=$source_password\n" >> $secret_path/$source_secret_file_name
    printf "domain=$source_domain_name\n" >> $secret_path/$source_secret_file_name
    echo
    echo -e "${LIGHTCYAN}source credentials:${ORANGE}"
    cat $secret_path/$source_secret_file_name
    echo
else
    echo -e "${LIGHTCYAN}source credentials is not confirmed${NOCOLOR}"
    echo
    goto source_credential
fi
# SOURCE CREDENTIALS/

# DESTINATOION CREDENTIALS
destination_credential:
echo -e "${LIGHTCYAN}Enter destination username: ${NOCOLOR}"
echo -e ${ORANGE}
read destination_username
echo -e ${ORANGE}
echo -e "${LIGHTCYAN}Enter destination password: ${NOCOLOR}"
echo -e ${ORANGE}
read destination_password
echo -e ${ORANGE}
echo -e "${LIGHTCYAN}Enter destination domain name: ${NOCOLOR}"
echo -e ${ORANGE}
read destination_domain_name
echo -e ${ORANGE}
echo -e "${LIGHTCYAN}The destination username is ${NOCOLOR}$destination_username ${LIGHTCYAN}the destination password is ${NOCOLOR}$destination_password ${LIGHTCYAN}the destination domain name is ${NOCOLOR}$destination_domain_name  ${LIGHTCYAN}are they correct? (Y/N)"
echo
read -r -p "Are you sure? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    echo -e "${LIGHTCYAN}destination credentials is confirmed${NOCOLOR}"
    echo
    printf "username=$destination_username\n" >> $secret_path/$destination_secret_file_name
    printf "password=$destination_password\n" >> $secret_path/$destination_secret_file_name
    printf "domain=$destination_domain_name\n" >> $secret_path/$destination_secret_file_name
    echo -e "${LIGHTCYAN}destination credentials:${ORANGE}"
    cat $secret_path/$destination_secret_file_name
    echo
else
    echo -e "${LIGHTCYAN}destinationcredentials is not confirmed${NOCOLOR}"
    echo
    goto destination_credential
fi
# DESTINATOION CREDENTIALS/

# CREATE MOUNT POINT
default_mount_point:
echo -e "${LIGHTCYAN}The default mount point directory path is ${NOCOLOR}$workplace_path/mount_points ${LIGHTCYAN}is it correct? (Y/N)"
echo
read -r -p "Are you sure? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    echo -e "${LIGHTCYAN}default mount point directory path is confirmed${NOCOLOR}"
    echo
    mount_point=$workplace_path/mount_points
    mkdir -p $mount_point
    chmod 700 $mount_point
else
    echo -e "${LIGHTCYAN}default mount point directory path is not confirmed${NOCOLOR}"
    echo
    echo "${LIGHTCYAN}Enter the mount point directory path : ${LIGHTPURPLE}(example: /home/username/backup_mount_points)${NOCOLOR}"
    read mount_point
    echo
    echo -e "${LIGHTCYAN}The the mount point directory path is ${NOCOLOR}$mount_point ${LIGHTCYAN} is it correct? (Y/N)"
    echo
    read -r -p "Are you sure? [y/N] " response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
    then
        echo -e "${LIGHTCYAN}mount point directory path is confirmed${NOCOLOR}"
        echo
        mkdir -p $mount_point
        chmod 700 $mount_point
    else
        echo -e "${LIGHTCYAN}mount point directory path is not confirmed${NOCOLOR}"
        echo
        goto default_mount_point
    fi
    fi
# CREATE MOUNT POINT/

# CREATE SOURCE MOUNT POINTS
source_mount_point:
echo -e "${LIGHTCYAN}Enter the source network share path ${LIGHTPURPLE}(example //192.168.17.242/public/software)${NOCOLOR}"
read source_smb
echo
echo -e "${LIGHTCYAN}Enter the source local mount directory path ${LIGHTPURPLE}(example 192.168.17.242/public/software)${NOCOLOR}"
read -e source_local_mount dir
echo
source_local_mount=$mount_point/$source_local_mount
echo -e "${LIGHTCYAN}The source network share path is ${NOCOLOR}$source_smb ${LIGHTCYAN} and the source local mount directory is ${NOCOLOR}$source_local_mount ${LIGHTCYAN} are they correct? (Y/N)"
echo
read -r -p "Are you sure? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    echo -e "${LIGHTCYAN}source secret file name is confirmed${NOCOLOR}"
    echo
    mkdir -p $source_local_mount
    chmod 700 $source_local_mount
else
    echo -e "${LIGHTCYAN}source secret file name is not confirmed${NOCOLOR}"
    echo
    goto source_mount_point
fi
# CREATE SOURCE MOUNT POINTS/

# DESTINATION SECRET FILE NAME
destination_mount_point:
echo -e "${LIGHTCYAN}Enter the destination network share path ${LIGHTPURPLE}(example //192.168.17.34/test)${NOCOLOR}"
read destination_smb
echo
echo -e "${LIGHTCYAN}Enter the destination local mount directory path ${LIGHTPURPLE}(example 192.168.17.34/test)${NOCOLOR}"
read -e destination_local_mount dir
echo
destination_local_mount=$mount_point/$destination_local_mount
echo -e "${LIGHTCYAN}The destination network share path is ${NOCOLOR}$destination_smb ${LIGHTCYAN} and the destination local mount directory is ${NOCOLOR}$destination_local_mount ${LIGHTCYAN} are they correct? (Y/N)"
echo
read -r -p "Are you sure? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    echo -e "${LIGHTCYAN}destination secret file name is confirmed${NOCOLOR}"
    echo
    mkdir -p $destination_local_mount
    chmod 700 $destination_local_mount
else
    echo -e "${LIGHTCYAN}destination secret file name is not confirmed${NOCOLOR}"
    echo
    goto destination_mount_point
fi
# DESTINATION SECRET FILE NAME/

# CREATE LUNCH FILE
lunch_file_name:
lunchfilename1=$source_secret_file_name
lunchfilename2=$destination_secret_file_name
default_lunch_file_name="${lunchfilename1}_TO_${lunchfilename2}"
if [ -d "$default_lunch_file_name" ]; then
  echo -e "$default_lunch_file_name ${RED} does exist and you can edit it manually or remove it${NOCOLOR}"
  goto dlunch_file_name
else
echo -e "${LIGHTCYAN}Default batch file name which will be created in is ${NOCOLOR}$workplace_path/${GREEN}$default_lunch_file_name.sh ${LIGHTCYAN}is it correct? (Y/N)"
echo
read -r -p "Are you sure? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    echo -e "${LIGHTCYAN}batch file name is confirmed${NOCOLOR}"
    echo
    lunch_file_name=$workplace_path/$default_lunch_file_name.sh
    touch $lunch_file_name
    chmod 700 $lunch_file_name
else
    echo -e "${LIGHTCYAN}batch file name is not confirmed${NOCOLOR}"
    echo
    echo -e "${LIGHTCYAN}Enter the batch file name:  ${LIGHTPURPLE}(it will be created in $workplace_path)${NOCOLOR}"
    read -e lunch_file_name dir
    echo
    echo -e "${LIGHTCYAN}The batch file name is ${GREEN}$lunch_file_name ${LIGHTCYAN} is it correct? (Y/N)"
    echo
    read -r -p "Are you sure? [y/N] " response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
    then
        echo -e "${LIGHTCYAN}batch file name is confirmed${NOCOLOR}"
        echo
        lunch_file_name=$workplace_path/$lunch_file_name.sh
        rm -r $lunch_file_name
        touch $lunch_file_name
        chmod 700 $lunch_file_name
    else
        echo -e "${LIGHTCYAN}batch file name is not confirmed${NOCOLOR}"
        echo
        goto lunch_file_name
    fi
    fi
    fi
# CREATE LUNCH FILE/

# CREATE LUNCH
create_lunch:
printf "#! /bin/bash\n" >> $lunch_file_name
printf "#var\n" >> $lunch_file_name
printf "mount_log=$workplace_path/mount.log\n" >> $lunch_file_name
printf "transfer_log=$workplace_path/transfer_log\n" >> $lunch_file_name
printf "diff_log=$workplace_path/status.log\n" >> $lunch_file_name
printf "smbsource1=$source_smb\n" >> $lunch_file_name
printf "mntsource1=$source_local_mount\n" >> $lunch_file_name
printf "smbdest1=$destination_smb\n" >> $lunch_file_name
printf "mntdest1=$destination_local_mount\n" >> $lunch_file_name
printf "cerdsource1=$secret_path/$source_secret_file_name\n" >> $lunch_file_name
printf "creddest1=$secret_path/$destination_secret_file_name\n" >> $lunch_file_name
printf "#make logfiles\n" >> $lunch_file_name
mount_log=$workplace_path/mount.log
echo 'printf "####Staring Mount Log File - "'" >> $mount_log" >> $lunch_file_name
transfer_log=$workplace_path/transfer_log
echo 'printf "####Staring TRANSFER Log File - "'" >> $transfer_log" >> $lunch_file_name
diff_log=$workplace_path/status.log
echo 'printf "####Staring STATUS Log File - "'" >> $diff_log" >> $lunch_file_name
printf "#mount section\n" >> $lunch_file_name
echo 'date'" >> $mount_log" >> $lunch_file_name
printf "#umount -a -t cifs -l\n" >> $lunch_file_name
cerdsource1=$secret_path/$source_secret_file_name
smbsource1=$source_smb
mntsource1=$source_local_mount
creddest1=$secret_path/$destination_secret_file_name
smbdest1=$destination_smb
mntdest1=$destination_local_mount
echo 'umount' "$mntsource1 >> $transfer_log" >> $lunch_file_name
echo 'umount' "$mntdest1 >> $transfer_log" >> $lunch_file_name
printf "mount -t cifs -o credentials=$cerdsource1 $smbsource1 $mntsource1\n" >> $lunch_file_name
printf "mount -t cifs -o credentials=$creddest1 $smbdest1 $mntdest1\n" >> $lunch_file_name
echo 'df -h' " >> $mount_log" >> $lunch_file_name
printf "#diff before\n" >> $lunch_file_name
echo 'printf "#### Diff Files Before:  - "'" >> $diff_log" >> $lunch_file_name
echo 'diff -qr $mntsource1/ $mntdest1/' " >> $diff_log" >> $lunch_file_name
printf "#copy section\n" >> $lunch_file_name
echo 'date'" >> $transfer_log" >> $lunch_file_name
printf "cp -vpin $mntsource1/* $mntdest1\n" >> $lunch_file_name
printf "#diff after\n" >> $lunch_file_name
echo 'printf "#### Diff Files After:  - "'" >> $diff_log" >> $lunch_file_name
echo 'diff -qr $mntsource1/ $mntdest1/' " >> $diff_log" >> $lunch_file_name
printf "#umount section\n" >> $lunch_file_name
echo 'date'" >> $mount_log" >> $lunch_file_name
printf "#umount -a -t cifs -l\n" >> $lunch_file_name
echo 'umount' "$mntsource1 >> $transfer_log" >> $lunch_file_name
echo 'umount' "$mntdest1 >> $transfer_log" >> $lunch_file_name
echo 'df -h' " >> $mount_log" >> $lunch_file_name
printf "#end logfilesn\n" >> $lunch_file_name
echo 'printf "@@@@Ending Mount Log File - "'" >> $mount_log" >> $lunch_file_name
echo 'printf "@@@@Ending TRANSFER Log File - "'" >> $transfer_log" >> $lunch_file_name
echo 'printf "@@@@Ending STATUS Log File - "'" >> $diff_log" >> $lunch_file_name
echo -e "${LIGHTCYAN}batch file content:"
echo -e "${LIGHTCYAN}##########################################################################################################################"
echo -e "${LIGHTCYAN}you can edit it manually. batch file path is: ${GREEN}$lunch_file_name"
echo -e "${LIGHTCYAN}##########################################################################################################################${ORANGE}"
cat $lunch_file_name
echo -e "${LIGHTCYAN}##########################################################################################################################"
echo -e "${LIGHTCYAN}##########################################################################################################################${NOCOLOR}"
echo
# CREATE LUNCH/

# SCHEDULE LUNCH
schedule_lunch:
echo -e "${LIGHTCYAN}Would you like ctrate a schedule job to excute this backup job?"
echo
    read -r -p "Are you sure? [y/N] " response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
    then    
        echo -e "${LIGHTPURPLE} (crontab explanation:)"
        echo -e "${LIGHTPURPLE} (*	any value)"
        echo -e "${LIGHTPURPLE} (,	value list separator)"
        echo -e "${LIGHTPURPLE} (-	range of values)"
        echo -e "${LIGHTPURPLE} (-	range of values)"
        echo -e "${LIGHTPURPLE} (/	step values)"
        echo -e "${LIGHTPURPLE} (*    *    *    *    *  command to be executed
  ┬    ┬    ┬    ┬    ┬
  │    │    │    │    │
  │    │    │    │    │
  │    │    │    │    └───── day of week (0 - 7) (0 or 7 are Sunday, or use names)
  │    │    │    └────────── month (1 - 12)
  │    │    └─────────────── day of month (1 - 31)
  │    └──────────────────── hour (0 - 23)
  └───────────────────────── min (0 - 59))"
        echo -e "${LIGHTCYAN}Minute (0 - 59): ${NOCOLOR}"
        echo -e ${ORANGE}
        read minute
        echo -e "${LIGHTCYAN}Hour (0 - 23): ${NOCOLOR}"
        echo -e ${ORANGE}
        read hour
        echo -e "${LIGHTCYAN}Day of month (1 - 31): ${NOCOLOR}"
        echo -e ${ORANGE}
        read day_of_month
        echo -e "${LIGHTCYAN}Month (1 - 12): ${NOCOLOR}"
        echo -e ${ORANGE}
        read month
        echo -e "${LIGHTCYAN}Day of week (0 - 7) (0 or 7 are Sunday, or use names): ${NOCOLOR}"
        echo -e ${ORANGE}
        read day_of_week
        echo -e "${LIGHTCYAN}your backup job will be executed on the following timestamp"
        echo -e "every: ${NOCOLOR}Minutes=${ORANGE}$minute, ${NOCOLOR}Hour=${ORANGE}$hour, ${NOCOLOR}Day of month=${ORANGE}$day_of_month, ${NOCOLOR}Month=${ORANGE}$month, ${NOCOLOR}Day of week=${ORANGE}$day_of_week, ${LIGHTCYAN}is it correct?"     
        read -r -p "Are you sure? [y/N] " response
        if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
        then
            mycron=$workplace_path/mycron
            touch $mycron
            chmod 600 $mycron
            crontab -l > $mycron
            echo "$minute $hour $day_of_month $month $day_of_week $lunch_file_name >/dev/null 2>&1" >> $mycron
            crontab $mycron
            echo -e "${LIGHTCYAN}Your job Adde, ${LIGHTPURPLE}you can view it by using (crontab -l) or edit it by using (crontab -e) ${WHITE}"
            crontab -l
        else
        echo -e "${LIGHTCYAN}timestamp is not confirmed${NOCOLOR}"
        goto schedule_lunch
        fi
    else
        goto execute_lunch 
    fi
# SCHEDULE LUNCH/

# LUNCH
execute_lunch:
echo -e "${LIGHTCYAN}Would you like to excute this backup job now? (it takes some time, depends on the number of files and file size)"
echo
    read -r -p "Are you sure? [y/N] " response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
    then
        echo -e ${NOCOLOR}
        sudo sh $lunch_file_name
        echo
        echo -e "${LIGHTCYAN}batch file executed, check the result${NOCOLOR}"
        echo
    else
        echo
        goto end
    fi
# LUNCH/

# End
end:
echo -e "${LIGHTCYAN}Would you like to create another job?"
read -r -p "Are you sure? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    goto workplace 
else
    echo -e "${LIGHTCYAN}End of the script${NOCOLOR}"
fi
# End/
