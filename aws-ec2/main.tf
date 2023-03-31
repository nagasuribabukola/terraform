data "aws_ami_ids" "ubuntu" {
  owners = ["099720109477"]

  filter {
    name   = "description"
    values = ["Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2023-03-25"]
  }

  filter {
    name   = "is-public"
    values = ["true"]
  }
}

resource "aws_instance" "ubntu2204" {
  ami           = data.aws_ami_ids.ubuntu.ids[0]
  instance_type = "t2.micro"
  associate_public_ip_address = true
  tags = {
    Name = "ubuntu2204"
  }

  depends_on = [
    data.aws_ami_ids.ubuntu
  ]
}