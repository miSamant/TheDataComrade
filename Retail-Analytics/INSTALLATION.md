# Installation Guide — Windows & Mac

Install three things: **Python**, **PostgreSQL**, and **Metabase**. Pick your
OS below. Total time: ~20–30 minutes.

---

## macOS

### 1. Install Homebrew (if you don't already have it)

Open **Terminal** and run:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
Follow the on-screen instructions (it may ask you to run 1–2 more commands
to add Homebrew to your PATH — copy/paste exactly what it tells you).

### 2. Install Python

```bash
brew install python
python3 --version
```
Should print `Python 3.9` or higher.

### 3. Install PostgreSQL

```bash
brew install postgresql@16
brew services start postgresql@16
```

Add it to your PATH (Homebrew usually tells you the exact line — if not):
```bash
echo 'export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

Verify it's running and create your project database:
```bash
psql --version
createdb retail_analytics
psql -d retail_analytics -c "SELECT version();"
```

If `createdb` fails with a role/permission error, first run:
```bash
createuser -s postgres
```

### 4. Install Metabase (via Docker — recommended, easiest to remove later)

Install Docker Desktop: https://www.docker.com/products/docker-desktop/
(download the Mac version — Apple Silicon or Intel, matching your Mac).
Open it once so the whale icon appears in your menu bar.

Then run:
```bash
docker run -d -p 3000:3000 --name metabase metabase/metabase
```

Open **http://localhost:3000** in your browser after ~30 seconds.

> **Alternative (no Docker):** download the Metabase JAR from
> https://www.metabase.com/start/oss/jar, then run:
> ```bash
> brew install openjdk@21
> java -jar metabase.jar
> ```
> Same result, just running directly on Java instead of in a container.

### 5. Connecting Metabase (Docker) to Postgres (Homebrew, on your Mac)

Since Postgres runs directly on your Mac but Metabase runs inside Docker,
use this special hostname instead of `localhost` when adding the database
in Metabase's UI:
```
host.docker.internal
```

---

## Windows

### 1. Install Python

Go to https://www.python.org/downloads/ and download the latest Python 3
installer.

**Important:** on the first installer screen, check the box **"Add
python.exe to PATH"** before clicking Install.

Verify (open **Command Prompt** or **PowerShell**):
```powershell
python --version
```

### 2. Install PostgreSQL

Download the installer from https://www.postgresql.org/download/windows/
(this uses the EDB installer). Run it and:
- Keep the default install directory
- When asked, set a password for the `postgres` superuser — **remember
  this**, you'll need it in `03_load_to_postgres.py`
- Keep the default port `5432`
- You can uncheck "Stack Builder" at the end, it's not needed

Add PostgreSQL's `bin` folder to your PATH (the installer sometimes does
this automatically — check first):
```powershell
psql --version
```
If that fails, add it manually: search **"Environment Variables"** in the
Start menu → *Edit the system environment variables* → *Environment
Variables* → under *System variables*, select `Path` → *Edit* → *New* →
add (adjust version number to what you installed):
```
C:\Program Files\PostgreSQL\16\bin
```
Close and reopen your terminal, then re-check `psql --version`.

Create your project database:
```powershell
createdb -U postgres retail_analytics
```
(It will prompt for the password you set during install.)

### 3. Install Metabase (via Docker — recommended)

Install Docker Desktop for Windows: https://www.docker.com/products/docker-desktop/
During install, keep **"Use WSL 2 instead of Hyper-V"** checked if prompted
(this is the default and recommended option). Restart if asked.

Once Docker Desktop is running (whale icon in the system tray), open
**PowerShell** and run:
```powershell
docker run -d -p 3000:3000 --name metabase metabase/metabase
```

Open **http://localhost:3000** in your browser after ~30 seconds.

> **Alternative (no Docker):** download the Metabase JAR from
> https://www.metabase.com/start/oss/jar, install Java if you don't have it
> (https://adoptium.net/, pick the LTS version), then run:
> ```powershell
> java -jar metabase.jar
> ```

### 4. Connecting Metabase (Docker) to Postgres (installed on Windows)

Same as Mac — since Postgres runs directly on Windows but Metabase runs
inside a Docker container, use this hostname instead of `localhost` when
adding the database connection in Metabase's UI:
```
host.docker.internal
```

---

## Common issues (both OS)

| Problem | Fix |
|---|---|
| `psql: command not found` | PATH isn't set — see the PATH steps above for your OS |
| Metabase can't connect to Postgres | Use `host.docker.internal` instead of `localhost` if Metabase is in Docker |
| `password authentication failed` | Double check `DB_PASSWORD` in `03_load_to_postgres.py` matches what you set during Postgres install |
| Port `5432` already in use | You may have a previous Postgres instance running — stop it, or use a different port and update it everywhere (schema connection, load script, Metabase) |
| Port `3000` already in use | Run Metabase on a different port: `docker run -d -p 3001:3000 --name metabase metabase/metabase`, then visit `localhost:3001` |
| `pip install psycopg2-binary` fails | Make sure you're using the venv's pip (`pip`, not `pip3` outside the venv), and that Python is 3.9+ |

## Uninstalling / cleaning up later

```bash
# Stop and remove the Metabase container
docker stop metabase && docker rm metabase

# Mac: uninstall Postgres
brew uninstall postgresql@16

# Windows: uninstall via "Add or Remove Programs" -> PostgreSQL
```
