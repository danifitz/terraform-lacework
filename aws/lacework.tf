# Configure AWS config scanning in Lacework
module "aws_config" {
  source  = "lacework/config/aws"
  version = "~> 0.1"
}

# Configure AWS audit & behavioural monitoring 
module "aws_cloudtrail" {
  source  = "lacework/cloudtrail/aws"
  version = "~> 0.1"

  bucket_force_destroy  = true
  use_existing_iam_role = true
  iam_role_name         = module.aws_config.iam_role_name
  iam_role_arn          = module.aws_config.iam_role_arn
  iam_role_external_id  = module.aws_config.external_id
}

# Configure AWS ECR integration for vulnerability scanning of container images
module "lacework_ecr" {
  source  = "lacework/ecr/aws"
  version = "~> 0.1"
}