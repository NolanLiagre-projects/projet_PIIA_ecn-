#!/usr/bin/env bash
# Starts the Ollama server in the background if it is not already running.
# Safe to re-run by hand. Its settings come from containerEnv in
# devcontainer.json, so every instance runs with the same configuration.
set -euo pipefail

URL="http://${OLLAMA_HOST:-127.0.0.1:11434}"
LOG="$HOME/.ollama/serve.log"

# A volume can still come up root-owned (e.g. created by an older image).
sudo chown -R vscode:vscode "$HOME/.ollama" 2>/dev/null || true

if curl -s -o /dev/null "$URL"; then
    echo "==> ollama already running"
    exit 0
fi

echo "==> starting ollama (log: $LOG)"
# setsid + closed stdin: detach fully, or VS Code kills the server when this
# lifecycle command returns.
setsid nohup ollama serve > "$LOG" 2>&1 < /dev/null &

for _ in $(seq 1 30); do
    curl -s -o /dev/null "$URL" && { echo "==> ollama up"; exit 0; }
    sleep 1
done
echo "ollama did not come up, see $LOG" >&2
exit 1
