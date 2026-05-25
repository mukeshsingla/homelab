!#/bin/bash

sudo apt update && sudo apt upgrade -y

echo 'export OLLAMA_HOST=http://192.168.0.100:11434' >> ~/.bashrc
echo 'export ANTHROPIC_AUTH_TOKEN=ollama' >> ~/.bashrc
echo 'export ANTHROPIC_API_KEY=""' >> ~/.bashrc
echo 'export ANTHROPIC_BASE_URL=http://192.168.0.100:11434' >> ~/.bashrc

source ~/.bashrc

curl http://192.168.0.100:11434/api/tags

curl -fsSL https://claude.ai/install.sh | bash