#!/bin/ksh

echo '['
for USER in `cut -d: -f1 /etc/passwd |sed '/^#/ d'`; do
  if ! su $USER 2>&1 |grep 'unknown login'; then 
    echo "  {"
    echo "    USER: '$USER',"
    echo "    CMDS: '$(su $USER -c 'sudo -l')'"
    echo "  },"
  fi
done
echo ']'
