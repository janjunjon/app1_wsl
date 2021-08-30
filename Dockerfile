FROM ruby:2.6.6

RUN apt-get update -qq
RUN apt-get install -y build-essential
# RUN apt-get install -y libreadline6
# RUN apt-get install -y libreadline6-dev
# RUN apt-get install -y zlib1g zlib1g-dev

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs
RUN npm install npm@latest -g

# RUN touch ~/.bash_profile
# RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
# SHELL ["/bin/bash", "-c"]
# RUN . ~/.nvm/nvm.sh
# RUN nvm install v14.17.4
RUN npm install --global yarn
RUN apt-get -y install imagemagick

RUN mkdir /app1
WORKDIR /app1
COPY . /app1
RUN mkdir -p tmp/sockets

RUN gem install sassc -v '2.4.0' --source 'https://rubygems.org/'
RUN gem install multi_json -v '1.10.1'
RUN gem install bundler:2.2.14
RUN bundle update
RUN bundle install
RUN bundle exec rails webpacker:install


