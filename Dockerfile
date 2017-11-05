FROM hashicorp/terraform:latest


MAINTAINER contact@kubespray.io

RUN apk update
RUN \
    apk update \
    && apk add --no-cache --virtual .build-deps \
      py-pip      \
      libc-dev    \
      gcc         \
      make        \
      git         \
      openssh     \
      python-dev  \
      libffi-dev  \
      openssl-dev \
      rsync       \
      && pip install ansible==2.3.0.0  \
      && git clone http://github.com/metacoma/ansible-terraform-provision /opt/playbooks/provision/                   \
      && apk del gcc make libffi-dev openssl-dev libc-dev \
      && rm -rf /var/cache/apk/*
ENTRYPOINT ansible-playbook -e env_id=$ENV_ID /opt/playbooks/provision/playbook.yml

