#!/bin/sh

#
# The script will automatically generate and install RSA public/private key pairs to a list of hosts 
# where access is required with no password.
#

UserHostPortList="${@}"

if [ "${UserHostPortList}" = "" ]; then
  echo "Syntax: $0 [username@]hostname[:port]"
  exit 1
fi

KeyFileName=id_rsa
port="-p 22"

ssh-keygen -t rsa -b 8192 -f ~/.ssh/${KeyFileName} -P ""

for UserHostPort in "${UserHostPortList}"; do
  IFS=: read UserHost port <<< ${UserHostPort}
  ssh ${User}@${b} $port "mkdir -p .ssh;chmod 700 .ssh"
  cat .ssh/${KeyFileName}.pub | ssh ${User}@${Host} $port 'cat >> .ssh/authorized_keys; chmod 640 .ssh/authorized_keys'
done