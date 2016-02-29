FROM ubuntu:latest

RUN apt-get update -qq && apt-get install -y curl 

# install rvm
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN \curl -L https://get.rvm.io | bash -s stable --ruby

# configure rvm
RUN /bin/bash -l -c "rvm get stable --autolibs=enable" \
    && /bin/bash -l -c "rvm install ruby 2.3.0"  

#install nodejs
RUN apt-get install -y nodejs

#update gem
RUN /bin/bash -l -c "rvm --default use ruby-2.3.0" \
    && /bin/bash -l -c "gem update --system" \
    && /bin/bash -l -c "rvm gemset use global" \
    && /bin/bash -l -c "echo 'gem: --no-document' >> /root/.gemrc" \
    && /bin/bash -l -c "gem update" 

#install bundler
RUN /bin/bash -l -c "gem install bundler"

#install bundler
RUN apt-get install -y libgmp-dev && /bin/bash -l -c "gem install nokogiri"


#install Rails
RUN /bin/bash -l -c "rvm use ruby-2.3.0@rails4.2 --create" \
    && /bin/bash -l -c "gem install rails"
#RUN /bin/bash -l -c ""
