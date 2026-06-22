# ============================================================================
# create-multiple-wsl-distros.ps1
# Creates separate Ubuntu 24.04 instances for different purposes (vLLM, Ollama, etc.)
# ============================================================================

# Configuration
$BASE_DISTRO = "Ubuntu-26.04"
$STORAGE_ROOT = "D:\WSL"
$DISTROS = @{
    "Ubuntu-vLLM" = "CUDA 12.9 + vLLM + Docker for GPU inference"
    "Ubuntu-dev" = "Development environment"
}

# Ensure WSL is installed
Write-Host "Checking WSL installation..." -ForegroundColor Cyan
if (-not (wsl --version)) {
    Write-Host "WSL not installed. Installing WSL..." -ForegroundColor Yellow
    wsl --install -d $BASE_DISTRO
    wsl --shutdown
}

# Create storage directory
New-Item -ItemType Directory -Path $STORAGE_ROOT -Force | Out-Null

# Install base Ubuntu if not exists
if (-not (wsl -l | Select-String $BASE_DISTRO)) {
    Write-Host "Installing base $BASE_DISTRO..." -ForegroundColor Cyan
    wsl --install -d $BASE_DISTRO
    wsl -d $BASE_DISTRO -e bash -c "sudo apt update && sudo apt upgrade -y"
}

# Export base Ubuntu as tarball
$BASE_TAR = "$STORAGE_ROOT\base-ubuntu.tar"
Write-Host "Exporting base Ubuntu to $BASE_TAR..." -ForegroundColor Cyan
wsl --export $BASE_DISTRO $BASE_TAR

# Create each distro
foreach ($distroName in $DISTROS.Keys) {
    $purpose = $DISTROS[$distroName]
    $distroPath = "$STORAGE_ROOT\$distroName"
    
    Write-Host "Creating $distroName ($purpose)..." -ForegroundColor Cyan
    
    # Create directory
    New-Item -ItemType Directory -Path $distroPath -Force | Out-Null
    
    # Import distro
    wsl --import $distroName $distroPath $BASE_TAR
    
    Write-Host "✓ Created $distroName" -ForegroundColor Green
}

# Clean up
#Remove-Item $BASE_TAR -Force

# List all distros
Write-Host "\nAll WSL Distributions:" -ForegroundColor Cyan
wsl -l -v

Write-Host "\nNext steps:" -ForegroundColor Yellow
Write-Host "1. wsl -d Ubuntu-vLLM      # Setup vLLM" -ForegroundColor White
Write-Host "2. wsl -d Ubuntu-dev       # Setup development environment" -ForegroundColor White
