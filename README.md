Goals for this project were:
Set up a S3 bucket
    - The bucket should be private
    - Encrypted using KMS
    - Configure an IAM user with an access key that allows us to list the contents of the bucket and download a specific file from the bucket.
    - The above IAM user/key should only be able to download the file when sourcing from the IP 40.143.42.12
    Bonus: Do the above using Terraform. Double Bonus: Use Terraform Cloud rather than local

Downloading file from AWS CLI
![aws](https://github.com/DerekFXu/S3-KMS-TFC/blob/main/images/aws.PNG?raw=true)

Terraform Cloud workspace
![TF](https://github.com/DerekFXu/S3-KMS-TFC/blob/main/images/TF.PNG?raw=true)
