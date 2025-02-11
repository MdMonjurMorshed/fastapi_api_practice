FROM python:3.8-slim as builder
ENV PYTHONBUFFER=1
WORKDIR /src

COPY . /src

COPY requirements.txt /app

RUN pip install -r requirements.txt

FROM python:3.8-slim
COPY --from=builder /usr/local/lib/python3.8/site-packages /usr/local/lib/python3.8/site-packages

ENV PYTHONBUFFER=1
WORKDIR /src
COPY . /src

EXPOSE 8000

CMD ["fastapi","run","main.py"]

