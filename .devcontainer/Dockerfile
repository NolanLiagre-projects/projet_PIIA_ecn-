# Python + a local Ollama server in one container. Nothing here talks to a
# hosted LLM: the model runs inside this container, on this machine.
#
# Ollama is copied out of its official image instead of using that image as
# the base: the devcontainers Python image already has the `vscode` user at
# UID 1000 (no user juggling), and a multi-arch image means this works on
# x86 PCs and on Apple Silicon Macs alike.
ARG OLLAMA_VERSION=0.40.16
FROM ollama/ollama:${OLLAMA_VERSION} AS ollama

FROM mcr.microsoft.com/devcontainers/python:3.12-bookworm

COPY --from=ollama /usr/bin/ollama /usr/bin/ollama
COPY --from=ollama /usr/lib/ollama /usr/lib/ollama

# Python packages the project code uses (ollama client, pydantic for
# structured output, requests for the AniList API, a Jupyter kernel).
# Installed into the image, so they survive a rebuild and never land in the
# repo folder.
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt && rm /tmp/requirements.txt

# Pre-create the models folder owned by vscode: the empty named volume
# mounted here copies this ownership instead of coming up root-owned.
RUN mkdir -p /home/vscode/.ollama && chown vscode:vscode /home/vscode/.ollama
