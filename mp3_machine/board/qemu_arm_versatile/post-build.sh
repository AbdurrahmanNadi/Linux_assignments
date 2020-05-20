#!/bin/bash
echo "PermitRootLogin yes" >> $1/etc/ssh/sshd_config
echo "export PS1='MP3_Shell>'" >> $1/etc/profile
