 Azure Infrastructure as Code with Terraform and GitHub Actions

Project Overview


This project demonstrates a production-oriented approach to deploying Microsoft Azure infrastructure using Terraform Infrastructure as Code (IaC) and GitHub Actions.

The project implements a modular Terraform architecture together with a CI/CD and DevSecOps workflow covering:

- Infrastructure validation
- Terraform linting
- Infrastructure security scanning
- Secret detection
- Cost analysis
- Terraform planning
- Remote state management
- Automated Azure deployment

The pipeline uses GitHub OpenID Connect (OIDC) for passwordless authentication with Microsoft Entra ID, eliminating the need for long-lived Azure client secrets in GitHub.


Architecture Overview
The infrastructure follows a modular Terraform architecture with reusable child modules orchestrated by a parent module.

Infrastructure Architecture


    A[Terraform Parent Module]

    A --> B[Resource Group Module]
    A --> C[Virtual Network Module]
    A --> D[Subnet Module]
    A --> E[Public IP Module]
    A --> F[Network Interface Module]
    A --> G[Virtual Machine Module]

    C --> D
    D --> F
    E --> F
    F --> G

    G --> H[Azure Infrastructure]



CI/CD and DevSecOps Workflow

The pipeline follows a Pull Request-based workflow.




    A[Developer] --> B[Feature Branch]

    B --> C[Pull Request]

    C --> D[GitHub Actions]

    D --> E[Gitleaks]
    D --> F[Trivy]
    D --> G[Checkov]
    D --> H[TFLint]
    D --> I[Terraform Format]
    D --> J[Terraform Validate]
    D --> K[Terraform Plan]
    D --> L[Infracost]

    E --> M[PR Review]
    F --> M
    G --> M
    H --> M
    I --> M
    J --> M
    K --> M
    L --> M

    M --> N{Pull Request Approved?}

    N -->|No| O[Changes Required]
    O --> B

    N -->|Yes| P[Merge to main]

    P --> Q[GitHub Actions]

    Q --> R[Azure OIDC Authentication]
    R --> S[Terraform Init]
    S --> T[Terraform Plan]
    T --> U[Terraform Apply]

    U --> V[Azure Infrastructure]



Key Features

- Infrastructure as Code using Terraform
- Modular Terraform architecture
- Reusable Terraform child modules
- Azure remote Terraform state
- Feature branch development workflow
- Pull Request-based CI
- Automated Terraform validation
- Terraform linting with TFLint
- Secret detection with Gitleaks
- Security and IaC scanning with Trivy
- Terraform security scanning with Checkov
- Infrastructure cost analysis with Infracost
- GitHub Actions CI/CD
- GitHub OIDC authentication
- Microsoft Entra ID Federated Credentials
- Azure RBAC-based authorization
- Automated Terraform deployment after merge to main


Technologies Used

| Technology | Purpose |
|---|---|
| Microsoft Azure | Cloud infrastructure |
| Terraform | Infrastructure as Code |
| HCL | Terraform configuration language |
| GitHub | Source control and collaboration |
| GitHub Actions | CI/CD automation |
| Microsoft Entra ID | Workload identity authentication |
| Azure OIDC | Passwordless CI/CD authentication |
| Azure CLI | Azure management |
| TFLint | Terraform static analysis |
| Gitleaks | Secret detection |
| Trivy | Vulnerability, IaC and secret scanning |
| Checkov | Terraform security scanning |
| Infracost | Infrastructure cost analysis |
| VS Code | Development environment |


Repository Structure



├── Child Modules
│   ├── Resource Group
│   ├── Virtual Network
│   ├── Subnet
│   ├── Public IP
│   ├── Network Interface
│   └── Virtual Machine
│
├── Parent Module
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

Terraform is used to provision and manage Azure infrastructure.


Terraform Init

Initializes the Terraform working directory, downloads required providers and initializes the remote backend.


terraform init


Terraform Format

Checks Terraform code formatting.


terraform fmt -check -recursive


Terraform Validate

Validates Terraform syntax and configuration.


