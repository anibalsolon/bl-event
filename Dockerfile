FROM node:6

MAINTAINER Soichi Hayashi <hayashis@iu.edu>

RUN apt update && apt install -y vim

RUN npm install http-server -g && \
    npm install pm2 -g && \
    pm2 install pm2-slack && \
    pm2 set pm2-slack:error false && \
    pm2 set pm2-slack:exit true && \
    pm2 install pm2-logrotate && \
    pm2 set pm2-logrotate:retain 7

EXPOSE 80
EXPOSE 8080

CMD [ "/app/docker/start.sh" ]

COPY . /app
RUN cd /app && npm install --production && cd ui && npm install --production
