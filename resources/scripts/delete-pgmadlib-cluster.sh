source .env

# Uninstall Postgres instance
helm uninstall pgmadlib-bitnami -n ${DATA_E2E_PGMADLIB_NS}

# Undeploy PVC
kubectl delete -f resources/pgmadlib-cluster-pvc.yaml -n ${DATA_E2E_PGMADLIB_NS}

# Delete namespace
kubectl delete ns ${DATA_E2E_PGMADLIB_NS}