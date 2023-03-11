#Start--------------------
  terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.55.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "eu-west=3"
  access_key = "AKIAU5TAEY3L2XPPHZRG"
  secret_key = "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" 
}

resource "aws_instance" "web"  {
  ami           = "ami-005e54dee72cc1d00"   #Need to confirm in Console--
  instance_type = "t2.micro"

  network_interface {
    network_interface_id = "network_id_from_aws"   #Need to confirm in Console--
    device_index         = 0
   
  
   #Not Sure About this one|----------------------------
    provisioner "remote-exec" {
    
    inline = [
    "sudo amazon-linux-extras install -y something",
    "sudo systemctl start nginx"
    ]
    #Not Sure About this one^--------------------------------------------------
    

    connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("F:\\PathToMyKeysFolder\\SomeValid_keypair.pem")   #Need to generate/confirm in Console--
    host = self.public_ip
    
    }
    
 }
  
  user_data = <<-EOL
  
  #!/bin/bash -xe

  sudo yum install -y yum-utils
  sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
  sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  sudo systemctl start docker
  sudo systemctl enable docker
  sudo docker pull myapp:latest
  sudo docker run --name myapp -p 80:80 -d myapp
  EOL

  
  }

}
