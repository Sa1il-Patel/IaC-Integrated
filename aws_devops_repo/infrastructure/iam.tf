data "aws_iam_policy_document" "codebuild_assume_role" {
statement { actions = ["sts:AssumeRole"] principals { type = "Service" identifiers = ["codebuild.amazonaws.com"] } }
}


resource "aws_iam_role" "codebuild_role" {
name = "${var.app_name}-codebuild-role"
assume_role_policy = data.aws_iam_policy_document.codebuild_assume_role.json
}


resource "aws_iam_role_policy_attachment" "codebuild_ecr" {
role = aws_iam_role.codebuild_role.name
policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}


resource "aws_iam_role" "codepipeline_role" {
name = "${var.app_name}-codepipeline-role"
assume_role_policy = jsonencode({
Version = "2012-10-17",
Statement = [{ Effect = "Allow", Principal = { Service = "codepipeline.amazonaws.com" }, Action = "sts:AssumeRole" }]
})
}


# Attach managed policies (for brevity). In production, scope down permissions.
resource "aws_iam_role_policy_attachment" "cp_attach_s3" {
role = aws_iam_role.codepipeline_role.name
policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}


resource "aws_iam_role_policy_attachment" "cp_attach_ecs" {
role = aws_iam_role.codepipeline_role.name
policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}
