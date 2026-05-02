variable "resource_group_name" {
  default = "TODELETE"
}

variable "name_sufix" {
  default = "jgch"
}

variable "location" {
  default = "West Europe"
}

variable "vm_size" {
  default = "Standard_D2s_v3"
}

variable "allowed_ports" {
  default     = ["22", "8080", "8081", "8082", "9000"]
}
