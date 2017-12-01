#
# NOTE: THIS DOCKERFILE IS GENERATED MANUALLY
#
# FEEL FREE TO EDIT IT.
#

FROM ivanprjcts/python3.6-xenial:minimal

# ensure local python is preferred over distribution python
RUN set -ex \
    && apt-get update && apt-get install -y build-essential \
    && apt-get install -y git libav-tools zlib1g-dev libxml2 \ 
    && apt-get install -y libxml2-dev libxslt1-dev \
    && rm -rf /var/lib/apt/lists/*

CMD ["python3"]
