#!/bin/bash
set -euo pipefail

# Read the settings.sh file
readonly GIT_REPO_ROOT=$(git rev-parse --show-toplevel)
source ${GIT_REPO_ROOT}/config/settings.sh

# Define the namespace and temporary directory
NAMESPACE="cert-manager"
OUTPUT_DIR="${GIT_REPO_ROOT}/cluster/cert-manager"

# Ensure the output directory exists
mkdir -p ${OUTPUT_DIR}

# Define the namespace manifest as a variable
NAMESPACE_MANIFEST=$(cat <<EOF
apiVersion: v1
kind: Namespace
metadata:
  name: ${NAMESPACE}
EOF
)

# Render the Helm templates
HELM_OUTPUT=$(helm template cert-manager jetstack/cert-manager \
  --namespace ${NAMESPACE} \
  --version ${MP_CERT_MANAGER_VERSION} \
  --set crds.enabled=true)

# Concatenate the namespace manifest and Helm templates into a single file
echo "${NAMESPACE_MANIFEST}" > ${OUTPUT_DIR}/cert-manager.yaml
echo "${HELM_OUTPUT}" >> ${OUTPUT_DIR}/cert-manager.yaml

echo "The complete manifest has been generated in ${OUTPUT_DIR}/cert-manager.yaml"