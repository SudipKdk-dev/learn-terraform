variable "ec2-instance-type" {
  default ="t2.micro"
  description = "EC2 instance type"
}

 variable "ec2-rootstorage-size"{
    default = 10
    type =number
 }

variable "ec2-ami-id"{
    default = "ami-091138d0f0d41ff90"
    type = string
}