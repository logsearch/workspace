
0.  Setup your AWS credentials
```
export TF_VAR_access_key=$AWS_ACCESS_KEY_ID
export TF_VAR_secret_key=$AWS_SECRET_ACCESS_KEY
export TF_VAR_workspace_key_name="pcf"
export TF_VAR_workspace_subnet_id="subnet-fcd4838b" #pcf-public-az-a
export TF_VAR_workspace_security_group_id0="sg-2032c147" #workspace
export TF_VAR_workspace_security_group_id1="sg-6a1a080e" #stayup-pcf-VMs
export TF_VAR_workspace_security_group_id2="sg-65fa4302" #staff_office_ips

```
Make sure that you had `ssh-add`ed the key to your keychain

0. `/path/to/logsearch-workspace/_setup/terraform/aws-workspace$ terraform apply`  