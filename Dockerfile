FROM nodered/node-red-docker:rpi

USER root
RUN apt-get update && apt-get install -y python-rpi.gpio
RUN echo "node-red ALL=(ALL) NOPASSWD: /usr/bin/python" > /etc/sudoers.d/rpigpio ; \
    chmod 0440 /etc/sudoers.d/rpigpio
RUN usermod -aG dialout node-red
USER node-red
RUN npm install --quiet node-red-node-serialport
