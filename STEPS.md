# ▶️ Execution Steps — Task 10 (Windows PowerShell)

> ⚠️ **Honest note:** A GitHub Actions workflow (`.github/workflows/ci-cd.yml`) only actually RUNS on GitHub's own servers, after you `git push` this folder to a real GitHub repository — it cannot run by double-clicking anything locally. Below are two parts: (A) commands to test everything LOCALLY first with zero errors, and (B) how to activate the real pipeline on GitHub afterward.

```powershell
cd path\to\Task10_CICD
```

## Part A — Test everything locally first (this always works on your laptop)

### Step 1: Build the image (with commit-sha style tag)
```powershell
docker build -t proedge/app:local -t proedge/app:latest .
```

### Step 2: Run unit tests inside a temporary container
```powershell
docker run --rm proedge/app:local python -m pytest test_app.py -v
```

### Step 3: Run integration tests with docker-compose.test.yml
```powershell
docker compose -f docker-compose.test.yml up --build --abort-on-container-exit
docker compose -f docker-compose.test.yml down
```

### Step 4: Security scan with Trivy
```powershell
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image --exit-code 1 --severity CRITICAL proedge/app:local
```

### Step 5: Generate SBOM (Software Bill of Materials)
```powershell
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v ${PWD}:/out `
  aquasec/trivy image --format cyclonedx --output /out/sbom.json proedge/app:local
```

### Step 6: Run the app and check health
```powershell
docker run -d --name t10-app -p 5000:5000 proedge/app:local
curl http://localhost:5000/health
docker rm -f t10-app
```

## Part B — Activate the real pipeline on GitHub (optional, needs a GitHub account)
```powershell
git init
git add .
git commit -m "Initial CI/CD pipeline demo"
git branch -M main
git remote add origin https://github.com/<your-username>/<your-repo>.git
git push -u origin main
```
Then in GitHub: **Settings → Secrets and variables → Actions**, add:
- `DOCKERHUB_USER`
- `DOCKERHUB_TOKEN`

Also set up **Settings → Environments** for `staging` and `production` with a required reviewer, so the pipeline pauses for manual approval exactly like the task asks.

Push a commit — go to the **Actions** tab on GitHub to watch build → test → scan → push → deploy run automatically.
