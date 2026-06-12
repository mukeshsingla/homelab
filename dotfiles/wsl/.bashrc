
# Set environment variables for Ollama API
export OLLAMA_HOST=http://localhost:11434

# Set environment variables for Anthropic API
export ANTHROPIC_AUTH_TOKEN=ollama
export ANTHROPIC_API_KEY=""
export ANTHROPIC_BASE_URL=http://localhost:11434

export CLAUDE_CODE_MAX_OUTPUT_TOKENS=100000

# Add ~/.local/bin to PATH for user-installed Python packages and other tools
export PATH="$HOME/.local/bin:$PATH"
