FROM fluent/fluentd:v0.12.43-debian

RUN set -xe; apt-get update; apt-get install -y ruby-dev gcc libffi-dev make

RUN ["gem", "install", "fluent-plugin-elasticsearch", "--no-rdoc", "--no-ri", "--version", "2.4.0"]
