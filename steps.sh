terraform import aws_route53_record.main["*.arlo-co.com"] <zone_id>_<record_name>_<record_type>
terraform import aws_route53_record.main["arlo-co.com"] <zone_id>_<record_name>_<record_type>


terraform import 'aws_route53_record.main["arlo-co.com"]' Z08500163PLHE5UEV9QA4_arlo-co.com_A
terraform import 'aws_route53_record.main["arlo-co.com"]' Z08500163PLHE5UEV9QA4_arlo-co.com_NS
terraform import 'aws_route53_record.main["arlo-co.com"]' Z08500163PLHE5UEV9QA4_arlo-co.com_SOA
terraform import 'aws_route53_record.main["arlo-co.com"]' Z08500163PLHE5UEV9QA4__66412dad804574480ade617949fc5d7f.arlo-co.com_CNAME
terraform import 'aws_route53_record.main["arlo-co.com"]' Z08500163PLHE5UEV9QA4_www.arlo-co.com_A


terraform import aws_acm_certificate.ssl_certificate arn:aws:acm:us-east-1:471112606087:certificate/c874dcc0-3edc-44a5-8576-dacaccb2dc9c

terraform import aws_acm_certificate_validation.cert_validation arn:aws:cloudfront::471112606087:distribution/E1HIGE16GJELDJ
terraform import aws_acm_certificate_validation.cert_validation arn:aws:cloudfront::471112606087:distribution/E35G6ANT6H3J1
