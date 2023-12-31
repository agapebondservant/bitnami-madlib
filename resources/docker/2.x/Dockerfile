#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

FROM gcr.io/data-gpdb-public-images/gpdb7-ubuntu20.04-test

### Get postgres specific add-ons
RUN apt-get update && apt-get install -y  wget \
                        build-essential \
                        openssl \
                        libssl-dev \
                        libboost-all-dev \
                        m4 \
                        rpm \
                        python3-pip \
                        python3-dev \
                        build-essential \
                        cmake \
                        libspatialindex-dev \
                        vim \
                        sudo \
                        software-properties-common \
                        lsb-core \
                        libyaml-dev \
                        libpython3-dev \
                        python3-distutils \
                        iputils-ping \
                        iproute2 \
                        net-tools \
                        libspatialindex-dev \
                        ca-certificates

RUN add-apt-repository -y ppa:deadsnakes/ppa
RUN echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list

RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
RUN apt-get update && apt-get install -y \
                        postgresql-server-dev-14 \
                        postgresql-plpython3-14 \
                        postgresql-14 \
                        postgresql-client-14 \
                        libpq-dev

RUN python3 -m pip install dill rtree xgboost mock pandas numpy scikit-learn

## To build an image from this docker file, from madlib folder, run:
# docker build -t madlib/postgres_14:jenkins .