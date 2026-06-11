# Set environment variables for Ollama API
export OLLAMA_HOST=http://192.168.0.100:11434

# Set environment variables for Anthropic API
export ANTHROPIC_AUTH_TOKEN=ollama
export ANTHROPIC_API_KEY=""
export ANTHROPIC_BASE_URL=http://192.168.0.100:11434

# Add ~/.local/bin to PATH for user-installed Python packages and other tools
export PATH="$HOME/.local/bin:$PATH"
