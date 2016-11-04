FROM debian
RUN echo 'deb http://ftp.de.debian.org/debian jessie-backports main' >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y wget
RUN mkdir /opt/selenium
RUN wget -O /opt/selenium/selenium-standalone-3.0.1.jar  http://selenium-release.storage.googleapis.com/3.0/selenium-server-standalone-3.0.1.jar
RUN mkdir /opt/selenium/drivers
RUN wget -O /opt/selenium/drivers/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/2.25/chromedriver_linux64.zip
RUN wget -O /opt/selenium/drivers/geckodriver-v0.11.1-linux64.tar.gz https://github.com/mozilla/geckodriver/releases/download/v0.11.1/geckodriver-v0.11.1-linux64.tar.gz
RUN apt-get install -y unzip
RUN cd /opt/selenium/drivers && unzip chromedriver_linux64.zip
RUN cd /opt/selenium/drivers && tar -xvf geckodriver-v0.11.1-linux64.tar.gz
RUN apt-get install -f

# install google-chrome
RUN wget -O /tmp/google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN apt-get install -y software-properties-common python-software-properties
RUN apt-get install -y libgconf2-4 libnss3-1d libxss1 libappindicator1 libpango1.0-0 xdg-utils
RUN apt-get install -y fonts-liberation
RUN apt-get install -y libasound2
RUN dpkg -i /tmp/google-chrome.deb

# install firefox
RUN apt-get install -y bzip2
RUN wget -O /opt/selenium/firefox-49.0.2.tar.bz2 https://download-installer.cdn.mozilla.net/pub/firefox/releases/49.0.2/linux-x86_64/en-US/firefox-49.0.2.tar.bz2
RUN cd /opt/selenium && tar -xvf firefox-49.0.2.tar.bz2

# Create a developer user
RUN apt-get install -y sudo
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

RUN apt-get install -y xvfb
RUN apt-get install -y openjdk-8-jdk

# Install nodejs
RUN wget -O /opt/nodejs.tar.xz https://nodejs.org/dist/v6.9.1/node-v6.9.1-linux-x64.tar.xz
RUN cd /opt && tar -xvf nodejs.tar.xz

RUN apt-get install -y libgtk-3-dev
RUN mkdir /data
ENV PATH $PATH:/opt/selenium/drivers:/opt/selenium/firefox:/opt/node-v6.9.1-linux-x64/bin
USER developer
ENV HOME /home/developer
CMD chmod +x /data/entrypoint.sh && sh /data/entrypoint.sh