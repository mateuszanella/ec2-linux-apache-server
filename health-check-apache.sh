#systemctl status httpd | grep "inactive" >> server-inactive.txt && echo -e "\nO servidor está inativo!\n" || grep "active" >> server-active.txt && echo -e "\nO servidor está ativo\n";

systemctl status httpd | grep "inactive" >> teste-off.txt && echo -e "O servidor esta offline." >> teste-off.txt || (systemctl status httpd | grep "active" >> teste-on.txt && echo -e "O servidor está online." >> teste-on.txt)
