variable "name" {
  description = "Enter Name"
  type        = string
 
  
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}