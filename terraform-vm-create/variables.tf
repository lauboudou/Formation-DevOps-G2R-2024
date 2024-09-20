# Variáveis para o projeto MyHomeLab

# Variável para o bloco CIDR da VPC
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

# Variável para o bloco CIDR da sub-rede
variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  default     = "10.0.1.0/24"
}

# Variável para a AMI do Ubuntu
variable "ami_id" {
  description = "AMI ID for the instance"
  default     = "ami-08200e1ffcab6af77"  # Exemplo para Ubuntu
}

# Variável para o tipo de instância
variable "instance_type_medium" {
  description = "Instance type"
  default     = "t3.medium"
}

variable "instance_type_micro" {
  description = "Instance type"
  default     = "t3.micro"
}

# Variável para a região AWS
variable "aws_region" {
  description = "AWS Region"
  default     = "eu-north-1"
}

# Variável para o nome do grupo de segurança
variable "security_group_name" {
  description = "Nome do security group"
  default     = "myhomelab-sg"
}

# Variável para o nome da zona DNS
variable "dns_zone_name" {
  description = "The name of the DNS zone"
  default     = "myhomelab.com"  # Substitua pelo seu domínio
}

# Variavel para a key pair
variable "key_pair_aws" {
  description = "The name of the key pair"
  default     = "myhomelab-keypair"  # Substitua pelo nome da sua chave pública
}

# Variavel para o caminho da key pair
variable "key_pair_path" {
  description = "The path to the key pair"
  default     = "./aws-key.pub"  # Substitua pelo caminho da sua chave pública
}



