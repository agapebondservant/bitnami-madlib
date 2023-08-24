## Build MADlib Image

1. Build the Docker image:
```
resources/scripts/generate-pgmadlib-baseimage.sh
```

2. Deploy Postgres instance:
```
resources/scripts/deploy-pgmadlib-cluster.sh
watch kubectl get all -n ${DATA_E2E_PGMADLIB_NS}
```

3. To get the connect string for the MADlib-enabled instance:
```
export PGMADLIB_PW=${DATA_E2E_BITNAMI_AUTH_PASSWORD}
export PGMADLIB_ENDPOINT=$(kubectl get svc pgmadlib-bitnami-postgresql -n${DATA_E2E_PGMADLIB_NS} -o jsonpath="{.status.loadBalancer.ingress[0].hostname}")
echo postgresql://postgres:${PGMADLIB_PW}@${PGMADLIB_ENDPOINT}/postgres?sslmode=require
```

4. To delete the Postgres instance:
```
resources/scripts/delete-pgmadlib-cluster.sh
```