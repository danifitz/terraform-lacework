resource "aws_s3_bucket" "prod_website" {  
  bucket_prefix = "ndkandkfjdw48reue"
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "prod_website" {  
  bucket = aws_s3_bucket.prod_website.id

policy = <<POLICY
{    
    "Version": "2012-10-17",    
    "Statement": [        
      {            
          "Sid": "PublicReadGetObject",            
          "Effect": "Allow",            
          "Principal": "*",            
          "Action": [                
             "s3:GetObject"            
          ],            
          "Resource": [
             "arn:aws:s3:::${aws_s3_bucket.prod_website.id}/*"            
          ]        
      }    
    ]
}
POLICY
}