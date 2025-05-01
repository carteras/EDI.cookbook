# sshd 

```bash
sudo systemctl status sshd
```


```bash
sudo nano /etc/ssh/sshd_config
```

Find 

```bash
#PasswordAuthentication yes
```

And remove the hash

```bash
PasswordAuthentication yes
```

```bash
sudo systemctl restart sshd
```