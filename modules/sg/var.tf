variable "vpc_id" {
    type = string
}

variable "sg_ingress_cidr_http" {
    type    = string
    default = "0.0.0.0/0"
}

variable "sg_protocol" {
    type    = string
    default = "tcp"
}
