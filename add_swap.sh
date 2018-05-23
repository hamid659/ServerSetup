#!/bin/bash

function create_SWAP()
{
  local avilable_disk_space=$(df -B1 / | sed -e /^Filesystem/d | awk {'print $4'} )
  local total_RAM=$(free -b | grep "Mem" | awk {'print $2'} )
  local swap_size=$((total_RAM*50/100))
  
 #printf "disk_space=$avilable_disk_space\n RAM=$total_RAM\n SWAP=$swap_size\n"
  if [ "$avilable_disk_space" -gt  "$swap_size" ]
   then
     sudo swapoff -a  
     sudo rm -rf /swapfile 
     sudo fallocate -l "$swap_size" /swapfile
     sudo chmod 600 /swapfile
     sudo mkswap /swapfile
     sudo swapon /swapfile
  else 
    echo " There is not enough space on the disk to create  $swap_space bytes  SWAP file"
  fi
}

