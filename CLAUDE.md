# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **homelab WSL2 setup repository** containing:
- Shell scripts for automated Windows/WSL provisioning (`dotfiles/install.sh`, `install.ps1`)
- Docker configuration files and compose services
- Configuration templates (`.bashrc`, `.aliases` for dotfiles)
- Documentation about migrating/relocating the virtual disk to another drive

## Architecture & Structure

```
.├── README.md                      # Host setup, reset procedures, WSL/docker instructions
├── references.md                   # RSS feed subscriptions and external links  
├── docker-compose.yml              # Docker services for homelab deployment
│    └── ... (defined compose file) ├── dotfiles/                           # Provisioned system files
│        ├── install.sh             # Linux WSL setup script
│        ├── host/.wslconfig        # WSL-specific engine settings (copy to Windows profile)
│       ├── wsl/                    # ~/.bashrc, .aliases and other shell configs
│          └── cleanup.sh           # Temporary file/cleanup utilities├── docs/wsl.md                    # Migration guide for moving .vhdx disk between drives
```

## Key Workflows & Commands

### Common Operations from README.md

**Run the project:**
- From WSL: `claude --model qwen3.5:9b` to launch Claude locally using Ollama model configuration  
- Run Docker services in detached mode with a specific service and its dependencies omitted for quick restarts:
  ```bash
  docker compose -f docker-compose.yml up -d && docker compose up -d --no-deps <service_name>
```

**Remove all containers:** 
```bash
docker compose down --volumes   # Removes volumes but NOT base images on host filesystem
```

### WSL Reset Procedure (from README)

When reinstalling from scratch:
1. Take backup of current environment first before running reset commands!
2. PowerShell/Command Prompt **(as Administrator)** → `wsl --unregister <distro_name>`  
3. Reinstall via Microsoft Store or re-run the install script if using Windows packages

**Resetting WSL after disk migration:**
- See [`docs/wsl.md`](./docs/wsl.md) for step-by-step: export distro, unregister old instance, import to new drive location (D:) then fix default user identity in registry with `wsl --shutdown` between steps.

### Docker Management Commands

**Setup initial network and volumes:**
```bash
docker network create hl-network && docker volume create miniflux-db   # Required before running containers for networking/DB persistence
```

**Pull and start services defined in compose file:**  
From the project root (`cd ~/playground/git-repo/homelab`), run: `docker compose -f docker-compose.yml up -d` (use `-c=compose-file-name.yml` to specify alternate Docker Compose files if present).

### Python Development Setup  

**Create/activate virtualenv:**
```bash
python3 -m venv myproject && source ./myproject/bin/activate   # Then install deps: pip install <package>...
deactivate || rm -r venv  # Teardown after use (if env is not used anymore)
```

## References Included in this Repo

From `references.md`:  
- **RSS feeds** for ML/AI blog subscriptions and news aggregation including HuggingFace, NVIDIA developer blogs, OpenAI RSS channels, arXiv CS.AI topics — useful to document when adding new data ingestion workflows.
