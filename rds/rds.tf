provider "aws" {
 region = "sa-east-1"
}
resource "aws_vpc" "main" {
  cidr_block       = "172.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    ita_group = "Kv-045"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    ita_group = "Kv-045"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = {
    ita_group = "Kv-045"
  }
}

resource "aws_route_table_association" "rta" {
  subnet_id      = "${aws_subnet.main.id}"
  route_table_id = "${aws_route_table.rt.id}"
}

resource "aws_subnet" "main" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "172.0.1.0/24"
  availability_zone = "sa-east-1a"

  tags = {
    ita_group = "Kv-045"
  }
}

resource "aws_subnet" "for_rds" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "172.0.2.0/24"
  availability_zone = "sa-east-1b"
  tags = {
    ita_group = "Kv-045"
  }
}

resource "aws_security_group" "for_vpc" {
  name        = "sg_vpc"
  description = "Allow inbound traffic for vpc"
  vpc_id     = "${aws_vpc.main.id}"

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    ita_group = "Kv-045"
  }
}

resource "aws_security_group" "for_rds" {
  name        = "sg_rds"
  description = "Inbound traffic for rds"
  vpc_id     = "${aws_vpc.main.id}"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    ita_group = "Kv-045"
  }
}

resource "aws_db_subnet_group" "sb_rds" {
  name       = "sb_rds"
  subnet_ids = ["${aws_subnet.main.id}", "${aws_subnet.for_rds.id}"]

  tags = {
    ita_group = "Kv-045"
  }
}


resource "aws_db_instance" "postgres" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "10.6"
  instance_class       = "db.t2.micro"
  name                 = "${var.DBNAME}"
  username             = "${var.DBUSER}"
  password             = "${var.DBPASS}"
  publicly_accessible = true
  multi_az = false
  db_subnet_group_name = "${aws_db_subnet_group.sb_rds.id}"
  vpc_security_group_ids = ["${aws_security_group.for_rds.id}", "${aws_security_group.for_vpc.id}"]

  tags = {
    ita_group = "Kv-045"
  }
}





