#!/bin/sh
wg-quick up wg0
finish () {
	    wg-quick down wg0
	        exit 0
	}
trap finish TERM INT QUIT
sleep infinity &
wait $!
