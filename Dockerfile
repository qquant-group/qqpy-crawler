# See https://codeship.com/documentation/docker/browser-testing/
FROM ubuntu

WORKDIR /crawler

COPY ./requirement.txt /crawler/

RUN apt-get update \ 
&& apt-get install -y wget xvfb gnupg\
&& apt-get install -yqq unzip

# install google chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -\
&& sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'\
&& apt-get -y update\
&& apt-get install -y google-chrome-stable

# install chromedriver
RUN apt-get install -yqq unzip
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip
RUN unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/

RUN pip install ./requirement.txt

COPY . .

CMD ["python3","main.py"]