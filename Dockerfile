# (C) Copyright IBM Corporation 2017, 2018.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# Expected to run with environment variable -e "IBMQE_API"
# See details at https://hub.docker.com/r/qiskit/qiskit-tutorial/
#

FROM ubuntu:16.04

MAINTAINER Tim Ellison <tim_ellison@uk.ibm.com>

# Install required OS tools & packages for QISKit drawing
RUN set -eux ; \
  apt-get update && \
  apt-get install -qq -y --no-install-recommends \
    bzip2 \
    ca-certificates \
    curl \
    unzip \
    poppler-utils \
    texlive-latex-base \
    texlive-pictures \
    libgomp1 \
    libblas-dev \
    texlive-latex-extra && \
  rm -rf /var/lib/apt/lists/* && \
  texhash

# Temporary & Install directories
RUN set -eux; \
    mkdir -p /tmp/qisinstall && \
    mkdir /ibmq

# Get Anaconda
RUN set -eux; \
    URL="https://repo.continuum.io/archive/Anaconda3-2019.03-Linux-x86_64.sh"; \
    ESUM="45c851b7497cc14d5ca060064394569f724b67d9b5f98a926ed49b834a6bb73a"; \
    curl -Lso /tmp/qisinstall/anaconda.sh ${URL}; \
    echo "${ESUM} /tmp/qisinstall/anaconda.sh" | sha256sum -c - && \
    bash /tmp/qisinstall/anaconda.sh -b -p /ibmq/anaconda; \
    rm -f /tmp/qisinstall/anaconda.sh

ENV PATH "/ibmq/anaconda/bin:$PATH"

# Install QISKit code & image code
RUN set -eux; \
    pip install msgpack; \
    pip install pdf2image; \
    pip install qiskit

# Get the QISKit tutorials
RUN set -eux; \
    URL="https://github.com/QISKit/qiskit-tutorial/archive/master.zip"; \
    ESUM="9596f1e5ae9793ca10a9d017d795ee9143cab7de10040880bdc6bb3f4f5219e4"; \
    curl -Lso /tmp/qisinstall/master.zip ${URL}; \
    echo "${ESUM} /tmp/qisinstall/master.zip" | sha256sum -c - ; \
    unzip -d /ibmq /tmp/qisinstall/master.zip ; \
    rm -f /tmp/qisinstall/master.zip

# Remove the temporary directory
RUN rm -rf /tmp/qisinstall

# Add Tini as a process subreaper for Jupyter. This prevents kernel crashes.
ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
ENTRYPOINT ["/usr/bin/tini", "--"]


# Install QISKit ACQUA code & Python dependencies
RUN set -eux; \
    pip install pyscf; \
    pip install qiskit-aqua; \
    pip install qiskit-chemistry


# Server available on this port
EXPOSE 8888

# Default command
ENV PYTHONPATH "/ibmq/qiskit-tutorials-master/"
WORKDIR /ibmq/qiskit-tutorials-master/
CMD ["/ibmq/anaconda/bin/jupyter", "notebook", "--allow-root", "--port=8888", "--ip='0.0.0.0'", "index.ipynb"]
