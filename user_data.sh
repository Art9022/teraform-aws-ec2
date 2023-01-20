#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
 
cat <<EOF > /var/www/html/index.html
<html>
<h2>Build by Power of Terraform <font color="red">/font></h2><br>
Owner Artur Ayvazyan

Hello from artur

</html>
EOF

sudo service httpd start
chkconfig httpd on