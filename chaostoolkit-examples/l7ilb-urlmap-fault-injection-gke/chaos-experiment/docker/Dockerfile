FROM chaostoolkit/chaostoolkit

USER root
RUN apk update && \
    apk add --virtual build-deps libffi-dev openssl-dev gcc python3-dev \
        musl-dev && \
    pip install --no-cache-dir chaostoolkit-addons chaostoolkit-reliably && \
    pip install -U chaostoolkit-google-cloud-platform 
USER 1001

