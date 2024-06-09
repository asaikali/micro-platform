#!/bin/bash
set -euo pipefail

# Read the settings.sh file
GIT_REPO_ROOT=$(git rev-parse --show-toplevel)
source "${GIT_REPO_ROOT}/config/settings.sh"

# Ensure the output directory exists
mkdir -p "${GIT_REPO_ROOT}/cluster/cert-manager"

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
    --version "${MP_CERT_MANAGER_VERSION}" \
    --set crds.enabled=true
} > "${GIT_REPO_ROOT}/cluster/cert-manager/cert-manager.yaml"

echo "The complete manifest has been generated in ${GIT_REPO_ROOT}/cluster/cert-manager/cert-manager.yaml"