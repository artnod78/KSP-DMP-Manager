
#!/bin/sh

### BEGIN INIT INFO
# Provides:          dmp-server
# Required-Start:    $remote_fs
# Required-Stop:     $remote_fs
# Should-Start:      $named
# Should-Stop:       $named
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Dark Multiplayer server
# Description:       Starts a Dark Multiplayer server
### END INIT INFO

case "$1" in
    start)
    	/usr/local/bin/dmpmanager.sh start
    ;;
    stop)
    	/usr/local/bin/dmpmanager.sh stop
    ;;
    status)
    	/usr/local/bin/dmpmanager.sh status
    ;;
    *)
        echo "Usage: ${0} {start|stop|status}"
        exit 2
esac
exit 0
