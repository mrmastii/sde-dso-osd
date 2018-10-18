###################### sde AWS
provider "aws" {
  version = "~> 1.0"
  region  = "${var.aws_region}"
}

provider "template" {
  version = "~> 1.0"
}

# Generate random UUID
resource "random_uuid" "stack_id" {}


data "template_file" "user_data" {
  template = "${file("templates/userdata.sh")}"
  vars {
    # Encrypt the user password for SDE with the specific Owner Name
    sde_password = "${lookup(var.sde_ssm_pass, var.environment)}/${var.owner}"
    sde_user = "${lookup(var.sde_ssm_user, var.environment)}/${var.owner}"
    fullchain = "dev-sde-fullchain"
    private_key = "dev-sde-pk"
    bucket_name = "dso-lab-priv-2018appseco"
  }
}

resource "aws_instance" "sde" {
  ami           = "${var.sde_ami}"
  instance_type = "${var.instance_type}"
  key_name = "${lookup(var.key_name, var.environment)}"
  monitoring = true
  security_groups = ["${var.sg_id}"]
  user_data = "${data.template_file.user_data.rendered}"
  iam_instance_profile = "${var.ecs_instance_profile}${var.environment}"
  associate_public_ip_address = true
  subnet_id = "${var.subnet_id}"

  tags {
    Name = "sde_${var.environment}_${var.owner}"
    Owner = "${var.owner}"
    Email = "${var.owner_email}"
    Environment = "${var.environment}"
  }
}

resource "aws_eip" "sde" {
  vpc = true
  instance                  = "${aws_instance.sde.id}"
  associate_with_private_ip = "${aws_instance.sde.private_ip}"
}

######################################################


################### route53

resource "aws_route53_record" "www" {
  zone_id = "${var.zone_id}"
  name    = "${var.owner}${lookup(var.short_env, var.environment)}.${var.dso_domain}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_eip.sde.public_ip}"]
}
