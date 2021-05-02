#! /bin/bash

#function
function variableSet () {
    
    if [[ $# -eq 1 ]]; then
            echo "missing: $1 is not set"
    fi
    
    if [[ $# -eq 2 ]]; then
        echo "$2 is set"
    fi
}

------------------------------------------------------
# DO NOT USE THIS CODE! ONLY FOR TESTING! USE KEYS!!!|
------------------------------------------------------


HOSTNAME=""
USER=""
PASSWORD=""
PORT=
FILENAMEFILEPATH=~/temporal-shift-module/online_demo/main.py

while getopts "hi:u:w:p:-:" opt; do
    case "$opt" in
        -)
            case "$OPTARG" in
                hostname)
                    HOSTNAME="${!OPTIND}"
                    OPTIND=$(( $OPTIND + 1 ))
                    ;;
                user)
                    USER="${!OPTIND}"
                    OPTIND=$(( $OPTIND + 1 ))
                    ;;
                password)
                    PASSWORD="${!OPTIND}"
                    OPTIND=$(( $OPTIND + 1 ))
                    ;;
                port)
                    PORT="${!OPTIND}"
                    OPTIND=$(( $OPTIND + 1 ))
                    ;;
            esac
            ;;
        h )
            echo "Usage $0"
            echo "Long Version:"
            echo "[--hostname <hostname>]"
            echo "[--user <username>]"
            echo "[--password <password>]"
            echo "[--port <portnumber>]"
            echo "-----------------"
            echo "Short Version:"
            echo "[-i <hostname>]"
            echo "[-u <user>]"
            echo "[-w <password>]"
            echo "[-p <portnumber>]"
            exit 0
            ;;
        i )
            HOSTNAME="$OPTARG"
            ;;
        u )
            USER="$OPTARG"
            ;;
        w)
            PASSWORD="$OPTARG"
            ;;
        p )
            PORT="$OPTARG"
            ;;
    esac
done

shift "$((OPTIND-1))"


# test if the variables are set

variableSet $HOSTNAME Hostname
variableSet $USER User
variableSet $PASSWORD Password
variableSet $PORT Port



# add variables to main.py
sed -i "/HOSTNAME=/ c HOSTNAME='$HOSTNAME'" $FILENAMEFILEPATH
sed -i "/USER=/ c USER='$USER'" $FILENAMEFILEPATH
sed -i "/PASSWORD=/ c PASSWORD='$PASSWORD'" $FILENAMEFILEPATH
sed -i "/PORT=/ c PORT=$PORT" $FILENAMEFILEPATH

python3 $FILENAMEFILEPATH&

sed -i "/STOPPINGPROCESS=/ c STOPPINGPROCESS='$!'" ~/StopGestureRecognition.sh
