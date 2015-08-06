
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
0. Make sure your IP is listed in the `staff_office_ips` security group
0. Make sure that you had `ssh-add`ed the key to your keychain

0. `/path/to/logsearch-workspace/_setup/terraform/aws-workspace$ terraform apply`  


## Tricks

0.  Use `terraform taint aws_volume_attachment.workspace_ebs_att` to re-run just the provision.sh script

```
_setup/terraform/aws-workspace$ terraform taint aws_volume_attachment.workspace_ebs_att
The resource aws_volume_attachment.workspace_ebs_att in the module root has been marked as tainted!
_setup/terraform/aws-workspace$ terraform apply
...snip...
aws_volume_attachment.workspace_ebs_att: Provisioning with 'remote-exec'...
```