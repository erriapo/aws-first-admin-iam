resource "aws_iam_user" "calvin-devops" {
  name = "calvin"
  path = "/"
}

resource "aws_iam_user" "hobbes-devops" {
  name = "hobbes"
  path = "/"
}

resource "aws_iam_group" "devops-users" {
    name = "devops"
    path = "/"
}

# https://github.com/nccgroup/AWS-recipes/blob/master/IAM-Policies/EnforceMFA-8HourSession-AllowEnableMFAChangePassword.json
resource "aws_iam_group_policy" "require-mfa" {
    name = "require-mfa"
    group = "${aws_iam_group.devops-users.id}"
    policy = "${file("policy-require-mfa.json")}"
}

resource "aws_iam_policy" "all-access" {
    name        = "all-access-policy"
    description = "Generic All"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "*",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

# Managed Policy
resource "aws_iam_user_policy_attachment" "attach-hobbes-readonly" {
    user       = "${aws_iam_user.hobbes-devops.name}"
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

# Inline Policy
resource "aws_iam_user_policy_attachment" "attach-calvin-all" {
    user       = "${aws_iam_user.calvin-devops.name}"
    policy_arn = "${aws_iam_policy.all-access.arn}"
}

resource "aws_iam_group_membership" "devops-users-mapping" {
    name = "devops-users-mapping"
    users = [
        "${aws_iam_user.calvin-devops.name}",
        "${aws_iam_user.hobbes-devops.name}",
    ]
    group = "${aws_iam_group.devops-users.name}"
}
