resource "aws_security_group" "ec2" {
  name        = var.aws_ec2_security_group_name
  vpc_id      = aws_vpc.main.id
  description = "Security group for EC2 instance"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.aws_tags
}

resource "aws_security_group" "eks_security_group" {
  name        = var.aws_eks_security_group_name
  description = "Allow TLS inbound and outbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.aws_tags
}

resource "aws_security_group" "rds-sg" {
  name        = var.aws_rds_security_group_name
  description = "Allows application tier to access the RDS instance"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "EC2 to PostgreSQL"
    from_port   = var.aws_rds_port
    to_port     = var.aws_rds_port
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.aws_tags
}

resource "aws_security_group" "redis-sg" {
  name        = var.aws_elasticache_redis_security_group_name
  vpc_id      = aws_vpc.main.id
  description = "Allow inbound to and outbound access from the Amazon ElastiCache cluster."
  ingress {
    from_port   = var.aws_elasticache_redis_port
    to_port     = var.aws_elasticache_redis_port
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
    description = "Enable communication to the Amazon ElastiCache for Redis cluster. "
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Enable access to the ElastiCache cluster."
  }
  tags = var.aws_tags
}