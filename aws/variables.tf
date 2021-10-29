variable "aws_default_region" {
  description = "If you want to change the default region to another region, use this variable. Examples could be us-west-2 or ap-north-1."
  type        = string
  default     = "eu-west-2"
}

variable "aws_profile" {
  description = "Which AWS CLI profile to use"
  type        = string
  default     = "daniel.fitzgerald@lacework.net"
}

variable "lacework_token" {
  description = "The lacework token for the agent to use to connect"
  type        = string
}