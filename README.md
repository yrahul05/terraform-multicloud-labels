# 🌍 Terraform Multicloud Labels

<p align="center">
  <img src="https://img.shields.io/badge/Terraform-Module-6610f2?style=for-the-badge&logo=terraform&logoColor=white"/>
  <img src="https://img.shields.io/badge/Multicloud-AWS%20%7C%20Azure%20%7C%20GCP%20%7C%20DO%20%7C%20Hetzner-007bff?style=for-the-badge"/>
  <img src="https://img.shields.io/github/stars/yrahul05/terraform-multicloud-labels?style=for-the-badge"/>
</p>

> A clean and opinionated Terraform module by **[Rahul Yadav](https://github.com/yrahul05)**  
> for generating consistent resource names, tags and labels across **AWS, Azure, GCP, DigitalOcean and Hetzner**.

---
🎯 WHY THIS MODULE EXISTS

• Consistent naming across AWS, Azure, GCP, DigitalOcean  
• Sanitized lowercase labels  
• Cloud-friendly names and tags  
• Works the same in all environments


👤 ABOUT ME

Rahul Yadav  
Certified Cloud & DevOps Engineer  
    CEO & CTO – [PrimeOps Technologies](https://primeops.co.in/)

PrimeOps Technologies Services:
• Terraform, Kubernetes, Ansible automation  
• CI/CD pipelines  
• Cloud cost optimization (AWS, Azure, GCP)  
• Multi-cloud architecture  
• Security & DevSecOps


🔗 LINKS

GitHub: https://github.com/yrahul05  
LinkedIn: https://www.linkedin.com/in/rahulyadavdevops/  
Upwork: https://www.upwork.com/freelancers/~0183ad8a41e8284283  

--------------------------------------------------------------

Website: https://primeops.co.in/  
GitHub Org: https://github.com/https://github.com/PrimeOps-Technologies
Linkedin Org: https://www.linkedin.com/company/primeops-technologies
Upwork Agency: https://www.upwork.com/agencies/1990756660262272773/



# ✨ Features

- Unified naming for **AWS, Azure, GCP, Digitalocean, Hetzner**
- Auto-lowercase labels for restricted clouds
- TitleCase AWS tags
- Consistent tag structure
- Lightweight & simple to use

---

---
                        🧩 Architecture — Naming Flow

            ┌───────────┐     ┌─────────────┐     ┌──────────────┐
            │   name    │  +  │ environment │  +  │ attributes[] │
            └─────┬─────┘     └──────┬──────┘     └──────┬───────┘
                  │                  │                   │
                  └──────────────┬───┴───────┬───────────┘
                                 ▼           ▼
                           ┌───────────────────────────┐
                           │       Normalization       │
                           └──────────────┬────────────┘
                                          ▼
                           ┌───────────────────────────┐
                           │            id             │
                           └──────────────┬────────────┘
                                          ▼
     ┌──────────────────────────┬─────────────────────────┬──────────────────────────┐
     │          tags            │          labels          │        all_tags         │
     └──────────────────────────┴─────────────────────────┴──────────────────────────┘


## ⚙️ Usage Examples

### ☁️ AWS Example
```hcl
module "labels" {
  source      = "git::https://github.com/yrahul05/terraform-multicloud-labels.git?ref=v1.0.0"
  name        = "payment-api"
  environment = "prod"
  repository  = "terraform-multicloud-labels"
  attributes  = ["v1"]

  extra_tags = {
    Owner      = "PrimeOps"
    CostCenter = "Finance"
  }
}

resource "aws_security_group" "main" {
  name = module.labels.id
  tags = module.labels.tags
}
```
### ☁️ GCP Example
```hcl
module "labels" {
  source      = "git::https://github.com/yrahul05/terraform-multicloud-labels.git?ref=v1.0.0"
  name        = "payment-api"
  environment = "prod"
  repository  = "terraform-multicloud-labels"
  attributes  = ["gcp"]
}

resource "google_storage_bucket" "main" {
  name   = module.labels.id
  labels = module.labels.labels
}
```

### ☁️ DigitalOcean Example
```hcl

module "labels" {
  source      = "git::https://github.com/yrahul05/terraform-multicloud-labels.git?ref=v1.0.0"
  name        = "payment-api"
  environment = "prod"
  repository  = "terraform-multicloud-labels"
  attributes  = ["do"]
}

locals {
  do_tag_list = [for k, v in module.labels.labels : "${k}:${v}"]
}

resource "digitalocean_droplet" "main" {
  name   = module.labels.id
  region = "nyc3"
  image  = "ubuntu-22-04-x64"
  size   = "s-1vcpu-1gb"
  tags   = local.do_tag_list
}
```
### ☁️ Hetzner Example
```hcl
module "labels" {
  source      = "git::https://github.com/yrahul05/terraform-multicloud-labels.git?ref=v1.0.0"
  name        = "payment-api"
  environment = "dev"
  repository  = "terraform-multicloud-labels"
  attributes  = ["hetzner"]
}

resource "hcloud_server" "main" {
  name        = "${module.labels.id}-vm"
  server_type = "cx11"
  image       = "ubuntu-22.04"
  location    = "nbg1"
  labels      = module.labels.labels
}
```
### ☁️ Azure Example
```hcl
module "labels" {
  source      = "git::https://github.com/yrahul05/terraform-multicloud-labels.git?ref=v1.0.0"
  name        = "payment-api"
  environment = "uat"
  repository  = "terraform-multicloud-labels"
  attributes  = ["az"]
}

resource "azurerm_resource_group" "main" {
  name     = module.labels.id
  location = "East US"
  tags     = module.labels.tags
}
```
### ☁️ Outputs
| Name         | Description                                                                 |
|---------------|------------------------------------------------------------------------------|
| `id`          | Normalized identifier built from `name`, `environment`, and `attributes`.   |
| `tags`        | AWS/Azure-style TitleCase map (includes `Name`).                            |
| `labels`      | GCP/DO/Hetzner lowercase-safe label map.                                    |
| `all_tags`    | Raw lowercase normalized map (before formatting).                           |
| `name`        | Normalized resource name.                                                   |
| `environment` | Lowercased environment name.                                                |
| `managedby`   | Source or management owner.                                                 |
| `repository`  | Terraform module or repository name.                                        |

### 🧪 Input Variables
| Variable      | Type         | Default         | Description              |
| ------------- | ------------ |-----------------|--------------------------|
| `name`        | string       | n/a             | Base resource name       |
| `environment` | string       | `"dev"`         | Environment name         |
| `attributes`  | list(string) | `[]`            | Optional suffix parts    |
| `repository`  | string       | `null`          | Repo or module name      |
| `managedby`   | string       | `"Rahul Yadav"` | Management owner         |
| `extra_tags`  | map(string)  | `{}`            | Additional tags          |
| `delimiter`   | string       | `"-"`           | Join delimiter           | 


### ☁️ Tag Normalization Rules
| Cloud          | Case             | Allowed characters | Example                        |
|----------------|------------------|--------------------|----------------------------------|
| **AWS**        | TitleCase        | Any                | `Name`, `Environment`, `CostCenter` |
| **Azure**      | Case-insensitive | Any                | `environment`, `Name`           |
| **GCP**        | Lowercase        | `[a-z0-9_-]`       | `environment`, `repository`     |
| **DigitalOcean** | Lowercase      | `[a-z0-9_-]`       | `environment`, `repository`     |
| **Hetzner**    | Lowercase        | `[a-z0-9_-]`       | `environment`, `repository`     |

---

## 💙 Maintained by Rahul Yadav

CEO & CTO at **[PrimeOps Technologies](https://primeops.co.in/)**
Helping teams build stable, scalable and consistent cloud infrastructure.
