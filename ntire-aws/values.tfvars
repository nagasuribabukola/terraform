region = "us-east-1"
vpc_subnets = {
  vpc_iprange       = "10.100.0.0/16"
  names             = ["web1", "web2", "app1", "app2", "db1", "db2"]
  availability_zone = ["a", "b", "a", "b", "a", "b"]
}
route_subnets = {
  public_subnets  = ["web1", "web2"]
  private_subnets = ["app1", "app2", "db1", "db2"]
}