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

FROM postgres:11

COPY pg_hba.conf.postgres /

### Get postgres specific add-ons
#RUN echo "deb [trusted=yes] http://archive.debian.org/debian stretch stretch/updates main non-free contrib" > /etc/apt/sources.list

#RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main stretch stretch/updates main non-free contrib" >> /etc/apt/sources.list.d/pgdg.list

RUN echo "deb [trusted=yes] http://archive.debian.org/debian stretch stretch/updates main non-free contrib" > /etc/apt/sources.list

RUN echo "deb [trusted=yes] http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main stretch stretch/updates main non-free contrib" > /etc/apt/sources.list.d/pgdg.list

RUN echo "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-6 main" >> /etc/apt/sources.list

RUN echo "deb http://llvm.org/apt/precise/ llvm-toolchain-precise main" >> /etc/apt/sources.list

# RUN echo "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-6 main" >> /etc/apt/sources.list

# RUN echo "deb-src http://apt.llvm.org/xenial/ llvm-toolchain-xenial-6 main" >> /etc/apt/sources.list

RUN sed -i -e 's/deb.debian.org/archive.debian.org/g' \
               -e 's|security.debian.org|archive.debian.org/|g' \
               -e '/stretch-updates/d' \
               -e 's|security.debian.org|archive.debian.org/debian-security/|g' /etc/apt/sources.list

RUN apt-get update && apt-get install -y wget gnupg2 lsb-release software-properties-common

RUN wget https://www.postgresql.org/media/keys/ACCC4CF8.asc && apt-key add ACCC4CF8.asc && rm ACCC4CF8.asc

RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add -

RUN apt-get update && \
    apt-get install -y  wget \
                       build-essential \
                       postgresql-server-dev-11 \
                       postgresql-plpython-11 \
                       openssl \
                       libssl-dev \
                       libboost-all-dev \
                       m4 \
                       rpm \
                       python-pip \
                       python-dev \
                       build-essential \
                       cmake \
                       libspatialindex-dev \
                       libboost-iostreams-dev \
                       libboost-regex-dev \
                       libssl1.1 \
                       clang-6.0

RUN pip install tensorflow==1.14 dill "rtree>=0.8,<0.9"

## To build an image from this docker file, from madlib folder, run:
# docker build -t madlib/postgres_11:jenkins -f tool/docker/base/Dockerfile_postgres_11_Jenkins .