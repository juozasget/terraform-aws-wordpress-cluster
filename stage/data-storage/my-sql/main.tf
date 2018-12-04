provider "aws" {
  region = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "sollab-terraform-state"
    key    = "stage/data-storage/my-sql/terraform.tfstate"
    region = "eu-west-1"
  }
}

resource "aws_db_instance" "mysql_db" {
  engine                 = "mysql"
  allocated_storage      = 10
  instance_class         = "db.t2.micro"
  name                   = "example_database"
  username               = "root"
  password               = "${var.db_password}"
  skip_final_snapshot    = true
  vpc_security_group_ids = ["${aws_security_group.database_rules.id}"]
}

resource "aws_security_group" "database_rules" {
  name = "terraform-database-rules"

  ingress {
    from_port   = "3306"
    to_port     = "3306"
    protocol    = "tcp"
    cidr_blocks = ["172.31.0.0/16"]
  }

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}
