resource "aws_ec2_host" "web" {
  instance_type     = "c5.18xlarge"
  availability_zone = "eu-west-3"
  host_recovery     = "on"
  auto_placement    = "on"
}