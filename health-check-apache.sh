#Script de health check do servidor Apache

#OLD SCRIPT

#systemctl status httpd | grep "inactive" >> /efs/mateus/teste-off.txt && echo -e "O servidor esta offline." >> /efs/mateus/teste-off.txt || 
#(systemctl status httpd | grep "active" >> /efs/mateus/teste-on.txt && echo -e "O servidor está online." >> /efs/mateus/teste-on.txt)

#-----------------

SERVICE="$(systemctl is-active httpd)"
DATE="$(date +'%A, %b %d, %Y %H:%M:%S')"

if [ "${SERVICE}" = "active" ]; then
	DIR='/efs/mateus/server-online-logs.txt'
	TEXT="APACHE2 Server is ONLINE @ "
else
	DIR='/efs/mateus/server-offline-logs.txt'
	TEXT="APACHE2 Server is OFFLINE @ "
fi

echo "$TEXT$DATE" >> "$DIR"
