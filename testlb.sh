#!/bin/bash

usage() { echo "Usage: $0 -h IP_ADDRESS -n number_of_requests" 1>&2; exit 1; }

while getopts ":h:n:" opt; do
  case $opt in
    h)
      host=${OPTARG}
      ;;
    n)
      number=${OPTARG}
      ;;
    *)
      usage
      ;;
  esac
done

shift $((OPTIND-1))

if [ -z "${host}" ] || [ -z "${number}" ]; then
    usage
fi

echo "Sending ${number} requests to http://${host}/..."


for ((i=1;i<=${number};i++)); do
   curl -s http://${host}/ > /dev/null
done


# lets grab statistic from all web nodes
for node in $(vagrant status|grep node|awk {'print $1'}); do 
    ip=$(vagrant ssh ${node} -c "ifconfig eth1|grep -oP 'inet addr:\K\S+'|tr -d '\n'")
    requests=$(curl -s "http://${ip}/status"|grep -Ev '[a-zA-Z]' | cut -f4 -d' ') 
    echo "${node}: ${requests}"
done