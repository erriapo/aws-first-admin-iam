# Goals

* Create 2 IAM users under a `devops` group. 
* Both users require an associated MFA.

# Example

```bash
$ terraform init
$ terraform plan --var-file=terraform.tfvars-sample
$ terraform apply --var-file=terraform.tfvars-sample

$ aws iam get-user --user-name calvin
{
    "User": {
        "UserName": "calvin",
        "Path": "/",
        "CreateDate": "2018-10-30T03:05:49Z",
        "UserId": "CCCCCCCCCCC",
        "Arn": "arn:aws:iam::${ACCOUNT_ID}:user/calvin"
    }
}

$ aws iam get-user --user-name hobbes
{
    "User": {
        "UserName": "hobbes",
        "Path": "/",
        "CreateDate": "2018-10-30T03:10:10Z",
        "UserId": "BBBBBBBBBBBBBBB",
        "Arn": "arn:aws:iam::${ACCOUNT_ID}:user/hobbes"
    }
}
       
$ aws iam list-groups
{
    "Groups": [
        {
            "Path": "/",
            "CreateDate": "2018-10-30T03:05:49Z",
            "GroupId": "AAAAAAAAAAAAAAAAAAAAA",
            "Arn": "arn:aws:iam::${ACCOUNT_ID}:group/devops",
            "GroupName": "devops"
        }
    ]
}


$ aws iam list-group-policies --group-name devops
{
    "PolicyNames": [
        "require-mfa"
    ]
}

$ aws iam list-attached-user-policies --user-name hobbes
{
    "AttachedPolicies": [
        {
            "PolicyName": "AmazonEC2ReadOnlyAccess",
            "PolicyArn": "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
        }
    ]
}
$ aws iam list-attached-user-policies --user-name calvin
{
    "AttachedPolicies": [
        {
            "PolicyName": "all-access-policy",
            "PolicyArn": "arn:aws:iam::${ACCOUNT_ID}:policy/all-access-policy"
        }
    ]
}
```
