FROM ruby:2.1.5

RUN apt-get install curl git -y
RUN gem install bosh_cli -v 1.2768.0 --no-ri --no-rdoc
RUN gem install bosh-gen --no-ri --no-rdoc
RUN gem install bosh-workspace --no-ri --no-rdoc

VOLUME ["/workspace"]
WORKDIR /workspace

ADD .bashrc /root/.env
ADD .bashrc /root/.bashrc

RUN ssh-keygen -f ~/.ssh/id_rsa -t rsa -N ''