terraform validate



TFLint

Performs static analysis and identifies Terraform configuration issues and best-practice violations.


tflint



Terraform Plan

Generates an execution plan showing the infrastructure changes Terraform intends to make.


terraform plan -out=tfplan



Terraform Apply

Applies the generated Terraform plan and provisions the infrastructure.


terraform apply tfplan


The pipeline restricts terraform apply to the main branch.


DevSecOps Security Pipeline


Security controls are integrated directly into the Pull Request workflow.



    A[Pull Request] --> B[Gitleaks]
    B --> C[Trivy]
    C --> D[Checkov]
    D --> E[TFLint]
    E --> F[Terraform Validate]
    F --> G[Terraform Plan]
    G --> H[Infracost]
    H --> I[Code Review]



Gitleaks

Gitleaks scans the repository for accidentally committed secrets.

It can identify exposed credentials such as:

- API keys
- Access tokens
- Passwords
- Private keys
- Cloud credentials

The objective is to detect secrets before they reach production.


Trivy

Trivy provides broader security scanning for the repository.

The pipeline uses Trivy for:

- Vulnerability scanning
- Infrastructure as Code misconfiguration scanning
- Secret detection

This provides an additional security layer alongside Gitleaks and Checkov.


Checkov

Checkov analyzes Terraform configuration against security and compliance policies.

Examples of issues Checkov can detect include:

- Insecure network configurations
- Publicly exposed resources
- Missing encryption
- Weak security configurations
- Misconfigured cloud resources


TFLint

TFLint performs Terraform static analysis.

It helps identify:

- Terraform configuration issues
- Provider-specific problems
- Invalid or deprecated configurations
- Terraform best-practice violations


Infrastructure Cost Analysis

Infracost is integrated into Pull Requests to provide visibility into the potential financial impact of infrastructure changes.

The objective is to allow infrastructure cost to be reviewed before changes are merged.



    A[Terraform Changes] --> B[Terraform Plan]
    B --> C[Infracost]
    C --> D[Cost Comparison]
    D --> E[Pull Request]
    E --> F[Code Review]


The Pull Request can provide an estimated cost difference between the existing infrastructure and the proposed infrastructure.

Example:


Estimated Monthly Cost

Current Infrastructure:    $XX.XX
Proposed Infrastructure:   $YY.YY

Monthly Difference:        +$ZZ.ZZ


This introduces cost awareness into the infrastructure development lifecycle.


GitHub OIDC Authentication


The pipeline uses GitHub OpenID Connect instead of storing a long-lived Azure client secret.




    participant GH as GitHub Actions
    participant EN as Microsoft Entra ID
    participant AZ as Azure Subscription

    GH->>EN: Request OIDC authentication
    EN->>GH: Validate OIDC token
    GH->>EN: Present federated identity
    EN->>EN: Validate Federated Credential
    EN->>AZ: Issue temporary access token
    AZ->>GH: Authorize Azure operations
```

The workflow requires:

yaml

permissions:
  contents: read
  id-token: write


The id-token: write permission allows GitHub Actions to request an OIDC token.

Microsoft Entra ID validates the token against the configured Federated Credentials before allowing access to Azure.


Why OIDC?

Traditional CI/CD authentication often relies on storing a client secret.

This project uses OIDC instead.

Traditional approach:


GitHub Actions
      |
      v
Stored Client Secret
      |
      v
Azure


OIDC approach:


GitHub Actions
      |
      v
Short-lived OIDC Token
      |
      v
Microsoft Entra ID
      |
      v
Temporary Azure Access


Benefits include:

- No long-lived Azure client secret
- Short-lived authentication
- Reduced credential exposure
- Federated trust between GitHub and Azure
- Fine-grained identity configuration
- Better alignment with cloud security practices


Federated Credentials

The Azure App Registration contains federated credentials for the GitHub Actions workflow.


Main Branch

The main branch credential is used for workflows triggered by pushes to main.


GitHub Event
    |
    v
Push to main
    |
    v
Federated Credential
    |
    v
Azure Authentication



Pull Request

A separate federated credential is used for Pull Request workflows.


GitHub Event
    |
    v
Pull Request
    |
    v
Federated Credential
    |
    v
Azure Authentication
```

