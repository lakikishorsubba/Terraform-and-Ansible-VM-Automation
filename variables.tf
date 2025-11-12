variable "vms" {
  description = "Map of VM configurations"
  type = map(object({
    hostname = string
    ip       = string
    memory   = string
    cpus     = number
  }))
  default = {
    "4IT-1" = {
      hostname = "4IT-1"
      ip       = "192.168.56.10"
      memory   = "2048"
      cpus     = 2
    }
    "4IT-2" = {
      hostname = "4IT-2"
      ip       = "192.168.56.11"
      memory   = "2048"
      cpus     = 2
    }
  }
}

variable "box_image" {
  description = "Vagrant box image"
  type        = string
  default     = "ubuntu/jammy64"
}