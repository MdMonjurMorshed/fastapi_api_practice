FROM python:3.8-slim as builder
ENV PYTHONBUFFER=1
WORKDIR /
COPY requirements.txt .

# COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

FROM python:3.8-slim
COPY --from=builder /usr/local/lib/python3.8/site-packages /usr/local/lib/python3.8/site-packages
COPY --from=builder /usr/local/bin/uvicorn /usr/local/bin/uvicorn

ENV PYTHONBUFFER=1
WORKDIR src/src
COPY src/ .

EXPOSE 8000

CMD ["uvicorn","main:app","--host","0.0.0.0","--port","8000","--reload"]

