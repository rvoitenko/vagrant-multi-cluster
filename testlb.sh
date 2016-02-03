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
   curl -s http://${host}/ >> requests_out
done


# lets calc statistic
for node in $(vagrant status|grep node|awk {'print $1'}); do 
    requests_count=$(cat requests_out|grep ${node}|wc -l)
    echo "${node}: ${requests_count}"
done
rm -f requests_out 