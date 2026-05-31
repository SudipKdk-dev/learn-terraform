resource "aws_key_pair" "my_key" {
  key_name   = "terra-key"
  public_key = file("terra-key.pub")
}  

resource "aws_default_vpc" "default" {  
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_security_group" "my-security-group" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_default_vpc.default.id #interpolation
  #inbound rule
    ingress{
        from_port=22
        to_port=22
        protocol="tcp"
        cidr_blocks=["0.0.0.0/0"]
        description="allow ssh access"
    }
    ingress{
        from_port=80
        to_port=80
        protocol="tcp"
        cidr_blocks=["0.0.0.0/0"]
        description="allow http access"
    }

  #outboud rule
    egress{
        from_port=0
        to_port=0
        protocol="-1"
        cidr_blocks=["0.0.0.0/0"]
        description="allow all outbound traffic"
    
    }
    tags    ={
        Name= "automate-sg"
    }
}
resource "aws_instance" "my_instance1" {
  key_name=aws_key_pair.my_key.key_name
  instance_type=var.ec2-instance-type
  vpc_security_group_ids=[aws_security_group.my-security-group.id]
  ami=var.ec2-ami-id

  root_block_device{
    volume_size = var.ec2-rootstorage-size
    volume_type="gp3"
  }
  tags={
    Name="my_instance"
  }

}
