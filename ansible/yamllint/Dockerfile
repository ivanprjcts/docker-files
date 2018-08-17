#
# NOTE: THIS DOCKERFILE IS GENERATED MANUALLY
#
# FEEL FREE TO EDIT IT.
#

FROM webdevops/ansible:ubuntu-16.04

RUN set -ex \
    && apt-get update && apt-get install -y openssh-client \
    && rm -rf /var/lib/apt/lists/*

RUN pip install yamllint jmespath
