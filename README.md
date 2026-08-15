Azure Infrastructure as Code with Terraform and GitHub Actions

Project Overview

This project demonstrates a production-oriented approach to deploying Microsoft Azure infrastructure using **Terraform Infrastructure as Code (IaC)** and **GitHub Actions**.

The project implements a modular Terraform architecture together with a CI/CD and DevSecOps workflow covering infrastructure validation, security scanning, cost analysis, Terraform planning, and automated deployment.

The pipeline uses **GitHub OpenID Connect (OIDC)** for passwordless authentication with Microsoft Entra ID, eliminating the need for long-lived Azure client secrets in GitHub.


Architecture Overview

The infrastructure follows a modular Terraform architecture with reusable child modules orchestrated by a parent module.

 High-Level Workflow


Developer
    |
    v
Feature Branch
    |
    v
Pull Request
    |
    v
GitHub Actions
    |
    +-----------------------------+
    |                             |
    v                             v
DevSecOps Checks            Terraform CI
    |                             |
    +-- Gitleaks                  +-- fmt
    +-- Trivy                     +-- TFLint
    +-- Checkov                   +-- Validate
                                  +-- Init
                                  +-- Plan
    |                             |
    +-------------+---------------+
                  |
                  v
             Infracost
           Cost Analysis
                  |
                  v
             Code Review
                  |
                Merge
                  |
                  v
              main branch
                  |
                  v
           Azure OIDC Login
                  |
                  v
          Terraform Apply
                  |
                  v
        Azure Infrastructure


Key Features

* Infrastructure as Code using Terraform
* Modular Terraform architecture
* Reusable Terraform child modules
* Azure remote Terraform state
* Git-based feature branch workflow
* Pull Request-based CI
* Automated Terraform planning
* Automated deployment after merge to `main`
* GitHub OIDC authentication with Microsoft Entra ID
* No long-lived Azure client secrets
* Gitleaks secret scanning
* Trivy security and IaC scanning
* Checkov Terraform security scanning
* TFLint static analysis
* Infracost infrastructure cost analysis
* Terraform plan artifact generation
* GitHub Actions pipeline summaries

 Technologies Used

| Technology         | Purpose                                             |
| ------------------ | --------------------------------------------------- |
| Microsoft Azure    | Cloud infrastructure                                |
| Terraform          | Infrastructure as Code                              |
| HCL                | Terraform configuration                             |
| GitHub             | Source control and collaboration                    |
| GitHub Actions     | CI/CD automation                                    |
| Microsoft Entra ID | Workload identity authentication                    |
| Azure OIDC         | Passwordless CI/CD authentication                   |
| Azure CLI          | Azure management                                    |
| Checkov            | IaC security scanning                               |
| Trivy              | Vulnerability, misconfiguration and secret scanning |
| Gitleaks           | Secret detection                                    |
| TFLint             | Terraform linting                                   |
| Infracost          | Infrastructure cost analysis                        |
| VS Code            | Development environment                             |



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
│   │
│   ├── main.tf
│   ├── variables.tf
│   ├── terraform.tfvars
│   ├── provider.tf
│   ├── backend.tf
│   └── outputs.tf
│
├── .github
│   └── workflows
│       └── terraform.yml
│
├── docs
│   ├── azure-terraform-architecture.png
│   └── github-actions-pipeline.png
│
└── README.md
Terraform Workflow

Terraform is used to provision and manage the Azure infrastructure.

Initialize Terraform

Initializes the working directory, downloads providers and configures the remote backend.

terraform init
Format Terraform Code

Checks Terraform formatting.

terraform fmt -check -recursive
Validate Configuration

Validates Terraform configuration and syntax.

terraform validate
Run TFLint

Performs Terraform static analysis and identifies potential configuration issues and best-practice violations.

tflint
Generate Terraform Plan

Creates an execution plan showing the infrastructure changes that Terraform intends to make.

terraform plan -out=tfplan
Apply Infrastructure

The generated Terraform plan is applied after the Pull Request is merged into the main branch.

terraform apply tfplan
DevSecOps Pipeline

Security checks are integrated into the CI pipeline so that infrastructure changes are evaluated before deployment.

Pull Request
     |
     +---- Gitleaks
     |
     +---- Trivy
     |
     +---- Checkov
     |
     +---- TFLint
     |
     +---- Terraform Validate
     |
     +---- Terraform Plan
     |
     +---- Infracost
     |
     v
Code Review
Gitleaks

Gitleaks scans the repository for accidentally committed secrets such as:

API keys
Access tokens
Passwords
Private keys
Cloud credentials
Trivy

Trivy is used for broader security scanning, including:

Vulnerability detection
Infrastructure as Code misconfigurations
Secret detection
Checkov

Checkov analyzes Terraform configuration against security and compliance policies.

Examples include detecting:

Insecure network configurations
Missing encryption
Publicly exposed resources
Weak security configurations
TFLint

TFLint performs Terraform static analysis and helps identify:

Configuration errors
Provider-specific issues
Terraform best-practice violations
Infrastructure Cost Analysis

Infracost is integrated into Pull Requests to provide visibility into the potential cost impact of infrastructure changes.

The objective is to allow infrastructure cost to be reviewed before changes are merged.

Terraform Change
       |
       v
Infracost
       |
       v
Base vs Proposed Infrastructure
       |
       v
Estimated Monthly Cost Difference
       |
       v
Pull Request Review

This provides developers and reviewers with cost information before infrastructure is deployed.

