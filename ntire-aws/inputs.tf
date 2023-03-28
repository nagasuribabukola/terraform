variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_subnets" {
  type = object({
    vpc_iprange       = string
    names             = list(string)
    availability_zone = list(string)
  })
  default = {
    vpc_iprange       = "192.168.0.0/16"
    names             = ["app1", "app2", "db1", "db2"]
    availability_zone = ["a", "b", "a", "b"]
  }
}

variable "route_subnets" {
  type = object({
    public_subnets  = list(string)
    private_subnets = list(string)
  })
  default = {
    public_subnets  = ["app1", "app2"]
    private_subnets = ["db1", "db2"]
  }
}