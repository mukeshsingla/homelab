
# Set environment variables for Ollama API
export OLLAMA_HOST=http://192.168.0.100:11434

# Set environment variables for Anthropic API
export ANTHROPIC_AUTH_TOKEN=ollama
export ANTHROPIC_API_KEY=""
export ANTHROPIC_BASE_URL=http://192.168.0.100:11434

# export ANTHROPIC_DEFAULT_HAIKU_MODEL=llama3.2:latest
# export ANTHROPIC_DEFAULT_SONNET_MODEL=qwen3-vl:8b
# export ANTHROPIC_DEFAULT_OPUS_MODEL=qwen3.5-coder:latest
# export ANTHROPIC_DEFAULT_FABLE_MODEL=gemma4:12b

export CLAUDE_CODE_MAX_OUTPUT_TOKENS=100000

# Add ~/.local/bin to PATH for user-installed Python packages and other tools
export PATH="$HOME/.local/bin:$PATH"
