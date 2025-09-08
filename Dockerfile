FROM mcr.microsoft.com/devcontainers/go:1.25-bookworm

# dependencies
RUN apt upgrade && apt update && apt install -y curl python3

# create a symlink for python3 as python
RUN ln -s /usr/bin/python3 /usr/bin/python

# non-root USER
USER vscode

# Install the necessary Go tools
RUN go install golang.org/x/tools/gopls@latest
RUN go install github.com/cweill/gotests/gotests@latest
RUN go install github.com/josharian/impl@latest
RUN go install github.com/go-delve/delve/cmd/dlv@latest
RUN go install honnef.co/go/tools/cmd/staticcheck@latest

# SET theme for oh-my-zsh
# That is alraedy installed in the base image
RUN sed -i 's/ZSH_THEME="devcontainers"/ZSH_THEME="strug"/' "/$HOME/.zshrc"

WORKDIR /workspace
# That step is going to be executed in devcontainer/docker-compose.yml
# Keeps the container running
# CMD [ "tail", "-f", "/dev/null"]
CMD [ "sleep", "infinity" ]