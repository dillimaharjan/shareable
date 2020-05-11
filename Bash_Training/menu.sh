#!/bin/bash
pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey
}

dossh(){
    ssh -l `whoami` $1
}

show_menu() {
    clear
    echo "  ====================="
    echo "  Datum Server Selection"
    echo "  ====================="
    echo "  1.  dev-dilli-01   --  Dev Cluster Node 1"
    echo "  2.  dev-dilli-02   --  Dev Cluster Node 2"
    echo "  3.  prod-dilli-01   --  Main Prod cluster node 1, sudo once you login to server"
    echo "  4.  prod-dilli-02   --  Main Prod cluster node 2, sudo once you login to server"
    echo "  5.  prod-dilli-03   --  Main Prod cluster node 3, sudo once you login to server"
    echo "  6.  prod-dilli-04   --  Main Prod cluster node 4, sudo once you login to server"
    echo "  7.  rpt-dilli-01    --  Reporting Server node 1"
    echo "  8.  rpt-dilli-02    --  Reporting Server node 2"
    echo "  9.  proddr-dilli-01 --  Production DR 1 "
    echo "  10. proddr-dilli-02 --  Production DR 2 "
    echo "   X.  Exit to command prompt "
    echo " "
}
read_options(){
    local choice
    read -p "Enter choice [ 1 - 19 ] " choice
    case $(tr '[:upper:]' '[:lower:]' <<<"$choice") in
        1) dossh 192.168.100.1 ;;
        2) dossh 192.168.100.2 ;;
        3) dossh 192.168.1.1 ;;
        4) dossh 192.168.1.2 ;;
        5) dossh 192.168.1.3 ;;
        6) dossh 192.168.1.4 ;;
        7) dossh 192.168.100.3 ;;
        8) dossh 192.168.100.4 ;;
        9) dossh 10.0.0.1 ;;
       10) dossh 10.0.0.1 ;;
#        X|x) break ;;
        x) break ;;
        *) echo -e "Invalid selection" && sleep 2
    esac
}
echo -e " Use the alias "menu" after logging on the server and switching to oracle user to set database environements"

while true
do
    show_menu
    echo -e " You Can use the keyword menu on the server to set database environment"
    read_options
done

