# ==========================================
# KOTAK 2: STORAGE (S3 BUCKET)
# ==========================================

resource "aws_s3_bucket" "app_storage" {
  bucket        = "elearning-storage-kelompok5-upr" 
  force_destroy = true 
}

resource "aws_s3_bucket_public_access_block" "app_storage_block" {
  bucket                  = aws_s3_bucket.app_storage.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "app_storage_lifecycle" {
  bucket = aws_s3_bucket.app_storage.id
  rule {
    id     = "arsip_otomatis_ke_glacier"
    status = "Enabled"
    filter {}
    transition {
      days          = 30
      storage_class = "GLACIER"
    }
  }
}

# ==========================================
# KOTAK 3: CLOUDFRONT CDN & BUCKET POLICY
# ==========================================

# 1. Origin Access Control (OAC)
resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "oac-elearning-kel5"
  description                       = "OAC untuk S3 Kelompok 5"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# 2. CloudFront Distribution (CDN & HTTPS Gratis)
resource "aws_cloudfront_distribution" "cdn" {
  origin {
    domain_name              = aws_s3_bucket.app_storage.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
    origin_id                = "S3-elearning-storage"
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-elearning-storage"
    
    # Memaksa koneksi jadi HTTPS (Syarat Ceklis 3 Kotak CDN)
    viewer_protocol_policy = "redirect-to-https" 
    
    forwarded_values {
      query_string = false
      cookies { forward = "none" }
    }
  }

  restrictions {
    geo_restriction { restriction_type = "none" }
  }

  viewer_certificate {
    cloudfront_default_certificate = true 
  }
  
  tags = { Name = "CDN E-Learning Kelompok 5" }
}

# 3. S3 Bucket Policy (PELUNASAN UTANG CEKLIS 2 KOTAK STORAGE)
resource "aws_s3_bucket_policy" "allow_cloudfront" {
  bucket = aws_s3_bucket.app_storage.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.app_storage.arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.cdn.arn
          }
        }
      }
    ]
  })
}