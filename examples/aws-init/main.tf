provider "aws" {
  alias   = "default"
  profile = "default"
  region  = "us-east-2"
}

provider "aws" {
  alias   = "destination"
  profile = "destination"
  region  = "us-east-2"
}

data "aws_caller_identity" "default" {
  provider = aws.default
}

data "aws_iam_policy" "administrator" {
  provider = aws.destination
  name     = "AdministratorAccess"
}

data "aws_iam_policy_document" "assume_role" {
  provider = aws.destination
  statement {
    actions = [
      "sts:AssumeRole",
      "sts:TagSession",
      "sts:SetSourceIdentity"
    ]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.default.account_id}:root"]
    }
  }
}

resource "aws_iam_role" "destination_assume_role" {
  provider            = aws.destination
  name                = "destination_assume_role"
  assume_role_policy  = data.aws_iam_policy_document.assume_role.json
  managed_policy_arns = [data.aws_iam_policy.administrator.arn]
  tags                = {
    Name = "Destination Assume Role"
  }
}