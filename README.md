# Create WatchMySat pod
podman pod create --name watch_my_sat -p 3000 -p 9090

# Grafana
# access http://localhost:3000
podman run -d --pod watch_my_sat \
    --name grafana \
    --env-file variables.env \
    tchellomello/grafana:latest

# Prometheus
# access http://localhost:9090
podman run -d --pod watch_my_sat \
    --name prometheus \
    --env-file variables.env \
    tchellomello/prometheus:latest

# Prometheus PostgreSQL Exporter
podman run -d --pod watch_my_sat \
    --name postgresql_exporter \
    --env-file variables.env \
    wrouesnel/postgres_exporter



<!-- # saving config
podman generate kube watch_my_sat > watch_my_sat.yaml

# running config
podman play kube watch_my_sat.yaml -->

# tear down
podman pod rm watch_my_sat -f
