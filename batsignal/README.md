batsignal systemd unit should be installed for the user, thus doesn't require
`sudo`; in fact it will error if you try to use sudo with `--user` in a
`systemctl` invocation.


