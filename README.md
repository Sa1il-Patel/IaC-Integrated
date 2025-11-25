# AWS CI/CD: CodePipeline + CodeBuild + Terraform


This project demonstrates a CI/CD pipeline on AWS using CodePipeline and CodeBuild to build a Docker image and deploy it to ECS Fargate. Infrastructure is provisioned using Terraform.


## What the repo contains
- Minimal Node.js web app
- Dockerfile
- buildspec.yml for CodeBuild
- Terraform configurations to create ECR, CodeBuild, CodePipeline, ECS cluster/service, S3 artifact bucket, and IAM roles
- `setup_project.sh` automation script to create a GitHub repo and apply Terraform


## Requirements
- Git
- Docker (for local testing)
- Terraform >= 1.0
- AWS CLI configured with appropriate permissions
- GitHub Personal Access Token (repo scope)


## Quickstart
1. Set environment variables:


```bash
export GITHUB_TOKEN="ghp_xxx..."
export GITHUB_USER="your-github-username"
export AWS_REGION="us-east-1"