GitHub OIDC Authentication

The pipeline uses GitHub OpenID Connect instead of storing a long-lived Azure client secret.

GitHub Actions
      |
      | OIDC Token
      v
Microsoft Entra ID
      |
      | Federated Credential Validation
      v
Azure Service Principal
      |
      | RBAC
      v
Azure Subscription

The GitHub workflow is granted:

permissions:
  contents: read
  id-token: write

The id-token: write permission allows GitHub Actions to request an OIDC token.

Microsoft Entra ID validates the token against the configured Federated Credentials before granting Azure access.

Benefits
No long-lived client secret
Short-lived authentication tokens
Reduced credential exposure
Fine-grained trust between GitHub and Azure
Better alignment with cloud security best practices
Federated Credentials

The Azure App Registration uses separate federated credentials for different GitHub Actions events.

Main Branch

Used when changes are pushed to main.

Branch → main
Pull Requests

Used when the workflow runs from a Pull Request.

Entity Type → Pull Request

This is required because GitHub generates different OIDC subject claims for branch and Pull Request workflows.

Terraform Remote State

Terraform state is stored remotely using an Azure Storage Account.

Example backend configuration:

terraform {
  backend "azurerm" {
    resource_group_name  = "backend-rg"
    storage_account_name = "terraformstate"
    container_name       = "tfstate"
    key                  = "preprod.terraform.tfstate"
  }
}
Benefits
Centralized state management
Persistent state
Team collaboration
State locking
Reduced risk of state conflicts
Separation between infrastructure code and state
Terraform Module Architecture

The project follows a parent-child module architecture.

Parent Module
      |
      +---- Resource Group Module
      |
      +---- Network Module
      |
      +---- Subnet Module
      |
      +---- Public IP Module
      |
      +---- Network Interface Module
      |
      +---- Virtual Machine Module
Parent Module

Responsible for:

Calling child modules
Passing variables
Managing dependencies
Infrastructure orchestration
Child Modules

Provide reusable infrastructure components such as:

Resource Groups
Networking
Subnets
Public IPs
Network Interfaces
Virtual Machines
Git Workflow

The project follows a feature branch and Pull Request workflow.

main
 |
 +---- feature/infra
          |
          v
      Pull Request
          |
          v
      CI Pipeline
          |
          v
        Review
          |
          v
        Merge
          |
          v
         main
          |
          v
    Terraform Apply

Example:

git checkout main
git pull origin main


git checkout -b feature/storage-account


git add .
git commit -m "Add storage account module"


git push origin feature/storage-account

A Pull Request is then created against main.

GitHub Actions CI/CD

The pipeline is event-driven.

Pull Request

Pull Requests perform validation, security scanning, planning and cost analysis.

Pull Request
     |
     +-- Terraform Format
     |
     +-- Gitleaks
     |
     +-- Trivy
     |
     +-- TFLint
     |
     +-- Terraform Validate
     |
     +-- Checkov
     |
     +-- Azure OIDC
     |
     +-- Terraform Init
     |
     +-- Terraform Plan
     |
     +-- Infracost

No infrastructure is applied during the Pull Request.

Merge to Main

After the Pull Request is merged:

Push to main
     |
     v
Azure OIDC Authentication
     |
     v
Terraform Init
     |
     v
Terraform Plan
     |
     v
Terraform Apply
     |
     v
Azure Infrastructure

This ensures infrastructure changes are deployed only after the code review process is completed.

Security Model

The project follows several security principles:

No hardcoded Azure credentials
GitHub OIDC instead of long-lived client secrets
Azure RBAC for authorization
Federated identity credentials
Pull Request security scanning
Secret detection with Gitleaks
IaC security scanning with Checkov
Trivy security scanning
Terraform validation before deployment
Remote and centrally managed Terraform state
CI/CD Benefits
Before Automation
Manual Azure Portal deployment
Increased configuration drift
Higher probability of human error
Limited infrastructure visibility
Manual security checks
No automated cost analysis
After Automation
Repeatable infrastructure deployment
Version-controlled infrastructure
Automated security checks
Automated Terraform validation
Pull Request-based review
Infrastructure cost visibility
Auditable infrastructure changes
Secure cloud authentication
Automated Azure deployment
Future Enhancements

Potential improvements include:

Multi-environment Terraform deployments
Development
Pre-Production
Production
GitHub Environment approval gates
Terraform policy enforcement
Azure Key Vault integration
Azure Policy integration
Centralized logging and monitoring
Automated drift detection
Terraform test automation
Production deployment approvals
Author

Mahesh Funde

Aspiring Cloud / DevOps Engineer

Skills: Azure | Terraform | GitHub Actions | CI/CD | DevSecOps | Kubernetes

Project Learning Outcome

This project demonstrates an end-to-end Infrastructure as Code and DevSecOps workflow:

Infrastructure Development
          |
          v
Feature Branch
          |
          v
Pull Request
          |
          v
Security & Quality Checks
          |
          v
Terraform Plan
          |
          v
Infrastructure Cost Analysis
          |
          v
Code Review
          |
          v
Merge to Main
          |
          v
OIDC Authentication
          |
          v
Terraform Apply
          |
          v
Azure Infrastructure

The project demonstrates how Terraform, GitHub Actions, Azure OIDC, DevSecOps security tooling, remote state management and infrastructure cost analysis can be combined into a repeatable cloud infrastructure delivery workflow.

Author: Mahesh Funde
