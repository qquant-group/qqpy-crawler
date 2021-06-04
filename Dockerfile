# See https://codeship.com/documentation/docker/browser-testing/
FROM ubuntu

WORKDIR /crawler

COPY ./requirement.txt /crawler/

RUN apt-get install -y wget xvfb unzip

# Set up the Chrome PPA
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

# Update the package list and install chrome
RUN apt-get update -y
RUN apt-get install -y google-chrome-stable

# Set up Chromedriver Environment variables
ENV CHROMEDRIVER_VERSION 2.19
ENV CHROMEDRIVER_DIR /chromedriver
RUN mkdir -p $CHROMEDRIVER_DIR
RUN chmod +x $CHROMEDRIVER_DIR/chromedriver
# RUN apt-get install libxi6 libgconf-2-4 -y

# Download and install Chromedriver
RUN wget -q --continue -P $CHROMEDRIVER_DIR "http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip"
RUN unzip $CHROMEDRIVER_DIR/chromedriver* -d $CHROMEDRIVER_DIR
RUN apt-get update && apt-get install -y python3.6 python3-distutils python3-pip python3-apt
RUN apt-get update && apt-get install -y python-pip
# Put Chromedriver into the PATH
ENV PATH $CHROMEDRIVER_DIR:$PATH

COPY . .


 CMD ["python3","main.py"]