FROM python:3.8-alpine

RUN apk add git \
    && git clone https://github.com/express42/search_engine_ui.git \
    && apk del git

WORKDIR /search_engine_ui
RUN apk add --no-cache --virtual .build-deps gcc musl-dev \
    && pip install -r /search_engine_ui/requirements.txt \
    && apk del .build-deps gcc musl-dev

COPY deploy.sh /deploy.sh
RUN chmod 0777 /deploy.sh
CMD ["/deploy.sh"]
