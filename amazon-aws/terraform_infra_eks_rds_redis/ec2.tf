# Create EC2 instance
resource "aws_instance" "ec2" {
  ami                         = var.aws_ec2_ami_type
  instance_type               = var.aws_ec2_instance_type
  subnet_id                   = aws_subnet.public_subnets[0].id
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  associate_public_ip_address = var.aws_ec2_public_ip_allocate
  key_name                    = aws_key_pair.my_ec2_key.key_name

  # Attach the IAM role to the EC2 instance
  iam_instance_profile = aws_iam_instance_profile.example.name
  tags                 = var.aws_tags
}

#create aws ec2 instance key pair
resource "aws_key_pair" "my_ec2_key" {
  key_name   = var.aws_ec2_ssh_key_name
  public_key = file("~/.ssh/id_rsa.pub")
  tags       = var.aws_tags
}

# Create the IAM instance profile
resource "aws_iam_instance_profile" "example" {
  name = "ec2-instance-profile"
  role = aws_iam_role.all_services_role.name
  tags = var.aws_tags
}

#terraform output -raw my_ec2_key > my_ec2_key.pem

