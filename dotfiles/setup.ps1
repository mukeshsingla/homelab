wsl --update
wsl --install Ubuntu-26.04

[System.Environment]::SetEnvironmentVariable("OLLAMA_HOST", "0.0.0.0:11434", "Machine")
[System.Environment]::SetEnvironmentVariable("OLLAMA_ORIGINS", "*", "Machine")
[System.Environment]::SetEnvironmentVariable("OLLAMA_KEEP_ALIVE", "1h", "Machine")
[System.Environment]::SetEnvironmentVariable("OLLAMA_MODELS", "E:\\ollama\\models", "Machine")
[System.Environment]::SetEnvironmentVariable("OLLAMA_CONTEXT_LENGTH", "65536", "Machine")
[System.Environment]::SetEnvironmentVariable("OLLAMA_KV_CACHE_TYPE", "q8_0", "Machine")
[System.Environment]::SetEnvironmentVariable("OLLAMA_FLASH_ATTENTION", "1", "Machine")
[System.Environment]::SetEnvironmentVariable("OLLAMA_NUM_GPUS", "-1", "Machine")
[System.Environment]::SetEnvironmentVariable("OLLAMA_MAX_LOADED_MODELS", "4", "Machine")
[System.Environment]::SetEnvironmentVariable("OLLAMA_NUM_PARALLEL", "4", "Machine")

# [System.Environment]::SetEnvironmentVariable("OLLAMA_SCHED_SPREAD", "1", "Machine")

