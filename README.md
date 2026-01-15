# Infra Repo (Terraform) — One EC2 + Docker on boot (OIDC)

## What this creates
- 1x Ubuntu 22.04 EC2 (t3.micro) in **default VPC**
- Security Group inbound:
  - 22 from `MY_IP_CIDR` (set this!)
  - 8082 from 0.0.0.0/0
  - 8088 from 0.0.0.0/0
  - **NO** 1433 exposed
- `user_data` installs Docker + Docker Compose plugin and enables docker
- Outputs:
  - `EC2_PUBLIC_IP`
  - `SSH_COMMAND`

---

## Click-by-click setup (GitHub repo settings)

### 1) Create the repo
1. GitHub → **New repository**
2. Name it: `infra-repo` (any name is fine)
3. Create with README unchecked (optional)
4. Push these files to `main`

### 2) Create an EC2 Key Pair (needed for SSH from app repo)
1. AWS Console → **EC2**
2. Left menu → **Key Pairs**
3. **Create key pair**
4. Name: `three-container-key` (or any)
5. Type: **RSA**
6. Format: **.pem**
7. Download the `.pem` to your PC (keep it safe)
8. Note the key pair name (you will set it as a GitHub variable)

### 3) Get your public IP for SSH restriction
1. Open: https://whatismyipaddress.com/
2. Copy your IP (example: `1.2.3.4`)
3. Make CIDR: `1.2.3.4/32`

### 4) Add GitHub Repository Variables
GitHub repo → **Settings** → **Secrets and variables** → **Actions** → **Variables** → **New repository variable**

Add these variables exactly:

- `AWS_ROLE_ARN` = **(ARN of “GitHub Actions Terraform role”)**
- `AWS_REGION` = `us-east-1`
- `TF_STATE_BUCKET` = `your-unique-tfstate-bucket-name-12345`
- `TF_STATE_DDB_TABLE` = `terraform-locks`
- `TF_STATE_KEY` = `infra/terraform.tfstate`
- `EC2_KEY_NAME` = `three-container-key` (your EC2 Key Pair name)
- `MY_IP_CIDR` = `YOUR_IP/32` (example `1.2.3.4/32`)
- `PROJECT_NAME` = `three-container-app`

> IMPORTANT: `TF_STATE_BUCKET` must be globally unique in AWS.

### 5) Required IAM permissions for the OIDC role
Ensure the role allows (at minimum):
- sts:AssumeRoleWithWebIdentity
- ec2:* (for instance + SG)
- iam:PassRole (if needed)
- s3:* on the tfstate bucket
- dynamodb:* on the lock table

---

## Run it (GitHub Actions)
1. GitHub repo → **Actions**
2. Open workflow: **Terraform (EC2)**
3. Click **Run workflow** (or push to `main`)
4. Wait for the job to finish
5. Open the workflow log → find **Show outputs**
6. Copy:
   - `EC2_PUBLIC_IP`
   - `SSH_COMMAND`

---

## Verify Docker installed (SSH)
1. On your PC, open PowerShell
2. Run the output SSH command (replace key path):
   ```bash
   ssh -i C:\path\to\your.pem ubuntu@EC2_PUBLIC_IP
