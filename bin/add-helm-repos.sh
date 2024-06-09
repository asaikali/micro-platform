#!/bin/bash

# Function to print messages with formatting
print_message() {
    echo ""
    echo "============================================================"
    echo "$1"
    echo "============================================================"
}

# tailscale
# Tailscale - https://tailscale.com/kb/1236/kubernetes-operator#helm
print_message "Adding and updating Tailscale repository"
helm repo add tailscale https://pkgs.tailscale.com/helmcharts --force-update
helm repo update tailscale

# certificate-manager
# Jetstack - https://cert-manager.io/docs/installation/helm/
print_message "Adding and updating Jetstack repository"
helm repo add jetstack https://charts.jetstack.io --force-update
helm repo update jetstack

# grafana, loki, tempo, mimr, alloy
# Grafana - https://grafana.com/docs/grafana/latest/setup-grafana/installation/helm/
print_message "Adding and updating Grafana repository"
helm repo add grafana https://grafana.github.io/helm-charts --force-update
helm repo update grafana

# Postgres
# Cloud Native PG - https://github.com/cloudnative-pg/charts
print_message "Adding and updating Cloud Native PG repository"
helm repo add cloudnative-pg https://cloudnative-pg.github.io/charts --force-update
helm repo update cloudnative-pg

# rabbitmq, external-dns
# Bitnami - https://www.rabbitmq.com/kubernetes/operator/install-operator#helm-chart
print_message "Adding and updating Bitnami repository"
helm repo add bitnami https://charts.bitnami.com/bitnami --force-update
helm repo update bitnami