Separate credentials are required because GitHub generates different OIDC subject claims for different workflow events.


Terraform Remote State


Terraform state is stored remotely in an Azure Storage Account using the AzureRM backend.

Example configuration:

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "backend-rg"
    storage_account_name = "terraformstate"
    container_name       = "tfstate"
    key                  = "preprod.terraform.tfstate"
  }
}



Remote State Architecture


flowchart LR

    A[GitHub Actions] --> B[Terraform Init]
    B --> C[Azure Storage Account]
    C --> D[Terraform State Blob]

    D --> E[State Locking]
    D --> F[Persistent State]



Benefits

- Centralized state management
- Persistent Terraform state
- Team collaboration
- State locking
- Reduced risk of concurrent state modification
- Separation of infrastructure code and state


Terraform Module Architecture

The project uses a parent-child module architecture.




    A[Parent Module]

    A --> B[Resource Group]
    A --> C[Virtual Network]
    A --> D[Subnet]
    A --> E[Public IP]
    A --> F[Network Interface]
    A --> G[Virtual Machine]

    C --> D
    D --> F
    E --> F
    F --> G



Parent Module

The parent module is responsible for:

- Calling child modules
- Passing variables
- Managing dependencies
- Orchestrating infrastructure deployment


Child Modules

Reusable modules are created for infrastructure components including:

- Resource Groups
- Virtual Networks
- Subnets
- Public IPs
- Network Interfaces
- Virtual Machines


Git Workflow


The project follows a feature branch and Pull Request workflow.



    commit id: "Initial infrastructure"

    branch feature/infra

    checkout feature/infra
    commit id: "Infrastructure changes"

    checkout main
    merge feature/infra
    commit id: "Deployment"


Typical development workflow:


git checkout main
git pull origin main

git checkout -b feature/storage-account

git add .

git commit -m "Add storage account module"

git push origin feature/storage-account


A Pull Request is then created against main.

After validation and review, the Pull Request is merged.


GitHub Actions CI/CD
--------------------

The workflow uses different behavior depending on the GitHub event.


Pull Request

Pull Requests perform validation, security scanning, Terraform planning and cost analysis.

```text
Pull Request
     |
     +-- Terraform Format
     |
     +-- Gitleaks
     |
     +-- Trivy
     |
     +-- Checkov
     |
     +-- TFLint
     |
     +-- Terraform Validate
     |
     +-- Azure OIDC
     |
     +-- Terraform Init
     |
     +-- Terraform Plan
     |
     +-- Infracost
     |
     v
Code Review


No Terraform Apply is performed during the Pull Request.


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


This ensures infrastructure changes are deployed only after the Pull Request review process is completed.


Pipeline Summary


The complete workflow can be summarized as:




    A[Developer] --> B[Feature Branch]
    B --> C[Pull Request]

    C --> D[Security Scanning]
    D --> E[Gitleaks]
    D --> F[Trivy]
    D --> G[Checkov]

    C --> H[Terraform CI]
    H --> I[Format]
    I --> J[TFLint]
    J --> K[Validate]
    K --> L[Terraform Plan]

    L --> M[Infracost]

    E --> N[Pull Request Review]
    F --> N
    G --> N
    M --> N

    N --> O[Merge to main]

    O --> P[Azure OIDC]
    P --> Q[Terraform Init]
    Q --> R[Terraform Plan]
    R --> S[Terraform Apply]
    S --> T[Azure Infrastructure]
```


Security Model of the project

The project follows several security principles:

- No hardcoded Azure credentials
- GitHub OIDC instead of long-lived client secrets
- Azure RBAC-based authorization
- Federated identity credentials
- Pull Request security scanning
- Secret detection with Gitleaks
- IaC security scanning with Checkov
- Trivy security scanning
- Terraform validation before deployment
- Remote Terraform state
- Cost visibility before infrastructure deployment



