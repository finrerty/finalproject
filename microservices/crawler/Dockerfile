FROM python:3.6-alpine

RUN apk add git \
    && git clone https://github.com/express42/search_engine_crawler.git \
    && apk del git

WORKDIR /search_engine_crawler
RUN apk add --no-cache --virtual .build-deps gcc musl-dev \
    && pip install -r /search_engine_crawler/requirements.txt \
    && apk del .build-deps gcc musl-dev

ENV EXCLUDE_URLS='.*github.com'
CMD ["python3","-u", "crawler/crawler.py", "https://vitkhab.github.io/search_engine_test_site"]
