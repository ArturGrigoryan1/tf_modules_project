resource "aws_iam_role" "lambda_role" {
    name = "aws_lambda_role"
    assume_role_policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Action": "sts:AssumeRole",
                "Principal": {
                    "Service": "lambda.amazonaws.com"
                },
                "Effect": "Allow",
                "Sid": ""
            }
        ]
    }
    EOF  
}

resource "aws_iam_policy" "iam_policy_for_lambda" {
    name = "iam_policy_for_lambd_role"
    path = "/"
    description = "AWS IAM Policy for managing aws lambda role"
    policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Action": [
                    "logs:CreateLogStream",
                    "logs:CreateLogDelivery",
                    "logs:PutLogEvents"
                ],
                "Effect": "Allow",
                "Resource": "arn:aws:logs:*:*:*"
            }
        ]
    
    }
    EOF   
}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
    role = aws_iam_role.lambda_role.name
    policy_arn = aws_iam_policy.iam_policy_for_lambda.arn
}

data "archive_file" "zip_the_code" {
    type = "zip"
    source_dir = var.source_dir
    output_path = var.output_path
}

resource "aws_lambda_function" "lambda_func" {
    filename = var.output_path
    function_name = var.function_name
    role = aws_iam_role.lambda_role.arn
    handler = var.handler
    runtime = var.runtime_lang
    depends_on = [ aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role ]
}
