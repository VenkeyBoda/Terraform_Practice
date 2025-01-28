# using data sources for executing the results
data "aws_ami" "webimage" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.web_instance_info.filter_ami.name]
  }
  owners = [var.web_instance_info.filter_ami.owner] # Canonical
}
