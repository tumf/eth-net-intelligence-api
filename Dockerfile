FROM debian

RUN apt-get update &&\
    apt-get install -y curl git-core &&\
    curl -sL https://deb.nodesource.com/setup | bash - &&\
    apt-get update &&\
    apt-get install -y nodejs

RUN apt-get update &&\
    apt-get install -y build-essential

RUN adduser ethnetintel

RUN cd /home/ethnetintel &&\
    git clone https://github.com/cubedro/eth-net-intelligence-api &&\
    cd eth-net-intelligence-api &&\
    npm install

ENV NODE_ENV "production"
ENV CONTACT_DETAILS ""
ENV WS_SERVER "wss://stats.ethdev.com"
ENV VERBOSITY 2
ENV RPC_HOST $GETH_PORT_8545_TCP_ADDR
ENV RPC_PORT $GETH_PORT_8545_TCP_PORT
ENV LISTENING_PORT 30303

WORKDIR /home/ethnetintel/eth-net-intelligence-api
ENTRYPOINT ["node","app.js"]
