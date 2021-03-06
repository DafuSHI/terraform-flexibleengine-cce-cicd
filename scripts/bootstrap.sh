#!/bin/bash
#cat << EOF >> /etc/hosts
#90.84.244.233 kubernetes.default.svc.cluster.local
#EOF
###################################### Change the IP address above to your CCE cluster IP####################
 
echo "OK, let's rock and roll!!"


#get rid of iptables since it is only a demo
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo systemctl mask --now firewalld

sudo yum clean all & yum clean metadata
#install docker-ce
# In init.tpl ---  sudo yum install -y -q yum-utils device-mapper-persistent-data vm2 #We need these
#add repository
# In init.tpl ---  sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
#Install docker-ce
# In init.tpl ---  sudo yum install -y -q docker-ce docker-ce-cli containerd.io


#test

# In init.tpl ---  if [[ ! -e /etc/docker/daemon.json ]];then
# In init.tpl ---  	mkdir -p /etc/docker
# In init.tpl ---  	touch /etc/docker/daemon.json
# In init.tpl ---  fi

###############################
#Configure Docker
#Create daemon.json since it is not yet existing
# In init.tpl ---  echo "create daemon file"
# In init.tpl ---  cat << EOF >> /etc/docker/daemon.json
# In init.tpl ---  {
# In init.tpl ---  "insecure-registries":["registry.eu-west-0.prod-cloud-ocb.orange-business.com"]
# In init.tpl ---  }
# In init.tpl ---  EOF
##################################### this is the endpoint for SWR##############################



#Start docker damaen
sudo systemctl start docker
sudo systemctl enable docker






#Install Java
# In init.tpl ---  sudo yum install -y -q java-1.8.0-openjdk-devel
#configure jenkins repository step 1: Import pgp key; step 2: import repo
curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
#install jenkins
sudo yum install -y -q jenkins

#Add jenkins to the group of docker. I can't restart it later because there is bugs
sudo usermod -a -G docker jenkins


#start the service
sudo systemctl start jenkins
sudo systemctl enable jenkins





#Add user Jenkins to the docker user group
#sudo usermod -a -G docker jenkins
#sudo service jenkins restart


#Install git
# In init.tpl ---  sudo yum install -y -q git

#Install kubectl
# In init.tpl ---  cat <<EOF > /etc/yum.repos.d/kubernetes.repo
# In init.tpl ---  [kubernetes]
# In init.tpl ---  name=Kubernetes
# In init.tpl ---  baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
# In init.tpl ---  enabled=1
# In init.tpl ---  gpgcheck=1
# In init.tpl ---  repo_gpgcheck=1
# In init.tpl ---  gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
# In init.tpl ---  EOF

# In init.tpl ---  yum install -y -q kubectl

