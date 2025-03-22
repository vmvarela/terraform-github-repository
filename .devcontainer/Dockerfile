FROM alpine:3.21

ENV TERRAFORM_VERSION=1.11.1
ENV TERRAFORM_DOCS_VERSION=0.19.0
ENV TFLINT_VERSION=0.55.1

# Instalar dependencias necesarias
RUN apk update && apk add --no-cache \
    bash \
    curl \
    fish \
    gcompat \
    git \
    github-cli \
    jq \
    libc6-compat \
    libstdc++ \
    make \
    nodejs \
    npm \
    openssh \
    pre-commit \
    py3-pip \
    unzip \
    && rm -rf /var/cache/apk/*

# Instalar Terraform
RUN curl -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && cd /tmp \
    && unzip terraform.zip \
    && mv terraform /usr/local/bin/ \
    && rm -rf *

# Instalar Terraform-docs
RUN curl -L https://github.com/terraform-docs/terraform-docs/releases/download/v${TERRAFORM_DOCS_VERSION}/terraform-docs-v${TERRAFORM_DOCS_VERSION}-linux-amd64.tar.gz > terraform-docs.tgz && \
    tar -xzf terraform-docs.tgz terraform-docs && \
    rm terraform-docs.tgz && \
    chmod +x terraform-docs && \
    mv terraform-docs /usr/local/bin/ && \
    terraform-docs -v

# Instalar TFLint
RUN curl -L https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/tflint_linux_amd64.zip > tflint.zip && \
    unzip tflint.zip && \
    rm tflint.zip && \
    chmod +x tflint && \
    mv tflint /usr/local/bin/ && \
    tflint -v

# Establecer directorio de trabajo
WORKDIR /workspace
