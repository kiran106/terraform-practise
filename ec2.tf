 resource "aws_instance" "terraform-managed-server" {
     ami           = "ami-013168dc3850ef002"  # Specify an appropriate AMI ID
     instance_type = "t2.micro"
   }
  
