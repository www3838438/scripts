apt update || yum update
apt install -y openssh-server || yum install -y openssh-server
mkdir /var/run/sshd
sed -r -i 's/^[#]? *PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -r -i "s/^[#]? *Port .*/Port $1/" /etc/ssh/sshd_config
echo "root:$2" | chpasswd
/usr/sbin/sshd

# https://docs.docker.com/engine/examples/running_ssh_service/#run-a-test_sshd-container
# SSH login fix. Otherwise user is kicked off after login
#sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
#echo "export VISIBLE=now" >> /etc/profile
