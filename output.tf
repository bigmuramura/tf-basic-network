output "project_name" {
  value = var.project_name
}

output "ec2_key" {
  value = var.ec2_key
}

output "public_subnet1_id" {
  value = aws_subnet.public-1.id
}
output "private_subnet1_id" {
  value = aws_subnet.private-1.id
}

output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}
output "ad_sg_id" {
  value = aws_security_group.ad_sg.id
}

output "sns_topic_id" {
  value = aws_sns_topic.sns_topic.id
}
