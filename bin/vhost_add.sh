#!/bin/bash

clear

set -e

suffix=".loc"
ip="127.1.0.1"

hosts_file='/etc/hosts'
new_host="$(echo ${PWD##*/}${suffix})"
cnt=$(echo `grep -P "\s\b${new_host}\b" ${hosts_file} | wc -l `)

c_err='\033[1;31m'
c_warn='\033[1;35m'
c_inf='\033[1;36m'
c_cmd='\033[1;32m'
c_clr='\033[0m'

print_help(){
  echo -e "${c_err}
Usage: ${0##*/} [parameter]
Parameters:
  -h : Help
  -l : Show exists hosts
  -a : Add host for current directory
  -d : Remove host for current directory
${c_clr}"
}

echo_color() {
  mess=${1:-''}
  color=${2:-$c_inf}
  echo -e "${color}${mess}${c_clr}"
}

echo_info() {
  mess=${1:-''}
  insert_empty_line_before=${2:-0}
  insert_empty_line_after=${3:-0}
  color=${4:-$c_inf}
  [ -z "$insert_empty_line_before" -o "$insert_empty_line_before" == '0' ] || echo
  echo_color "$mess" $color
  [ -z "$insert_empty_line_after" -o "$insert_empty_line_after" == '0' ] || echo
}

echo_cmd() {
  mess=${1:-''}
  insert_empty_line_before=${2:-1}
  insert_empty_line_after=${3:-0}
  color=${4:-$c_cmd}
  echo_info "$mess" $insert_empty_line_before $insert_empty_line_after $color
}

exit_if_error() {
  local status=${1:-0}
  local mess=$(2:-'please check')
  if [ "$s" != '0' ]; then 
    echo_color "Error: $mess" $c_err
    exit $status
  fi
}

print_all_hosts() {
  local FOUND
  echo_info 'All hosts' 1 0 $c_info
  FOUND=$( cat "$hosts_file" | grep -P "${suffix}\b" )
  echo_info "$FOUND" 0 0 $c_cmd
}

print_hosts() {
  local FOUND
  echo_info 'Exits hosts' 1 0 $c_info
  grep -q "$new_host" "$hosts_file" \
    && FOUND=$(grep -B 1 -A 1 "$new_host" "$hosts_file")  \
    || FOUND=$(cat "$hosts_file" | grep -P "${suffix}\b" | tail -n 5 ) 
  echo_info "...\n$FOUND\n..." 0 0 $c_cmd
}

_list() {
  print_all_hosts
  grep -q "$new_host" "$hosts_file" && ( echo_info "The host '$new_host' already exists" 1 1 $c_warn ) || :

}

_add() {
  grep -q "$new_host" "$hosts_file" \
    && ( echo_info "The host '$new_host' already exists" 1 0 $c_err ) \
    || ( sudo sh -c "echo ${ip} ${new_host} >> $hosts_file" ; echo_info "The host '$new_host' was added" 1 0 $c_warn )
  print_hosts
}

_remove() {
  grep -q "$new_host" "$hosts_file" \
    && ( sudo sed -i "/${new_host}/d" ${hosts_file}; echo_info "The host '$new_host' was removed" 1 0 $c_warn;   print_hosts ) \
    || ( echo_info "The host '$new_host' not exists" 1 0 $c_err;   print_all_hosts )
}

proces_input_params() {
  while getopts ":hlad" opt; do
    case $opt in
      l)
        _list
        ;;
      a)
        _add
        ;;
      d)
        _remove
        ;;
      h|*)
        _list
        print_help
        exit 1
        ;;
    esac
  done
  shift $(( OPTIND - 1 ))
}

if [[ $# -eq 0 ]]; then
  proces_input_params -h
fi

proces_input_params $*
exit 0
