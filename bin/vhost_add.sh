#!/bin/bash

set -e

suffix=".loc"
ip="127.1.0.1"

hosts_file='/etc/hosts'
new_host="$(echo ${PWD##*/}${suffix})"
cnt=$(echo `grep -P "\s\b${new_host}\b" ${hosts_file} | wc -l `)

echo "${cnt} found host(s)"

if [[ "$cnt" -eq "0" ]]; then
  echo "${ip} ${new_host}" | sudo tee -a $hosts_file
  cat $hosts_file
  echo '----------------------------'
  echo "Adding host: '$new_host'"
else
  if [[ $# -gt 0 && "$1" -eq "-D" ]]; then
    sudo sed -i "/${new_host}/d" ${hosts_file}
    cat $hosts_file
    echo '----------------------------'
    echo "Host $new_host was removed"
  else
    echo `grep -P "\b${new_host}\b" ${hosts_file} `
    cat $hosts_file
    echo '----------------------------'
    echo "Host: $new_host already exists."
  fi
fi
