FROM hypriot/rpi-node

# install required packages, in one command
RUN apt-get update  && \
    apt-get install -y build-essential python-dev python-rpi.gpio

ENV PYTHON /usr/bin/python2

# install node-red
RUN npm install -g --quiet --unsafe-perm  node-red

# install nodered nodes
#RUN touch /usr/share/doc/python-rpi.gpio
#COPY ./source /usr/local/lib/node_modules/node-red/nodes/core/hardware
#RUN chmod 777 /usr/local/lib/node_modules/node-red/nodes/core/hardware/nrgpio

WORKDIR /root/bin
RUN ln -s /usr/bin/python2 ~/bin/python
RUN ln -s /usr/bin/python2-config ~/bin/python-config
env PATH ~/bin:$PATH

WORKDIR /root/.node-red
RUN npm --quiet install -g node-red-node-redis \
         node-red-contrib-googlechart  \
         node-red-node-web-nodes \
         node-red-node-openweathermap \
         node-red-node-forecastio

# run application
EXPOSE 1880
#CMD ["/bin/bash"]
ENTRYPOINT ["node-red-pi","-v","--max-old-space-size=128"]
