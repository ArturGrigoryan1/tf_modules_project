variable "source_dir" {
	type = string
	default = "./python/"
	description = "Source directory of target file containing Lambda function"
}

variable "output_path" {
	type = string
	default = "./python/main.zip"
	description = "Output zip file "
}

variable "function_name" {
    type = string
    default = "Lambda-Function"
}

variable "handler" {
    type = string
    default = "main.lambda_handler"  
    description = "name of your file + . + name of handler function"
}

variable "runtime_lang" {
	type = string
	#default = "python3.8"
	description = "Type and version of the runtime language"
}