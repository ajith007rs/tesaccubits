provider "aws" {
    region                  = "us-east-1"
#   shared_credentials_file = "~/.aws/credential"  ## Credential File
    profile                 = "terraform"
}

# EC2 Instance
module "ec2" {
    source           = "./modules/ec2"
    ec2_ami          = "ami-0a0ad6b70e61be944"
    ec2_type         = "t2.micro"
    ec2_az           = "us-east-1a"
    ec2_key_name     = "tf_key"
    ec2_device_index = 0
    ec2_nic_id       = module.nic.out_nic_id
    ec2_name         = "tf_ec2"
}

# Security Group
module "sg" {
    source              = "./modules/sg"
    vpc_id              = module.vpc.out_vpc_id
    sg_ingress_cidr_ssh = "0.0.0.0/0"
    sg_name             = "tf_sg"
}

# Network Interface
module "nic" {
    source         = "./modules/nic"
    sub_id         = module.subnet.out_sub_id
    sg_id          = module.sg.out_sg_id
    nic_private_ip = "10.0.1.10"
    nic_name       = "tf_nic"
}

# VPC
module "vpc" {
    source   = "./modules/vpc"
    vpc_cidr = "10.0.0.0/16"
    vpc_name = "tf_vpc"

}

# Subnet
module "subnet" {
    source   = "./modules/subnet"
    vpc_id   = module.vpc.out_vpc_id
    sub_cidr = "10.0.1.0/24"
    sub_name = "tf_sub"
}


# Internet Gateway
module "igw" {
    source   = "./modules/igw"
    vpc_id   = module.vpc.out_vpc_id
    igw_name = "tf_igw"
}

# Route Table
module "rtb" {
    source   = "./modules/rtb"
    vpc_id   = module.vpc.out_vpc_id
    igw_id   = module.igw.out_igw_id
    rtb_name = "tf_rtb"
}

# Route Table Association
module "rtbas" {
    source = "./modules/rtbas"
    sub_id = module.subnet.out_sub_id
    rtb_id = module.rtb.out_rtb_id
}

# S3 Bucket
module "s3b" {
    source = "./modules/s3b"
    s3b_id = module.s3b.out_s3b.id
}


