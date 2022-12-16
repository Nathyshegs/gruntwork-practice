resource "aws_instance" "example" {
    ami = "ami-0fb653ca2d3203ac1"
    instance_type = "t2.micro"
    vpc_security_group_ids = [ aws_security_group.instance.id]

    user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
    user_data_replace_on_change = true

    tags = {
        Name = "terraform-example"
    }
}

resource "aws_security_group" "instance" {
    name = "terraform-example-instance"
    description = "Allow inbound traffic"
    
    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        description = "This is the ingress security group"
        from_port = 8080
        protocol = "tcp"
        to_port = 8080
    }
  
}