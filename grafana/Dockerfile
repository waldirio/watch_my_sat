FROM docker.io/grafana/grafana:latest
MAINTAINER Tchello Mello <tchello.mello@gmail.com>

COPY templates/datasources/datasources.yaml /etc/grafana/provisioning/datasources 
COPY templates/dashboards/watch_my_sat.yml /etc/grafana/provisioning/dashboards/watch_my_sat.yml
COPY templates/dashboards/data/* /etc/grafana/provisioning/dashboards 
