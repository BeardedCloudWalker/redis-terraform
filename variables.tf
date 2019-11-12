variable "aws" {
  default = {
    region  = ""
    profile = ""
  }
}

variable "namespace" {
  description = "App Namespace"
  default     = "redis"
}
variable "vpc_id" {
}
variable "cluster_name" {
  
}
