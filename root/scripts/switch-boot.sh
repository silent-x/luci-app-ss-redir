#!/bin/sh
# Hacked from /lib/upgrade/linksys.sh (then taken from anomeome and hacked even further)

cur_boot_part=`/usr/sbin/fw_printenv -n boot_part`
target_firmware=""
if [ "$cur_boot_part" = "1" ]
then
    target_firmware="Switching to Kernel/Partition 2"
    fw_setenv boot_part 2
    fw_setenv bootcmd "run altnandboot"
elif [ "$cur_boot_part" = "2" ]
then
    target_firmware="Switching to Kernel/Partition 1"
    fw_setenv boot_part 1
    fw_setenv bootcmd "run nandboot"
fi
# Re-enable recovery so we get back in case the new firmware ist kaput
fw_setenv auto_recovery yes
echo "$target_firmware"

# Add option to reboot now or later
read -p "Are you ready to reboot now? y or n = " CONT
if [ "$CONT" = "y" ]; then
    echo "Rebooting now"
    reboot
elif [ "$CONT" = "yes" ]; then
    echo "Rebooting now"
    reboot
else
    echo "Exiting for manual reboot"
fi