# Cria uma VPC (Virtual Private Cloud) com um bloco CIDR especificado
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr  # Bloco CIDR da VPC (utilizando a variável)
}

# Cria uma sub-rede dentro da VPC
resource "aws_subnet" "my_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id  # Referência à VPC criada
  cidr_block              = var.subnet_cidr      # Bloco CIDR da sub-rede (utilizando a variável)
  availability_zone       = var.aws_region   # Zona de disponibilidade da sub-rede
  map_public_ip_on_launch = false                # Não mapeia IPs públicos automaticamente
}

# Cria um gateway de internet para permitir acesso à internet
resource "aws_internet_gateway" "my_gateway" {
  vpc_id = aws_vpc.my_vpc.id  # Associado à VPC criada
}

# Cria uma tabela de rotas para gerenciar o tráfego
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id  # Associado à VPC criada

  route {
    cidr_block = "0.0.0.0/0"   # Rota para todo o tráfego
    gateway_id = aws_internet_gateway.my_gateway.id  # Rota pelo gateway de internet
  }
}

# Associa a tabela de rotas à sub-rede
resource "aws_route_table_association" "my_route_table_association" {
  subnet_id      = aws_subnet.my_subnet.id  # Sub-rede associada
  route_table_id = aws_route_table.my_route_table.id  # Tabela de rotas associada
}

# Cria um Security Group para MyHomeLab
resource "aws_security_group" "myhomelab_sg" {
  name        = var.security_group_name
  # Descrição do Security Group (utilizando a variável)
  # Regras de ingress para as portas especificadas
  ingress = [
    for port in [22, 80, 81,443, 3000, 9100, 9090]: {
      description      = "Allow traffic on port ${port}"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]  # Permite acesso de qualquer lugar
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  # Regras de egress para permitir todo o tráfego
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Permite todo o tráfego
    cidr_blocks = ["0.0.0.0/0"]  # Permite saída para qualquer lugar
  }

  # Tags para identificação
  tags = {
    Name = "myhomelab-sg"  # Nome do Security Group
  }
}

# Cria um registro A para apontar para a instância EC2
resource "aws_route53_record" "myhomelab_record" {
  zone_id = aws_route53_zone.myhomelab_zone.zone_id  # ID da zona DNS
  name     = "www"  # Subdomínio ou nome do registro
  type     = "A"    # Tipo do registro (A para IPv4)
  ttl      = 300    # Time to Live
  records  = [aws_instance.my_instance.public_ip]  # Endereço IP da instância EC2
}

# Cria uma zona DNS no Route 53
resource "aws_route53_zone" "myhomelab_zone" {
  name = var.dns_zone_name  # Nome da DNS (utilizando a variável)
}

# Cria o key pair

resource "aws_key_pair" "myhomelab_keypair" {
  key_name   = var.key_pair_aws  # Nome do key pair (utilizando a variável)
  public_key = file(var.key_pair_aws)  # Caminho para o arquivo de chave pública (utilizando a variável)
}
