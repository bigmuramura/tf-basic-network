resource "aws_sns_topic" "sns_topic" {
  name         = format("%s-notification", var.project_name)
  display_name = format("%s-notification", var.project_name)
  tags = {
    name = format("%s-notification", var.project_name)
  }
}
