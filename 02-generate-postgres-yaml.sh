#!/bin/bash
set -euo pipefail

# Get the root directory of the git repository
REPO_DIR=$(git rev-parse --show-toplevel)

# Define the output file path
OUTPUT_FILE="${REPO_DIR}/cluster/cnpg-system/cnpg.yaml"

# Combine namespace manifest and Helm templates into a single file
{
  cat <<EOF
---
apiVersion: v1
kind: Namespace
metadata: 
  name: cnpg-system
EOF

helm template cnpg \
  --namespace cnpg-system \
  --create-namespace \
  cloudnative-pg/cloudnative-pg

} > "${OUTPUT_FILE}"

echo "The complete manifest has been generated in ${OUTPUT_FILE}"