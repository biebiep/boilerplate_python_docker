FROM python:3.8

ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini


RUN mkdir /app
ADD hello_world.py /app/hello_world.py
RUN chmod +x /app/hello_world.py

WORKDIR /app
RUN useradd -m -r hello_world && \
    chown hello_world /app


# Run your program under Tini
USER hello_world

ENTRYPOINT ["/tini", "--"]
CMD ["python", "hello_world.py"]