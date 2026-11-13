# Environnement de développement (devcontainer)

Python 3.12 + un serveur [Ollama](https://ollama.com) local, avec le modèle
`gemma3:1b` (petit et rapide). Le modèle tourne sur votre machine : aucun
texte n'est envoyé à un service d'IA en ligne.

## Prérequis

- Docker Desktop (ou Docker sous Linux)
- VS Code avec l'extension **Dev Containers**
- ~3 Go d'espace disque libre (image + modèle)

## Démarrer

1. Ouvrir le dossier du projet dans VS Code.
2. `Ctrl+Shift+P` → **Dev Containers: Reopen in Container**.
3. La première fois, attendre la fin du téléchargement du modèle. Le
   terminal affiche `ok: Ollama cloud disabled`.

Pour vérifier que tout marche, depuis le terminal du conteneur :

```bash
ollama list                       # doit afficher gemma3:1b
ollama run gemma3:1b "Bonjour"    # le modèle répond
```

## Notebooks

À l'ouverture d'un notebook, VS Code demande de choisir un noyau
(*Select Kernel*) : prendre **Python 3.12** (`/usr/local/bin/python`), celui
du conteneur, qui a les paquets installés.

## Bon à savoir

- **Sécurité** : Ollama n'écoute qu'à l'intérieur du conteneur (port non
  exposé) et les modèles `:cloud` sont désactivés (`OLLAMA_NO_CLOUD=1`).
  Internet reste accessible pour le code (ex. l'API AniList).
- **GPU** : utilisé automatiquement s'il y a une carte NVIDIA, sinon le
  modèle tourne sur le processeur.
- **Changer de modèle** : `ollama pull <modèle>` dans le terminal, puis
  changer `model=` dans le code. `ollama list` montre les modèles présents.
- **Paquets Python** : à ajouter dans `.devcontainer/requirements.txt`, puis
  **Dev Containers: Rebuild Container**.
- Si Ollama ne répond plus : `bash .devcontainer/start-ollama.sh`
  (journal : `~/.ollama/serve.log`).
