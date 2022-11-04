FROM gitpod/workspace-full-vnc
                    
USER gitpod

# Install custom tools, runtime, etc. using apt-get
# For example, the command below would install "bastet" - a command line tetris clone:
#
# RUN sudo apt-get -q update && #     sudo apt-get install -yq bastet && #     sudo rm -rf /var/lib/apt/lists/*
#
# More information: https://www.gitpod.io/docs/42_config_docker/

ENV ANDROID_HOME /opt/android-sdk-linux

USER root

ENV ANDROID_HOME /opt/android-sdk-linux

RUN apt update -qq && yes | apt install zip unzip

RUN cd /opt && \
    wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip && \
    unzip -q *.zip -d ${ANDROID_HOME} && \
    rm *.zip

RUN chmod -R 777 ${ANDROID_HOME}

RUN apt clean -qq

USER gitpod

ENV PATH ${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${PATH}

RUN bash -c ". /home/gitpod/.sdkman/bin/sdkman-init.sh && \
    sdk install java 8.0.345-zulu && \
    sdk default java 8.0.345-zulu"

RUN touch /home/gitpod/.android/repositories.cfg
