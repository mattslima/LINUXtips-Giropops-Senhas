FROM ubuntu:22.04
WORKDIR /app
COPY . .
RUN apt-get update -y
RUN apt-get install pip -y
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install flask redis prometheus_client
RUN pip install --upgrade flask
RUN apt-get install redis -y
ENV REDIS_HOST=127.0.0.1
EXPOSE 5000
CMD redis-server --daemonize yes && flask run --host=0.0.0.0