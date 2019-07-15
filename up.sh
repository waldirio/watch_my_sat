#!/bin/bash
podman pod create --name watch_my_sat -p 3000 -p 9090

podman run -d --pod watch_my_sat \
    --name grafana \
    --env-file variables.env \
    tchellomello/grafana:latest

podman run -d --pod watch_my_sat \
    --name prometheus \
    --env-file variables.env \
    tchellomello/prometheus:latest

podman run -d --pod watch_my_sat \
    --name postgresql_exporter \
    --env-file variables.env \
    wrouesnel/postgres_exporter


podman run -d --pod watch_my_sat \
    --name mongodb_exporter \
    --env-file variables.env \
    tchellomello/mongodb_exporter

