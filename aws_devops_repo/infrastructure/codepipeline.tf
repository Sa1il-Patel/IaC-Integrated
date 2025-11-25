resource "random_id" "bucket_id" { byte_length = 4 }


resource "aws_s3_bucket" "artifacts" {
bucket = "${var.app_name}-artifacts-${random_id.bucket_id.hex}"
acl = "private"
}


resource "aws_codepipeline" "pipeline" {
name = "${var.app_name}-pipeline"
role_arn = aws_iam_role.codepipeline_role.arn


artifact_store {
location = aws_s3_bucket.artifacts.bucket
type = "S3"
}


stage {
name = "Source"
action {
name = "Source"
category = "Source"
owner = "ThirdParty"
provider = "GitHub"
version = "1"
output_artifacts = ["source_output"]
configuration = {
Owner = var.github_owner
Repo = var.github_repo
Branch = var.github_branch
OAuthToken = var.github_oauth_token
}
}
}


stage {
name = "Build"
action {
name = "Build"
category = "Build"
owner = "AWS"
provider = "CodeBuild"
input_artifacts = ["source_output"]
output_artifacts = ["build_output"]
configuration = { ProjectName = aws_codebuild_project.build.name }
}
}


stage {
name = "Deploy"
action {
name = "ECSDeploy"
category = "Deploy"
owner = "AWS"
provider = "ECS"
input_artifacts = ["build_output"]
configuration = {
ClusterName = aws_ecs_cluster.cluster.name
ServiceName = aws_ecs_service.service.name
FileName = "imagedefinitions.json"
}
}
}
}
