FROM ubuntu:artful
MAINTAINER George Liu <https://github.com/centminmod/docker-ubuntu-locust>
# Setup http://locust.io
RUN ulimit -c -m -s -t unlimited && apt-get update && apt-get install -y build-essential libncursesw5-dev libreadline-dev libssl-dev libgdbm-dev libc6-dev libsqlite3-dev libxml2-dev libxslt-dev python python-dev python-setuptools python-pip && apt-get clean && apt-get autoclean && apt-get remove; pip install --upgrade pip; pip install locustio; pip install pyzmq; pip install beautifulsoup4; mkdir -p /locust/scripts
ADD ./scripts/locust0.py /locust/scripts/locust0.py
ENV SCENARIO_FILE /locust/scripts/locust0.py
ADD ./scripts/run.sh /usr/local/bin/run.sh
RUN chmod 755 /usr/local/bin/run.sh

EXPOSE 8089 5557 5558

CMD ["/usr/local/bin/run.sh"]