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

resource "aws_iam_group_membership" "devops-users-mapping" {
    name = "devops-users-mapping"
    users = [
        "${aws_iam_user.calvin-devops.name}",
        "${aws_iam_user.hobbes-devops.name}",
    ]
    group = "${aws_iam_group.devops-users.name}"
}
