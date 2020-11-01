resource "aws_acm_certificate" "ecs_domain_certificate" {
  domain_name       = "*.${var.ecs_domain_name}"
  validation_method = "DNS"

  tags = {
    Name = "${var.ecs_cluster_name}-Certificate"
  }
}

data "aws_route53_zone" "ecs_domain" {
  name         = var.ecs_domain_name
  private_zone = false
}

# resource "aws_route53_record" "ecs_cert_validation_record" {
#   name            = "tolist(aws_acm_certificate.ecs_domain_certificate.domain_validation_options)[0].resource_record_name"
#   type            = "tolist(aws_acm_certificate.ecs_domain_certificate.domain_validation_options)[0].resource_record_type}"
#   zone_id         = data.aws_route53_zone.ecs_domain.zone_id
#   records         = [tolist(aws_acm_certificate.ecs_domain_certificate.domain_validation_options)[0].resource_record_value]
#   ttl             = 60
#   allow_overwrite = true
# }

# resource "aws_acm_certificate_validation" "ecs_domain_certificate_validation" {
#   certificate_arn         = aws_acm_certificate.ecs_domain_certificate.arn
#   validation_record_fqdns = [aws_route53_record.ecs_cert_validation_record.fqdn]
# }

resource "aws_route53_record" "ecs_cert_validation_record" {
  for_each = {
    for dvo in aws_acm_certificate.ecs_domain_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.ecs_domain.zone_id
}

resource "aws_acm_certificate_validation" "ecs_domain_certificate_validation" {
  certificate_arn         = aws_acm_certificate.ecs_domain_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.ecs_cert_validation_record : record.fqdn]
}