FROM python:3.9

WORKDIR /usr/src/app

COPY requirements.txt .

RUN python3 -m ensurepip
RUN pip install --no-cache --upgrade pip setuptools
RUN pip install -r requirements.txt

ENV MODEL_PATH /model
ARG MODEL=4stems
RUN mkdir -p /model/$MODEL \
    && wget -O /tmp/$MODEL.tar.gz https://github.com/deezer/spleeter/releases/download/v1.4.0/$MODEL.tar.gz \
    && tar -xvzf /tmp/$MODEL.tar.gz -C /model/$MODEL/ \
    && touch /model/$MODEL/.probe

RUN apt-get update && apt-get install -y ffmpeg

ENV PYTHONPATH "${PYTHONPATH}:/usr/src/app/src"