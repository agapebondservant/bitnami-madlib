source .env

echo -e ${DATA_E2E_REGISTRY_PASSWORD} | docker login -u ${DATA_E2E_REGISTRY_USERNAME} --password-stdin

cd resources/docker/1.x

# docker build -t ${DATA_E2E_REGISTRY_USERNAME}/${DATA_E2E_PGMADLIB_IMAGE_NM}:${DATA_E2E_PGMADLIB_IMAGE_TAG} .

docker pull madlib/postgres_11:jenkins

docker tag madlib/${DATA_E2E_PGMADLIB_IMAGE_NM}:jenkins ${DATA_E2E_REGISTRY_USERNAME}/${DATA_E2E_PGMADLIB_IMAGE_NM}:${DATA_E2E_PGMADLIB_IMAGE_TAG}

docker push ${DATA_E2E_REGISTRY_USERNAME}/${DATA_E2E_PGMADLIB_IMAGE_NM}:${DATA_E2E_PGMADLIB_IMAGE_TAG}

cd -