FROM ruby:2.6.6

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash && \
    . ~/.nvm/nvm.sh && \
    nvm install v14.16.1 && \
    npm install --global yarn

RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       nodejs

# RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
#     curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
#     echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
#     apt-get update && apt-get install -y yarn

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash && \
    . ~/.nvm/nvm.sh && \
    source ~/.bash_profile && \
    nvm install v14.17.4 && \
    npm install --global yarn && \
    sudo apt-get -y install imagemagick && \

RUN mkdir /app1
WORKDIR /app1

ADD /app1 /app1

RUN gem install bundler:2.2.14 && \
    bundle install && \
    gem install multi_json -v '1.10.1'
    rbenv exec gem install bundler
    rbenv rehash

# ADD docker-compose.yml /app1
# ADD containers /app1
# ADD environments /app1

RUN mkdir -p tmp/sockets
