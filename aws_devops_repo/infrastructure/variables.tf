variable "aws_region" { default = "us-east-1" }
variable "app_name" { default = "my-web-app" }
variable "github_owner" { description = "GitHub owner/org" }
variable "github_repo" { description = "repo name" }
variable "github_branch" { default = "main" }
variable "github_oauth_token" { description = "OAuth token for GitHub" }
