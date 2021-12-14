variable "tenant" {
  type = string
}

### AWS APPS ###
variable "public_key" {
  type = string
}

variable "aws_apps" {
  type = map(object({
    name = string
    segment = string
    regions = map(object({
        name = string
        vpc_cidr = string
        instances = map(object({
            tier = string # EPG
            subnet_cidr = string
            instance_name = string
            instance_count = number
        }))
    }))
  }))
}
