variable "bucket_name" {
  type = string
  description = "bucket unique name"
  default = "my-tf-test-bucket111121232153132335"
}

variable "force_destroy" {
    type = bool
    description = "bucket can be destroyed without error"
    default = false
}

variable "web_or_cf" {
    type = bool
    description = "count of policy and object"
    default = false
}

variable "publicIP" {
    description = "public IP adress"  
    type = string
    default = "195.8.50.36"
}

variable "folder_object" {
    description = "download files folders"
    default = "../../Source_file"  
}

variable "files_object" {
    description = "download files"
    default = "**"  
}

variable "object_content_encoding" {
    default = "utf-8"
}