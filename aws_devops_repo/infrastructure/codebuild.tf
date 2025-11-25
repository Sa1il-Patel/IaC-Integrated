resource "aws_codebuild_project" "build" {
name = "${var.app_name}-build"
service_role = aws_iam_role.codebuild_role.arn
artifacts { type = "CODEPIPELINE" }
environment {
compute_type = "BUILD_GENERAL1_SMALL"
image = "aws/codebuild/standard:7.0"
privileged_mode = true
environment_variable {
name = "AWS_ACCOUNT_ID"
value = data.aws_caller_identity.current.account_id
}
environment_variable {
name = "APP_NAME"
value = var.app_name
}
}
source { type = "CODEPIPELINE" }
}
