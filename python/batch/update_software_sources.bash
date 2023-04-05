#!/bin/bash

idiot_counter()
{
   ############################################################
   # force user to type a random string to avoid
   # accidental execution of potentially damaging functions
   ############################################################
   # if tr does not work in the line below, try this:
   #  export STUPID_STRING=$(cat /dev/urandom|LC_ALL=C tr -dc "[:alnum:]"|fold -w 6|head -n 1)
   ############################################################
   export STUPID_STRING="k4JgHrt"
   if [ -e /dev/urandom ];then
     export STUPID_STRING=$(cat /dev/urandom|LC_CTYPE=C tr -dc "[:alnum:]"|fold -w 6|head -n 1)
   fi
   echo -e "#### type \"${STUPID_STRING}\" to update the software sources for all groups ####\n"
   idiot_counter=0
   while true; do
     read line
     case $line in
       ${STUPID_STRING}) break;;
       *)
         idiot_counter=$(($(($idiot_counter+1))%2));
         if [[ $idiot_counter == 0 ]];then
           echo -e "###\n### YOU FAIL !\n###\n### exiting..."; exit;
         fi
         echo "#### type \"${STUPID_STRING}\" to update the software sources for all groups, CTRL-C to abort";
         ;;
     esac
   done
}
#idiot_counter
#SECONDS_WAITING=10
#echo "giving you ${SECONDS_WAITING} seconds to abort via CTRL-C"
#sleep $SECONDS_WAITING
#echo "starting now"
#sleep 2

../update_software_source.py --group OracleLinux8_ManagedInstanceGroup1 --golden_instance OL8GoldenInstance1
../update_software_source.py --group OracleLinux8_ManagedInstanceGroup2 --golden_instance OL8GoldenInstance2

../update_software_source.py --group OracleLinux9_ManagedInstanceGroup1 --golden_instance OL9GoldenInstance1
../update_software_source.py --group OracleLinux9_ManagedInstanceGroup2 --golden_instance OL9GoldenInstance2
