
#!/bin/bash
yum install httpd -y
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>WEbServer with IP: $myip</h2>Build by terraform" > /var/www/html/index.html
systemctl start httpd
systemctl enable httpd

