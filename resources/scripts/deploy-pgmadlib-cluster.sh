source .env

# Create namespace
kubectl create ns ${DATA_E2E_PGMADLIB_NS}

# Deploy PVC
kubectl apply -f resources/pgmadlib-cluster-pvc.yaml \
      -n ${DATA_E2E_PGMADLIB_NS}

# Install Postgres instance
envsubst < resources/pgmadlib-cluster-values.yaml | helm install pgmadlib-bitnami \
      oci://registry-1.docker.io/bitnamicharts/postgresql \
      -n ${DATA_E2E_PGMADLIB_NS} \
      -f -