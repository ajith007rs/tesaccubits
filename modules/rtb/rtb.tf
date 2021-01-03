resource "aws_route_table" "rs_rtb" {
    vpc_id = var.vpc_id

    route {
        cidr_block = var.rtb_ipv4_cidr
        gateway_id = var.igw_id
    }
}

output "out_rtb_id" {
    value = aws_route_table.rs_rtb.id
}
