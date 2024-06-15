# Use Ubuntu 22.04 (Jammy) as the base image
FROM ubuntu:24.04

# Install common utilities and update ca-certificates
RUN apt-get update -q && \
    apt-get install -yq \
      locales \
      curl \
      apt-transport-https \
      ca-certificates \
      gnupg \
      unzip  \
      git \
      jq \
      sudo \
      lsb-release \
      bash-completion && \
    update-ca-certificates

# Set the locale to en_US.UTF-8
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen && \
    update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8


# Install Carvel and command completions
RUN curl -L https://carvel.dev/install.sh | bash && \
    kapp completion bash > /etc/bash_completion.d/kapp && \
    kctrl completion bash > /etc/bash_completion.d/kctrl && \
    imgpkg completion bash > /etc/bash_completion.d/imgpkg && \
    ytt completion bash > /etc/bash_completion.d/ytt && \
    vendir completion bash > /etc/bash_completion.d/vendir 

# Install kubectl and alias it to k and activate command completion for kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/kubectl && \
    echo 'alias k="kubectl"' >> /etc/bash.bashrc && \
    echo 'source <(kubectl completion bash)' >> /etc/bash.bashrc

# Install CUE language
ARG CUE_VERSION=0.9.1 
RUN curl -L https://github.com/cue-lang/cue/releases/download/v${CUE_VERSION}/cue_v${CUE_VERSION}_linux_amd64.tar.gz -o cue.tar.gz && \
    mkdir cue && \
    tar -xzvf cue.tar.gz -C cue && \
    mv cue/cue /usr/local/bin/cue && \
    rm cue.tar.gz && \
    rm -rf cue

# Install kubectl-tree plugin
ARG KUBECTL_TREE_VERSION=0.4.3
RUN curl -L https://github.com/ahmetb/kubectl-tree/releases/download/v${KUBECTL_TREE_VERSION}/kubectl-tree_v${KUBECTL_TREE_VERSION}_linux_amd64.tar.gz -o kubectl-tree.tar.gz && \
    tar -xzvf kubectl-tree.tar.gz && \
    mv kubectl-tree /usr/local/bin/  && \
    rm kubectl-tree.tar.gz

# Install kubens 
ARG KUBENS_VERSION=0.9.5
RUN curl -L https://github.com/ahmetb/kubectx/releases/download/v${KUBENS_VERSION}/kubens_v${KUBENS_VERSION}_linux_x86_64.tar.gz -o kubens.tar.gz && \
    tar -xzvf kubens.tar.gz && \
    mv kubens /usr/local/bin/ && \
    rm kubens.tar.gz

# Install kubectx
ARG KUBECTX_VERSION=0.9.5
RUN curl -L https://github.com/ahmetb/kubectx/releases/download/v${KUBECTX_VERSION}/kubectx_v${KUBECTX_VERSION}_linux_x86_64.tar.gz -o kubectx.tar.gz && \
    tar -xzvf kubectx.tar.gz && \
    mv kubectx /usr/local/bin/ && \
    rm kubectx.tar.gz

# Install bash-it
RUN git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it && \
    ~/.bash_it/install.sh --silent

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*
