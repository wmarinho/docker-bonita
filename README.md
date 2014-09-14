Docker & Bonita BPM
=====================

##Docker
[Docker](http://www.docker.com/) is an open platform for developers and sysadmins to build, ship, and run distributed applications. Consisting of Docker Engine, a portable, lightweight runtime and packaging tool, and Docker Hub, a cloud service for sharing applications and automating workflows, Docker enables apps to be quickly assembled from components and eliminates the friction between development, QA, and production environments. As a result, IT can ship faster and run the same app, unchanged, on laptops, data center VMs, and any cloud.

## Install Docker

###Ubuntu Trusty 14.04 (LTS) (64-bit)
Ubuntu Trusty comes with a 3.13.0 Linux kernel, and a docker.io package which installs all its prerequisites from Ubuntu's repository.

Note: Ubuntu (and Debian) contain a much older KDE3/GNOME2 package called docker, so the package and the executable are called docker.io.
Installation
To install the latest Ubuntu package (may not be the latest Docker release):

<pre>
sudo apt-get update
sudo apt-get install docker.io
sudo ln -sf /usr/bin/docker.io /usr/local/bin/docker
sudo sed -i '$acomplete -F _docker docker' /etc/bash_completion.d/docker.io
</pre>

## Deploy Bonita
<pre>
docker pull wmarinho/bonita
docker run  --name=bonita -d  -p 8080:8080  wmarinho/bonita
</pre>

http://[ip_address]:8080/bonita

##Building your image

###Clone and edit Dockerfile template

<pre>
sudo git clone https://github.com/wmarinho/docker-bonita.git
cd docker-bonita
sudo vi Dockerfile
sudo docker build -t myimage/bonita:mytag .
sudo docker images
sudo docker run -p 8080:8080 -d myimage/bonita:mytag
</pre>

Or run in interactive mode

<pre>
sudo docker run -p 8080:8080 -i -t myimage/bonita:mytag /bin/bash
</pre>

Please see [Dockerfile Reference] (https://docs.docker.com/reference/builder/) for additional information.


##Docker Hub account

You can create a docker account and push your images. Please see [Working with Docker Hub](https://docs.docker.com/userguide/dockerrepos/)

