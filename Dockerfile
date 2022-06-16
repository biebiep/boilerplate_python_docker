FROM python:3.8

ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

ARG APP_NAME=hello_world
ARG APP_USER=app_user

RUN mkdir /${APP_NAME}
ADD hello_world.py /${APP_NAME}/hello_world.py
RUN chmod +x /${APP_NAME}/hello_world.py

WORKDIR /${APP_NAME}
RUN useradd -m -r ${APP_USER} && \
    chown ${APP_USER} /${APP_NAME}


# Run your program under Tini
USER ${APP_USER}

ENTRYPOINT ["/tini", "--"]
CMD ["python", "hello_world.py"]