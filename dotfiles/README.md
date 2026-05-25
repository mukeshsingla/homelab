## Host
- Install Ollama
- Install WSL 2 (Powershell/Command Prompt as Administrator)
  - Run setup.ps1
    - Verify if below steps are needed
      ```
        wsl --install
        wsl --list --online
        wsl --install -d Ubuntu-26.04
        wsl --status
        wsl --list --verbose
      ```
- Install Docker

## WSL2
- Run from linux prompt but make sure ollama is running
  - ```
      cd ~/playground/
      claude --model qwen3.5:9b
    ```

### Post-install performance/usability tweaks
- WSL/filesystem
  - Edit ```%USERPROFILE%\.wslconfig``` (Windows) to tune WSL:
    - ```
        [wsl2]
        memory=8GB
        processors=4
        swap=8GB
        localhostForwarding=true
      ```
  - For heavy workloads:
      - Keep “hot” projects inside WSL (```/home/$USER/src```) rather than ```/mnt/c/...``` to avoid slower win‑fs bind mounts.
- Docker
  - Settings → Resources → CPUs + Memory slightly higher than WSL’s own limits (e.g., 6‑8 GB).



### VS Code (Remote-WSL)
1. Open VS Code.
2. Install "Remote‑WSL" and "Remote‑Containers".
3. Open WSL window: Ctrl+Shift+P → "Remote‑WSL: New Window".
4. Open your project folder from within WSL.
5. Install plugins:
   1. Markdown All in One
   2. Python
6. Setup Copilot to use Ollama model

## Docker
- Pull and run docker containers
```
cd F:\development\docker\homelab\docker-compose.yml
docker compose -f docker-compose.yml up -d
```
- For removing all containers
    - ```docker compose down --volumes```