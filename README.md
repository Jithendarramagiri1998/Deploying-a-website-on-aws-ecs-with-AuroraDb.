Project Title:— Deploying a Website on AWS ECS with Aurora using Terraform
🧭 Overview

This project demonstrates a complete DevOps setup where a containerized website is deployed on Amazon ECS (Fargate) backed by an Aurora Database Cluster, all provisioned using Terraform (IaC).

It follows best practices for environment isolation, scalability, monitoring, and secure architecture across Dev and Staging environments.

Requirements: 
1.	For a IAC use Terraform for further creation of deploying AWS resources. 
2.	Deploy the Website in ECS using Fargate launch type. 
3.	Deploy and AuroraDb Cluster using by website to ensure the multi-agent availability zones deployment. 
4.	Ensure that dev and staging Environment separation. 
5.	Setup Route53 for respective Ecs services for both dev and staging. 
6.	Integrate Cloud watch for logging and monitoring for both ECS service and Aurora Db. 
7.	Ensure all resources are securely configured, proper vpc and subnet configuration with secure access to the DB.

🏗️ Architecture Overview
                    ┌────────────────────────┐
                    │        Route53         │
                    │ dev.myapp.com          │
                    │ staging.myapp.com      │
                    └──────────┬─────────────┘
                               │
                          ┌────▼────┐
                          │  ALB    │
                          └────┬────┘
                               │
                      ┌────────▼────────┐
                      │ ECS Fargate     │
                      │ (Web Containers)│
                      └────────┬────────┘
                               │
                      ┌────────▼────────┐
                      │  Aurora Cluster │
                      │ (Multi-AZ RDS)  │
                      └─────────────────┘
                               │
                      ┌────────▼────────┐
                      │ CloudWatch + SNS│
                      │  Alerts & Logs  │
                      └─────────────────┘

🧩 Project Structure
project-22/
├── modules/
│   ├── vpc/
│   ├── ecs/
│   ├── aurora/
│   ├── route53/
│   ├── cloudwatch/
│   └── sns/
│
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── terraform.tfvars
│   └── staging/
│       ├── main.tf
│       ├── variables.tf
│       └── terraform.tfvars
│
├── scripts/
│   ├── build_and_push_ecr.sh
│   └── ecs_deploy.sh
│
└── README.md

⚙️ Prerequisites

AWS Account with IAM permissions

Terraform ≥ v1.5

AWS CLI configured (aws configure)

Docker installed locally

Domain registered in Route53 (optional, for DNS setup)

🪜 Setup Steps
1️⃣ Clone the Repository
git clone https://github.com/<your-username>/project-22-ecs-aurora.git
cd project-22-ecs-aurora

2️⃣ Initialize Terraform (Dev Environment)
cd environments/dev
terraform init
terraform plan
terraform apply -auto-approve


This provisions VPC, ECS Cluster, AuroraDB, Route53 records, CloudWatch metrics, and SNS alerts.

3️⃣ Initialize Terraform (Staging Environment)
cd ../staging
terraform init
terraform plan
terraform apply -auto-approve


Separate resources for staging environment with isolated networking, ECS cluster, and AuroraDB.

🐳 Build & Push Docker Image

Use the helper script to build and push your website container image to ECR:

cd scripts
chmod +x build_and_push_ecr.sh
./build_and_push_ecr.sh <aws-account-id> <region> <repository-name>

🚢 Deploy ECS Service

After pushing the Docker image, update ECS service with the new image:

./ecs_deploy.sh <cluster-name> <service-name> <image-uri>

🌐 Access the Website

After deployment:

Dev: https://dev.myapp.example.com

Staging: https://staging.myapp.example.com

Both environments are isolated with different ECS, Aurora, and VPC setups.

🔒 Security Highlights

✅ Aurora hosted in private subnets (no public access)
✅ ECS tasks communicate via internal SG rules
✅ IAM least privilege enforced for ECS tasks and Terraform
✅ Encrypted Aurora cluster (KMS key used)
✅ HTTPS via ALB + Route53

📈 Monitoring & Alerts

CloudWatch Logs → ECS task/application logs

CloudWatch Alarms → Aurora CPU, Memory, Disk usage

SNS Topic → Sends alert emails for threshold breaches

🧱 Environment Separation

Each environment (dev, staging) has:

Own VPC, Subnets, Route Tables

Independent ECS Cluster

Separate AuroraDB Cluster

Dedicated CloudWatch Log Groups & Alarms

Distinct Route53 DNS records

This ensures no overlap or cross-environment impact.

🧹 Cleanup

To destroy the environment and avoid charges:

terraform destroy -auto-approve

👨‍💻 Author

Ramagiri Jithendar — DevOps Engineer