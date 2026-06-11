## Moving the WSL2 Virtual Disk (`.vhdx`) to Another Drive

If your `C:` drive is running out of space due to heavy Docker images or homelab data, you cannot simply cut-and-paste the `.vhdx` file in Windows Explorer—doing so will break WSL2 entirely. Instead, you must safely **export and import** it using the WSL command-line tool.

*We will use moving **Ubuntu** to the **D:** drive as an example.*

### 1. Shut Down WSL

Open **PowerShell** as an Administrator and freeze the WSL engine completely so no files are locked:

```powershell
wsl --shutdown

```

### 2. Export Your Current Distro

Create a backup `.tar` archive of your existing environment. Create a temporary folder (like `D:\backup`) and run:

```powershell
wsl --export Ubuntu D:\backup\ubuntu-backup.tar

```

*(This might take a few minutes depending on how big your environment is).*

### 3. Unregister the Old Distro (Deletes the old `C:` disk)

This safely wipes the old instance off your `C:` drive and unlinks it from Windows:

```powershell
wsl --unregister Ubuntu

```

### 4. Import the Distro to the New Location

Create the permanent folder where you want the disk to live (e.g., `D:\WSL\Ubuntu`). Then, import the backup back into the system at that exact path:

```powershell
wsl --import Ubuntu D:\WSL\Ubuntu D:\backup\ubuntu-backup.tar

```

Windows will unpack the archive and generate a brand-new, fully functional `ext4.vhdx` file directly inside `D:\WSL\Ubuntu`.

### 5. Fix the Default User (Crucial)

---

#### Method 1: The Registry Fix (Easiest & Cleanest)

Windows keeps track of your WSL default users inside the Windows Registry. You can change this value with a single PowerShell command.

1. Open your WSL2 Ubuntu terminal and find your exact Linux username if you forgot it:
```bash
whoami

```


2. Open **Windows PowerShell** (not inside WSL) and run this command to find the unique ID (UID) of your user account inside Linux:
```powershell
wsl -d Ubuntu id -u your-linux-username

```


*(It will almost certainly spit out **`1000`**—which is the standard default UID for the primary user in Linux).*
3. Run this command in **PowerShell** to automatically swap the default user from root (`0`) to your normal account (`1000` or whatever UID was returned):
```powershell
Get-ChildItem "HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss" | 
    ForEach-Object { 
        if ((Get-ItemProperty $_.PsPath).DistributionName -eq "Ubuntu") { 
            Set-ItemProperty $_.PsPath -Name DefaultUid -Value 1000 
        } 
    }

```


4. Restart WSL to apply the change:
```powershell
wsl --shutdown

```



When you launch Ubuntu again, you’ll be logged back into your normal account.

---

#### Method 2: The `wsl.conf` Fix (Inside Linux)

If you prefer modifying text configurations directly over running PowerShell registry scripts, you can tell the Linux subsystem itself to force your username on boot.

1. Launch your imported Ubuntu distro (it will log you in as `root`).
2. Create or edit the WSL system configuration file:
```bash
nano /etc/wsl.conf

```


3. Add the following lines to the file (replace `your-linux-username` with your actual account name):
```ini
[user]
default=your-linux-username

```


4. Save and exit (`Ctrl+O`, then `Enter`, then `Ctrl+X`).
5. Go back to Windows PowerShell and completely kill the WSL engine so it re-reads the config file:
```powershell
wsl --shutdown

```


Did either of those options get you back into your proper home directory context?

*(Once verified, you can safely delete the temporary `D:\backup\ubuntu-backup.tar` file).*

---
