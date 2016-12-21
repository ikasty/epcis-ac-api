FROM node:alpine
MAINTAINER ikasty <mail.ikasty@gmail.com>

WORKDIR /usr/src/app

ADD ./wait-for-it.sh /usr/src/

# get epcis ac api
RUN apk add --no-cache --virtual .build git && \
	git clone https://github.com/HaJaehee/jaehee_epcis_ac_api.git /usr/src/app && \
	apk del .build && \

# edit settings and install
	sed -i 's/127.0.0.1:7474/neo4j:7474/' conf.json && \
	sed -i 's/127.0.0.1/postgres/' conf.json && \
	npm install && \

# wait-for-it.sh
	chmod 777 /usr/src/wait-for-it.sh && \
	apk --no-cache add bash

CMD /usr/src/wait-for-it.sh -t 0 neo4j:7474 -- npm start