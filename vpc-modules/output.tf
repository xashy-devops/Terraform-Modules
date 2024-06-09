output "myvpc-id" {
  description = "outputs the vpc id "  
  value = aws_vpc.myvpc.id
}

output "privsubnet1-id" {
  description = "outputs the first subnet id "
  value = aws_subnet.priv1-subnet.id
}

output "privsubnet2-id" {
  description = "outputs the id of priv subnet 2"
  value = aws_subnet.priv2-subnet.id
}

output "priv-rt-id" {
  description = "outputs the id of private rt"
  value = aws_route_table.priv-rt.id
}