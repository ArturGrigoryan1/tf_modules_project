output "aws_role" {
    value = aws_iam_role.lambda_role.name
}

output "aws_role_arn" {
    value = aws_iam_role.lambda_role.arn
}

output "logging_arn" {
    value = aws_iam_policy.iam_policy_for_lambda.arn  
}