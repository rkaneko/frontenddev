FROM ubuntu:14.04
MAINTAINER rkaneko <kanek.o.dev@gmail.com>

ENV USERNAME rkaneko
ENV PASSWORD rkaneko
ENV NODEBREW_ROOT /home/${USERNAME}/.nodebrew
ENV NODE_VERSION v0.12.7

# RUN apt-get update && sudo apt-get install -y sudo

# add user
RUN useradd ${USERNAME} && echo "${USERNAME}:${PASSWORD}" | chpasswd
RUN mkdir /home/${USERNAME}; chown ${USERNAME}:${USERNAME} /home/${USERNAME}
RUN adduser ${USERNAME} sudo && adduser ${USERNAME} adm
RUN chsh -s /bin/bash ${USERNAME}
RUN touch /home/${USERNAME}/.bashrc

# buildpack-deps
RUN apt-get update && apt-get install -y \
  build-essential \
  libpcre3-dev \
  libssl-dev \
  zlib1g-dev \
  wget \
  curl \
  git \
  perl \
  python2.7 \
  python2.7-dev \
  python-pip \
  nginx

# for Multi process running in Docker
RUN pip install supervisor
ADD supervisor/supervisord.conf /etc/supervisord.conf

# ansible
RUN pip install ansible==1.9.3

# Node.js
RUN export NODEBREW_ROOT=${NODEBREW_ROOT} && curl -L git.io/nodebrew | perl - setup
RUN echo "export PATH=${NODEBREW_ROOT}/current/bin:$PATH" >>/home/${USERNAME}/.bashrc

RUN export NODEBREW_ROOT=${NODEBREW_ROOT} && ${NODEBREW_ROOT}/nodebrew install-binary ${NODE_VERSION} && ${NODEBREW_ROOT}/nodebrew use ${NODE_VERSION}

# for a user
RUN chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}

# ssh
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin no/' /etc/ssh/sshd_config

RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# nginx
ADD nginx/nginx.conf /etc/nginx/nginx.conf
ADD nginx/default.conf /etc/nginx/conf.d/default.conf
ADD nginx/html /var/www/html/

EXPOSE 22 80
CMD ["/usr/local/bin/supervisord"]
