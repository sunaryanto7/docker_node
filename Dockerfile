# Base Image
FROM ubuntu:latest
ENV TZ=Asia/Jakarta
ARG DEBIAN_FRONTEND=noninteractive

# Administrator
LABEL maintainer="Nana7"

# Config Timezone And Update
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && apt-get install -y

# Default Packages
RUN apt-get install -y htop net-tools iputils-ping curl wget nano openssh-server sudo git nginx

# Config User And As Sudoers
RUN useradd -ms /bin/bash nana
RUN echo nana:Black2017 | chpasswd && adduser nana sudo
RUN echo "Set disable_coredump false" >> /etc/sudo.conf

# Config Python
RUN echo "alias python=/usr/bin/python3" >> /etc/profile.d/00-aliases.sh
RUN . /etc/profile.d/00-aliases.sh

# Intsall Node JS
RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
RUN apt-get install -y nodejs

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && sudo apt-get install -y yarn

# Expose PORT
EXPOSE 80
EXPOSE 22
EXPOSE 3000
EXPOSE 4000

# Run Services
CMD service ssh start && /bin/bash