
#!/bin/sh

### BEGIN INIT INFO
# Provides:          lmm
# Required-Start:    $remote_fs
# Required-Stop:     $remote_fs
# Should-Start:      $named
# Should-Stop:       $named
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Luna Multiplayer server
# Description:       Starts Luna Multiplayer server
### END INIT INFO

case "$1" in
    start)
    	/usr/local/bin/lmm.sh start
    ;;
    stop)
    	/usr/local/bin/lmm.sh stop
    ;;
    status)
    	/usr/local/bin/lmm.sh status
    ;;
    *)
        echo "Usage: ${0} {start|stop|status}"
        exit 2
esac
exit 0
