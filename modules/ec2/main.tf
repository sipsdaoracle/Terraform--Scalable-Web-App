resource "aws_instance" "app" {
  ami           = var.ami_id
  instance_type = "var.instance_type"
  count         = var.instance_count
  subnet_id     = "var.subnet_id"

  tags = {
    Name = "${var.instance_name}-instance"
  }
  user_data = <<-EOF
#!/bin/bash
echo "Successfully Deployed...Well Done Sips!!" > index.html
nohup busybox httpd -f -p 8080 & 
EOF
user_data_replace_on_change = true
}