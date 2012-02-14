while true ; do
clear
sleep 1;
perl -e 'printf "%c[1;33mZufall\n" . `echo -e "Stephan ist\ndoof" | figlet` . "\n!%c[0;37m\n", 27, 27'
sleep 1;
done
