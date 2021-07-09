### /etc/profile.d/00-wsl2-systemd.sh  
### wslArch
SYSTEMD_PID=$(ps -ef | grep '/lib/systemd/systemd --system-unit=basic.target$' | grep -v unshare | awk '{print $2}')

if [ -z "$SYSTEMD_PID" ]; then
	sudo /usr/bin/daemonize /usr/bin/unshare --fork --pid --mount-proc /lib/systemd/systemd --system-unit=basic.target
	SYSTEMD_PID=$(ps -ef | grep '/lib/systemd/systemd --system-unit=basic.target$' | grep -v unshare | awk '{print $2}')
fi

if [ -n "$SYSTEMD_PID" ] && [ "$SYSTEMD_PID" != "1" ]; then
	#pass env WSL_INTEROP
	exec sudo --preserve-env=WSL_INTEROP /usr/bin/nsenter -m -u -i -n -p -C -t $SYSTEMD_PID su - --whitelist-environment WSL_INTEROP z
fi
