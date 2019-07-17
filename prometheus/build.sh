#!/bin/bash
buildah  bud -t docker.io/tchellomello/prometheus:latest .
podman push docker.io/tchellomello/prometheus:latest
