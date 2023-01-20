variable "name" {
  description = "Enter Name"
  type        = string
 
  
}

variable "common_tags" {

  description = "common tags"
  type    = map
  default = {
  Ouner   = "Artur"
  Company = "Ayvazyan LLC"
  Enviroment = "dev"
  
  }
  
}