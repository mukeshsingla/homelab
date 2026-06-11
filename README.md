# Setup homelab

## Host Setup
- Install Ollama
- Install WSL 2 *(Powershell/Command Prompt as Administrator)*
  - ```.\install.ps1```
    - Verify if below steps are needed
      ```
      wsl --list --online
      wsl --install
      wsl --status
      wsl --list --verbose
      ```
- Install Docker (optional)
  - Settings → Resources → CPUs + Memory slightly higher than WSL’s own limits *(e.g., 6‑8 GB)*.
- Install VS Code

### Reset

## WSL2
- Setup
  - ```
    # Clone the homelab repository
    cd ~
    mkdir -p playground/{git-repo,other-repo,incubator}
    cd playground/git-repo
    git clone https://github.com/mukeshsingla/homelab.git
    cd homelab/dotfiles
    ./install.sh
    ```
  - Logout and login again
    - ```logout```
  - Verify docker
    - ```sudo service docker status```
- Run from linux prompt but make sure ollama is running
  - ```
    cd ~/playground/
    claude --model qwen3.5:9b
    ```

### VS Code (Remote-WSL)
1. Open VS Code.
2. Install "Remote‑WSL" and "Remote‑Containers".
3. Open WSL window: Ctrl+Shift+P → "Remote‑WSL: New Window".
4. Open your project folder from within WSL.
5. Install plugins:
   1. Markdown All in One
   2. Python
6. Setup Copilot to use Ollama model - qwen3.5:9b

### Reset
  - Take backup, before resetting
  - Powershell/Command Prompt *(as Administrator)*
    - ```wsl --unregister <distro_name>```
  - From Windows
    - **System > System Components > Windows Subsystem for Linux > Advanced Options > Reset**
  - Reinstall from the Microsoft Store, or launch it again if your setup uses the Store app

## Docker
- Setup network
  - ```docker network create hl-proxy-net```
- Setup volume
  - ```docker volume create miniflux-db```
- Pull and run docker containers
  - ```
      cd F:\development\docker\homelab\
      docker compose -f docker-compose.yml up -d
    ```
- Restarting a service *(defined in docker-compose.yml)* from docker containers
  - ```docker compose up -d --no-deps <service_name>```
- For removing all containers
    - ```docker compose down --volumes```

## Ollama
- ```ollama create gemma4-opt -f .\ModelFile.gemma```
- ```ollama show --modelfile qwen3.5:9b```

## Development

### Python

#### Setup
- Create virtual env
  - ```
    python3 -m venv myproject
    source myproject/bin/activate'''
- Now install packages inside the env:
  - ```
    pip install requests
    deactivate
    ```

#### Teardown
- ```deactivate```
- ```rm -r venv```

## Host Health
- Powershell/Command Prompt *(Adminstrator)*
```
DISM /Online /Cleanup-Image /RestoreHealth
sfc /scannow
chkdsk C: /f
```