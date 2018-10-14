# https://github.com/elastic/kibana-docker
FROM docker.elastic.co/kibana/kibana:5.6.1

# Add your kibana plugins setup here
# Example: RUN kibana-plugin install <name|url>

# COPY ./plugins /plugins
COPY --chown=kibana:kibana ./config/kibana.yml ./config/kibana.yml
COPY --chown=kibana:kibana ./bin/k-docker ./bin/k-docker

# RUN kibana-plugin install file:///plugins/logtrail-5.6.1-0.1.21.zip
RUN kibana-plugin remove x-pack
