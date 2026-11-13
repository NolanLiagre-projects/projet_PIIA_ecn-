#!/usr/bin/env bash
# Runs once when the container is created. Safe to re-run by hand:
# `ollama pull` does nothing if the model is already downloaded.
set -euo pipefail
trap 'echo "post-create: failed at line $LINENO" >&2' ERR

bash .devcontainer/start-ollama.sh

MODEL="${OLLAMA_DEFAULT_MODEL:-gemma3:1b}"
echo "==> downloading $MODEL (first time only)"
ollama pull "$MODEL"

echo "==> check"
python --version
ollama --version
ollama list
if grep -q "cloud disabled: true" "$HOME/.ollama/serve.log"; then
    echo "==> ok: Ollama cloud disabled, everything stays local"
else
    echo "==> warning: could not confirm Ollama cloud is disabled, see ~/.ollama/serve.log" >&2
fi
