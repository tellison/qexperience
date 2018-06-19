# (C) Copyright IBM Corporation 2018.
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
#

FROM qiskit/qiskit-tutorial:latest

MAINTAINER Tim Ellison <tim_ellison@uk.ibm.com>

# Install required OS tools & packages for QISKit drawing
RUN set -eux ; \
  apt-get update && \
  apt-get install -qq -y --no-install-recommends \
    libgomp1 \
    libblas-dev

ENV PATH "/ibmq/anaconda/bin:$PATH"

# Install QISKit ACQUA code & Python dependencies
RUN set -eux; \
    pip install pyscf; \
    pip install qiskit-acqua; \
    pip install qiskit-acqua-chemistry

# Get the latest QISKit ACQUA tutorials
RUN set -eux; \
    mkdir -p /tmp/qisinstall ; \
    URL="https://github.com/QISKit/qiskit-acqua-tutorials/archive/master.zip"; \
    ESUM="9da56e38792d39182867867e0a61c722810c13305d16eb6def2ffab76513dadc"; \
    curl -Lso /tmp/qisinstall/master.zip ${URL}; \
    echo "${ESUM} /tmp/qisinstall/master.zip" | sha256sum -c - ; \
    unzip -d /ibmq /tmp/qisinstall/master.zip ; \
    rm -rf /tmp/qisinstall

# Server available on this port
EXPOSE 8888

# Default command
ENV PYTHONPATH "/ibmq/qiskit-acqua-tutorials-master/"
WORKDIR /ibmq/qiskit-acqua-tutorials-master/
CMD ["/ibmq/anaconda/bin/jupyter", "notebook", "--allow-root", "--port=8888", "--ip='0.0.0.0'", "--no-browser", "index.ipynb"]
