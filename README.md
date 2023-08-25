## Build MADlib Image

1. Create an .env file with the following properties:
```
export DATA_E2E_PGMADLIB_NS=<namespace of madlib-enabled postgres instance>
export DATA_E2E_PGMADLIB_IMAGE_NM=postgres_11 #change to the name of the base madlib image you want to use
export DATA_E2E_BITNAMI_AUTH_USERNAME=postgres 
export DATA_E2E_BITNAMI_AUTH_PASSWORD=postgres
export DATA_E2E_BITNAMI_AUTH_POSTGRESPASSWORD=postgres
export DATA_E2E_BITNAMI_AUTH_DATABASE=postgres
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

5. To migrate data from Greenplum:
* Create a **pgpass** password file using the format shown here: <a href="https://www.postgresql.org/docs/current/libpq-pgpass.html" target="_blank">link</a>
* Use **pg_dump** and **pg_restore** - sample script:
```
pg_dump --schema=$GREENPLUM_SCHEMA \
        --dbname=$GREENPLUM_DB \
        --table=rf_credit_card_transactions_inference_results \
        --host=$GREENPLUM_HOST \
        --username=gpadmin --no-privileges --format=c | \
pg_restore --clean \
           --dbname=$DATA_E2E_BITNAMI_AUTH_DATABASE \
           --host=aa28023c2f2614eb188934e99167ce65-1434640867.us-east-1.elb.amazonaws.com \
           --username=$DATA_E2E_BITNAMI_AUTH_USERNAME
```