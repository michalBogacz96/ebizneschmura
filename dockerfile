FROM ubuntu:latest

ENV TZ=Europe/Warsaw
ENV SDKMAN_DIR /root/.sdkman

RUN apt-get update && apt-get install -y \
	zip \
	unzip \
	vim \
	git \
	wget \
	curl

RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN curl -s "https://get.sdkman.io" | bash
RUN chmod a+x "$SDKMAN_DIR/bin/sdkman-init.sh"

WORKDIR $SDKMAN_DIR
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN curl -s "https://get.sdkman.io" | bash
RUN chmod a+x "$SDKMAN_DIR/bin/sdkman-init.sh"

RUN [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh" && exec "$@"

RUN source /root/.bashrc

RUN source "$SDKMAN_DIR/bin/sdkman-init.sh" && sdk install java 11.0.2-open
RUN source "$SDKMAN_DIR/bin/sdkman-init.sh" && sdk install kotlin
RUN source "$SDKMAN_DIR/bin/sdkman-init.sh" && sdk install maven

ENV JAVA_HOME $SDKMAN_DIR/candidates/java/11.0.2-open
ENV PATH $PATH:$JAVA_HOME/bin

RUN \
curl -sSLO https://github.com/pinterest/ktlint/releases/download/0.45.0/ktlint && chmod a+x ktlint

EXPOSE 8080 8000
CMD gradle build