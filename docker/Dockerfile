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
# Expected to run with environment variable -e "QISKIT_API_TOKEN"
#

FROM ubuntu:16.04

MAINTAINER Tim Ellison <tim_ellison@uk.ibm.com>

# Install required OS tools & packages for QISKit drawing
RUN apt-get update \
  && apt-get install -qq -y --no-install-recommends \
    bzip2 \
    ca-certificates \
    curl \
    unzip \
    poppler-utils \
    texlive-latex-base \
    texlive-pictures \
    texlive-latex-extra \
  && rm -rf /var/lib/apt/lists/*

# Ensure Tex up to date
RUN texhash

# Temporary directory
RUN mkdir -p /tmp/qisinstall

# Install directory
RUN mkdir /ibmq

# Get Anaconda
RUN set -eux; \
    URL="https://repo.continuum.io/archive/Anaconda3-5.2.0-Linux-x86_64.sh"; \
    ESUM="09f53738b0cd3bb96f5b1bac488e5528df9906be2480fe61df40e0e0d19e3d48"; \
    curl -Lso /tmp/qisinstall/anaconda.sh ${URL}; \
    echo "${ESUM} /tmp/qisinstall/anaconda.sh" | sha256sum -c -

# Install Anaconda
RUN set -eux; \
    bash /tmp/qisinstall/anaconda.sh -b -p /ibmq/anaconda; \
    rm -f /tmp/qisinstall/anaconda.sh

ENV PATH "/ibmq/anaconda/bin:$PATH"

# Install QISKit code & image code
RUN set -eux; \
    pip install qiskit; \
    pip install pdf2image

# Get the QISKit tutorials
RUN set -eux; \
    URL="https://github.com/QISKit/qiskit-tutorial/archive/master.zip"; \
    ESUM="814282f4de196fd076fed789fad005dc9fb084c54fcc63a9bbd8edb4598d42d2"; \
    curl -Lso /tmp/qisinstall/master.zip ${URL}; \
    echo "${ESUM} /tmp/qisinstall/master.zip" | sha256sum -c - ; \
    unzip -d /ibmq /tmp/qisinstall/master.zip ; \
    rm -f /tmp/qisinstall/master.zip

# Define the QISKit configuration file
RUN mv /ibmq/qiskit-tutorial-master/Qconfig.py.template /ibmq/qiskit-tutorial-master/Qconfig.py

# Remove the temporary directory
RUN rm -rf /tmp/qisinstall

# Add Tini as a process subreaper for Jupyter. This prevents kernel crashes.
ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
ENTRYPOINT ["/usr/bin/tini", "--"]

# Server available on this port
EXPOSE 8888

# Default command
ENV PYTHONPATH "/ibmq/qiskit-tutorial-master/"
WORKDIR /ibmq/qiskit-tutorial-master/
CMD ["/ibmq/anaconda/bin/jupyter", "notebook", "--allow-root", "--port=8888", "--ip='0.0.0.0'", "--no-browser", "index.ipynb"]
