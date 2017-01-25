FROM hypriot/rpi-node

# install required packages, in one command
RUN apt-get update  && \
    apt-get install -y  python-dev

ENV PYTHON /usr/bin/python2

# install RPI.GPIO python libs
RUN  wget https://sourceforge.net/projects/raspberry-gpio-python/files/raspbian-jessie/python-rpi.gpio_0.6.2~jessie-1_armhf.deb/download && \
     dpkg -i download && \
     rm download

# install node-red
RUN apt-get install -y build-essential && \
    npm install -g --unsafe-perm  node-red 

# install nodered nodes
RUN touch /usr/share/doc/python-rpi.gpio
COPY ./source /usr/local/lib/node_modules/node-red/nodes/core/hardware
RUN chmod 777 /usr/local/lib/node_modules/node-red/nodes/core/hardware/nrgpio

WORKDIR /root/bin
RUN ln -s /usr/bin/python2 ~/bin/python
RUN ln -s /usr/bin/python2-config ~/bin/python-config
env PATH ~/bin:$PATH

WORKDIR /root/.node-red
RUN npm install -g node-red-node-redis \
         node-red-contrib-googlechart  \
         node-red-node-web-nodes \
         node-red-node-openweathermap \
         node-red-node-forecastio

# run application
EXPOSE 1880
#CMD ["/bin/bash"]
ENTRYPOINT ["node-red-pi","-v","--max-old-space-size=128"]
