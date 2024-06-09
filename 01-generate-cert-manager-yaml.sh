#!/bin/bash
set -euo pipefail

# Get the root directory of the git repository
REPO_DIR=$(git rev-parse --show-toplevel)

# Define the output file path
OUTPUT_FILE="${REPO_DIR}/cluster/cert-manager/cert-manager.yaml"

# Combine namespace manifest and Helm templates into a single file
{
  cat <<EOF
---
apiVersion: v1
kind: Namespace
metadata:
  name: cert-manager
EOF

  helm template cert-manager jetstack/cert-manager \
    --namespace cert-manager \
    --version v1.15.0 \
    --set crds.enabled=true
} > "${OUTPUT_FILE}"

echo "The complete manifest has been generated in ${OUTPUT_FILE}"