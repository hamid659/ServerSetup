#!/bin/bash

cores=$(nproc)   # number of cores 
min_load=1    # minimum load
load=$(awk '{print $3}'< /proc/loadavg)   # 15 min avaerage load

# ===== Create log   ========
function log()
{
  local message=${1}
  local log_file=/var/log/cpu_load.log
  echo -e "$(date '+%b %d %H:%M:%S') $HOSTNAME  ${message}" >> $log_file
}

# ===== Monitor CPU usage ========
while true
 do
   cpu_load=$(echo | awk -v c="${cores}" -v l="${load}" '{print l*100/c}' | awk -F. '{print $1}')   
   log "CPU load is $cpu_load  %"
   
   if [[ ${cpu_load} -le ${min_load} ]]; then
      log "cpu load is less than ${min_load}   Shutting down "
      #sudo shutdown now 
   else 
      sleep 10
   fi
done
