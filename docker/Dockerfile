# (C) Copyright IBM Corporation 2017.
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
# Expected to run with environment variable -e "QISKIT_API_TOKEN"
#

FROM ubuntu:16.04

MAINTAINER Tim Ellison <tim_ellison@uk.ibm.com>

# Install required OS tools
RUN apt-get update \
  && apt-get install -qq -y --no-install-recommends \
    bzip2 \
    ca-certificates \
    curl \
    unzip \
  && rm -rf /var/lib/apt/lists/*

# Temporary directory
RUN mkdir -p /tmp/qisinstall

# Install directory
RUN mkdir /ibmq

# Get Anaconda
RUN set -eux; \
    URL="https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh"; \
    ESUM="55e4db1919f49c92d5abbf27a4be5986ae157f074bf9f8238963cd4582a4068a"; \
    curl -Lso /tmp/qisinstall/anaconda.sh ${URL}; \
    echo "${ESUM} /tmp/qisinstall/anaconda.sh" | sha256sum -c -

# Install Anaconda
RUN set -eux; \
    bash /tmp/qisinstall/anaconda.sh -b -p /ibmq/anaconda; \
    rm -f /tmp/qisinstall/anaconda.sh

ENV PATH "/ibmq/anaconda/bin:$PATH"

# Install QISKit code
RUN set -eux; \
    pip install qiskit

# Get the QISKit tutorials
RUN set -eux; \
    URL="https://github.com/QISKit/qiskit-tutorial/archive/master.zip"; \
    ESUM="0a61fd5b704e29fa57f0b2d1c36e207e57b57c42910e36fd69af73fbf4088000"; \
    curl -Lso /tmp/qisinstall/master.zip ${URL}; \
    echo "${ESUM} /tmp/qisinstall/master.zip" | sha256sum -c - ; \
    unzip -d /ibmq /tmp/qisinstall/master.zip ; \
    rm -f /tmp/qisinstall/master.zip

# Define the QISKit configuration file
COPY Qconfig.py /ibmq/qiskit-tutorial-master/

# Remove the temporary directory
RUN rm -rf /tmp/qisinstall

# Server available on this port
EXPOSE 8888

# Default command
WORKDIR /ibmq/qiskit-tutorial-master/
CMD ["/ibmq/anaconda/bin/jupyter", "notebook", "--allow-root", "--ip='*'", "--no-browser", "index.ipynb"]


