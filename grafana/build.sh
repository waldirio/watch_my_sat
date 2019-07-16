#!/bin/bash
buildah  bud -t docker.io/tchellomello/grafana:latest .
podman push docker.io/tchellomello/grafana:latest
