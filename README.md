## Build MADlib Image

1. Create an .env file with the following properties:
```
export DATA_E2E_PGMADLIB_NS=<namespace of madlib-enabled postgres instance>
export DATA_E2E_PGMADLIB_IMAGE_NM=postgres_11 #change to the name of the base madlib image you want to use
export DATA_E2E_BITNAMI_AUTH_USERNAME=postgres 
export DATA_E2E_BITNAMI_AUTH_PASSWORD=postgres
export DATA_E2E_BITNAMI_AUTH_POSTGRESPASSWORD=postgres
export DATA_E2E_BITNAMI_AUTH_DATABASE=madlib
export DATA_E2E_REGISTRY_USERNAME=<your container registry username>
export DATA_E2E_REGISTRY_PASSWORD=<your container registry password or token>
```

2. Build the Docker image:
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