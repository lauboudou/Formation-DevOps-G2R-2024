# Define o provedor AWS e a região usando a variável
provider "aws" {
  region = var.aws_region  # Região da AWS (utilizando a variável)
}

# Cria uma instância EC2 t3.medium para o nextcloud
resource "aws_instance" "nextcloud" {
  ami                   = var.ami_id  # AMI do Ubuntu (utilizando a variável)
  instance_type        = var.instance_type_medium  # Tipo da instância (utilizando a variável)
  subnet_id            = aws_subnet.my_subnet.id  # Sub-rede onde a instância será lançada
  vpc_security_group_ids = [aws_security_group.myhomelab_sg.id]  # Associa o Security Group
  key_name             = var.key_pair_aws  # Chave pública para acessar a instância (utilizando a variável)

  # Utiliza user_data para executar um script a partir de um arquivo
  user_data = file("provision.sh")  # Lê o conteúdo do arquivo provision.sh

  # Adiciona tags para identificar as instâncias
  tags = {
    Name = "nextcloud"
  }
}

# Cria uma instância EC2 t3.micro para o prometheus
resource "aws_instance" "prometheus" {
  ami                   = var.ami_id  # AMI do Ubuntu (utilizando a variável)
  instance_type        = var.instance_type_micro  # Tipo da instância (utilizando a variável)
  subnet_id            = aws_subnet.my_subnet.id  # Sub-rede onde a instância será lançada
  vpc_security_group_ids = [aws_security_group.myhomelab_sg.id]  # Associa o Security Group
  key_name             = var.key_pair_aws  # Chave pública para acessar a instância (utilizando a variável)

  # Utiliza user_data para executar um script a partir de um arquivo
  user_data = file("provision.sh")  # Lê o conteúdo do arquivo provision.sh

  # Adiciona tags para identificar as instâncias
  tags = {
    Name = "prometheus"
  }
}

# Cria uma instância EC2 t3.micro para o grafana
resource "aws_instance" "grafana" {
  ami                   = var.ami_id  # AMI do Ubuntu (utilizando a variável)
  instance_type        = var.instance_type_micro  # Tipo da instância (utilizando a variável)
  subnet_id            = aws_subnet.my_subnet.id  # Sub-rede onde a instância será lançada
  vpc_security_group_ids = [aws_security_group.myhomelab_sg.id]  # Associa o Security Group
  key_name             = var.key_pair_aws  # Chave pública para acessar a instância (utilizando a variável)

  # Utiliza user_data para executar um script a partir de um arquivo
  user_data = file("provision.sh")  # Lê o conteúdo do arquivo provision.sh

  # Adiciona tags para identificar as instâncias
  tags = {
    Name = "grafana"
  }
}

resource "aws_instance" "onlyoffice" {
  ami                   = var.ami_id  # AMI do Ubuntu (utilizando a variável)
  instance_type        = var.instance_type_micro  # Tipo da instância (utilizando a variável)
  subnet_id            = aws_subnet.my_subnet.id  # Sub-rede onde a instância será lançada
  vpc_security_group_ids = [aws_security_group.myhomelab_sg.id]  # Associa o Security Group
  key_name             = var.key_pair_aws  # Chave pública para acessar a instância (utilizando a variável)

  # Utiliza user_data para executar um script a partir de um arquivo
  user_data = file("provision.sh")  # Lê o conteúdo do arquivo provision.sh

  # Adiciona tags para identificar as instâncias
  tags = {
    Name = "onlyoffice"
  }
}

resource "aws_instance" "taiga" {
  ami                   = var.ami_id  # AMI do Ubuntu (utilizando a variável)
  instance_type        = var.instance_type_micro  # Tipo da instância (utilizando a variável)
  subnet_id            = aws_subnet.my_subnet.id  # Sub-rede onde a instância será lançada
  vpc_security_group_ids = [aws_security_group.myhomelab_sg.id]  # Associa o Security Group
  key_name             = var.key_pair_aws  # Chave pública para acessar a instância (utilizando a variável)

  # Utiliza user_data para executar um script a partir de um arquivo
  user_data = file("provision.sh")  # Lê o conteúdo do arquivo provision.sh

  # Adiciona tags para identificar as instâncias
  tags = {
    Name = "taiga"
  }
}

resource "aws_instance" "sonarqube" {
  ami                   = var.ami_id  # AMI do Ubuntu (utilizando a variável)
  instance_type        = var.instance_type_micro  # Tipo da instância (utilizando a variável)
  subnet_id            = aws_subnet.my_subnet.id  # Sub-rede onde a instância será lançada
  vpc_security_group_ids = [aws_security_group.myhomelab_sg.id]  # Associa o Security Group
  key_name             = var.key_pair_aws  # Chave pública para acessar a instância (utilizando a variável)

  # Utiliza user_data para executar um script a partir de um arquivo
  user_data = file("provision.sh")  # Lê o conteúdo do arquivo provision.sh

  # Adiciona tags para identificar as instâncias
  tags = {
    Name = "sonarqube"
  }
}

resource "aws_instance" "jenkins" {
  ami                   = var.ami_id  # AMI do Ubuntu (utilizando a variável)
  instance_type        = var.instance_type_micro  # Tipo da instância (utilizando a variável)
  subnet_id            = aws_subnet.my_subnet.id  # Sub-rede onde a instância será lançada
  vpc_security_group_ids = [aws_security_group.myhomelab_sg.id]  # Associa o Security Group
  key_name             = var.key_pair_aws  # Chave pública para acessar a instância (utilizando a variável)

  # Utiliza user_data para executar um script a partir de um arquivo
  user_data = file("provision.sh")  # Lê o conteúdo do arquivo provision.sh

  # Adiciona tags para identificar as instâncias
  tags = {
    Name = "jenkins"
  }
}

# Cria uma instância EC2 t3.micro para o zulip
resource "aws_instance" "zulip" {
  ami                   = var.ami_id  # AMI do Ubuntu (utilizando a variável)
  instance_type        = var.instance_type_micro  # Tipo da instância (utilizando a variável)
  subnet_id            = aws_subnet.my_subnet.id  # Sub-rede onde a instância será lançada
  vpc_security_group_ids = [aws_security_group.myhomelab_sg.id]  # Associa o Security Group
  key_name             = var.key_pair_aws  # Chave pública para acessar a instância (utilizando a variável)

  # Utiliza user_data para executar um script a partir de um arquivo
  user_data = file("provision.sh")  # Lê o conteúdo do arquivo provision.sh
  # Adiciona tags para identificar as instâncias
  tags = {
    Name = "zulip"
  }
}

# Cria uma instância EC2 t3.micro para o gitlab
resource "aws_instance" "gitlab" {
  ami                   = var.ami_id  # AMI do Ubuntu (utilizando a variável)
  instance_type        = var.instance_type_micro  # Tipo da instância (utilizando a variável)
  subnet_id            = aws_subnet.my_subnet.id  # Sub-rede onde a instância será lançada
  vpc_security_group_ids = [aws_security_group.myhomelab_sg.id]  # Associa o Security Group
  # Utiliza user_data para executar um script a partir de um arquivo
  user_data = file("provision.sh")  # Lê o conteúdo do arquivo provision.sh
  key_name             = var.key_pair_aws  # Chave pública para acessar a instância (utilizando a variável)
  
  # Adiciona tags para identificar as instâncias
  tags = {
    Name = "gitlab"
  }
}