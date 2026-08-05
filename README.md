# 🚀 Azure Infrastructure as Code (IaC) using Terraform with GitHub CI/CD

![Terraform](https://img.shields.io/badge/Terraform-IaC-7B42BC?logo=terraform)
![Azure](https://img.shields.io/badge/Microsoft-Azure-0078D4?logo=microsoftazure)
![GitHub Actions](https://img.shields.io/badge/GitHub-Actions-2088FF?logo=githubactions)
![DevOps](https://img.shields.io/badge/DevOps-Automation-green)

## 📌 Project Overview

This project demonstrates the implementation of a **production-style Azure Infrastructure deployment** using **Terraform Infrastructure as Code (IaC)** along with **GitHub CI/CD workflow**.

The objective of this project is to automate Azure resource provisioning, maintain infrastructure consistency, implement reusable Terraform modules, and establish a secure CI/CD workflow using GitHub Actions.

---

# 🏗️ Architecture Overview

The infrastructure follows a modular Terraform approach:

![Azure Terraform Architecture](./docs/azure-terraform-architecture.png)

```
Developer
    |
    |
GitHub Repository
    |
    |
Feature Branch
    |
    |
Pull Request
    |
    |
GitHub Actions CI/CD Pipeline
    |
    |
Terraform Workflow
    |
    |
Azure Cloud Infrastructure
```

---

# 🔥 Key Features Implemented

✅ Infrastructure as Code using Terraform
✅ Azure Resource Provisioning Automation
✅ Parent and Child Terraform Module Architecture
✅ Reusable Terraform Modules
✅ Remote Terraform State Management
✅ Git Branching Strategy
✅ Pull Request Based Deployment Workflow
✅ GitHub Actions CI/CD Pipeline
✅ Terraform Validation & Planning Automation
✅ Infrastructure Security Best Practices

---

# 🛠️ Technologies Used

| Technology      | Purpose                          |
| --------------- | -------------------------------- |
| Microsoft Azure | Cloud Infrastructure             |
| Terraform       | Infrastructure as Code           |
| GitHub          | Source Code Management           |
| GitHub Actions  | CI/CD Automation                 |
| Azure CLI       | Azure Management                 |
| VS Code         | Development Environment          |
| HCL             | Terraform Configuration Language |

---

# 📂 Repository Structure

```
.
│
├── Child Modules
│   │
│   ├── Resource Group
│   ├── Virtual Network
│   ├── Subnet
│   ├── Public IP
│   ├── Network Interface
│   └── Virtual Machine
│
├── Parent Module
│
│   ├── main.tf
│   ├── variables.tf
│   ├── terraform.tfvars
│   ├── provider.tf
│   └── outputs.tf
│
├── .github
│   └── workflows
│       └── terraform-ci-cd.yml
│
└── README.md
```

---

# 🔄 Terraform Deployment Workflow

## 1. Initialize Terraform

Downloads required providers and initializes backend configuration.

```bash
terraform init
```

---

## 2. Validate Configuration

Checks Terraform syntax and configuration errors.

```bash
terraform validate
```

---

## 3. Terraform Plan

Creates an execution plan before deployment.

```bash
terraform plan
```

---

## 4. Terraform Apply

Deploys infrastructure into Azure.

```bash
terraform apply
```

---

# 🌳 Git Workflow Followed

This project follows a professional Git branching strategy.

```
Main Branch
     |
     |
Development
     |
     |
Feature Branch
```

Example:

```bash
git checkout -b feature/storage-account
```

Add changes:

```bash
git add .
```

Commit changes:

```bash
git commit -m "Added Azure Storage Account Module"
```

Push feature branch:

```bash
git push origin feature/storage-account
```

Create Pull Request → Review → Approval → Merge into Main Branch

---

# ⚙️ GitHub Actions CI/CD Pipeline

The CI/CD pipeline automatically performs:

![GitHub Actions Pipeline](./docs/github-actions-pipeline.png)

```
Code Commit
     |
     |
Terraform Format Check
     |
     |
Terraform Validate
     |
     |
Terraform Plan
     |
     |
Manual Approval
     |
     |
Terraform Apply
```

Pipeline stages:

### Stage 1: Terraform Format

Ensures Terraform code formatting.

```bash
terraform fmt -check
```

---

### Stage 2: Terraform Validation

Checks Terraform configuration.

```bash
terraform validate
```

---

### Stage 3: Terraform Plan

Shows infrastructure changes.

```bash
terraform plan
```

---

### Stage 4: Terraform Apply

Deploys approved changes.

```bash
terraform apply
```

---

# 🔐 Terraform Remote State Management

Terraform state is stored securely in Azure Storage Account.

Benefits:

✔ Centralized state management
✔ Team collaboration
✔ State locking
✔ Prevents configuration conflicts

Backend Example:

```hcl
backend "azurerm" {

resource_group_name  = "backend-rg"

storage_account_name = "terraformstate"

container_name       = "tfstate"

key                  = "prod.terraform.tfstate"

}
```

---

# 📦 Terraform Modules

## Child Modules

Reusable components created for:

* Resource Group
* Networking
* Storage Account
* Virtual Machine
* Security Components

## Parent Module

Responsible for:

* Calling child modules
* Passing variables
* Managing dependencies
* Infrastructure orchestration

Example:

```
Parent Module

      |
      |
      +---- Resource Group Module

      |
      |
      +---- Network Module

      |
      |
      +---- VM Module
```

---

# 🔒 Security Best Practices Implemented

✅ No hardcoded credentials
✅ Remote Terraform state
✅ Branch protection strategy
✅ Pull Request approval workflow
✅ Infrastructure validation before deployment
✅ Secrets management approach

---

# 📊 CI/CD Benefits

Before Automation:

❌ Manual Azure Portal Deployment
❌ Configuration Drift
❌ Human Errors
❌ Slow Infrastructure Delivery

After Automation:

✅ Repeatable Infrastructure
✅ Faster Deployment
✅ Version Controlled Infrastructure
✅ Auditable Changes
✅ DevOps Best Practices

---

# 🚀 Future Enhancements

Planned improvements:

* Add Terraform Security Scanning
* Integrate Checkov
* Integrate Trivy
* Add Infracost Cost Analysis
* Implement Azure Key Vault Integration
* Add Multi Environment Deployment

  * Development
  * Testing
  * Production

---

# 👨‍💻 Author

**Rajeev Kumar**

Senior DevOps / Azure Cloud Engineer

Skills:

Azure | Terraform | GitHub Actions | CI/CD | DevSecOps | Kubernetes

---

# ⭐ Project Learning Outcome

Through this project, I implemented a complete DevOps workflow:

**Infrastructure Development → Git Workflow → Code Review → CI/CD Automation → Azure Deployment**

This project represents a real-world enterprise DevOps implementation approach.