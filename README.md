<p align="center">
    <a href="https://github.com/tomarv2/terraform-databricks-workspace-management/actions/workflows/pre-commit.yml" alt="Pre Commit">
        <img src="https://github.com/tomarv2/terraform-databricks-workspace-management/actions/workflows/pre-commit.yml/badge.svg?branch=main" /></a>
    <a href="https://www.apache.org/licenses/LICENSE-2.0" alt="license">
        <img src="https://img.shields.io/github/license/tomarv2/terraform-databricks-workspace-management" /></a>
    <a href="https://github.com/tomarv2/terraform-databricks-workspace-management/tags" alt="GitHub tag">
        <img src="https://img.shields.io/github/v/tag/tomarv2/terraform-databricks-workspace-management" /></a>
    <a href="https://github.com/tomarv2/terraform-databricks-workspace-management/pulse" alt="Activity">
        <img src="https://img.shields.io/github/commit-activity/m/tomarv2/terraform-databricks-workspace-management" /></a>
    <a href="https://stackoverflow.com/users/6679867/tomarv2" alt="Stack Exchange reputation">
        <img src="https://img.shields.io/stackexchange/stackoverflow/r/6679867"></a>
    <a href="https://discord.gg/XH975bzN" alt="chat on Discord">
        <img src="https://img.shields.io/discord/813961944443912223?logo=discord"></a>
    <a href="https://twitter.com/intent/follow?screen_name=varuntomar2019" alt="follow on Twitter">
        <img src="https://img.shields.io/twitter/follow/varuntomar2019?style=social&logo=twitter"></a>
</p>

## Terraform module for [Databricks Workspace Management (Part 2)](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/guides/workspace-management)

> ❗️ **Important**
>
> :point_right: This Terraform module assumes you have [Databricks Workspace](https://github.com/tomarv2/terraform-databricks-workspace) already deployed.
>
> :point_right: Workspace URL
>
> :point_right: DAPI Token

## Versions

- Module tested for Terraform 0.14.
- `databrickslabs/databricks` provider version [0.3.3](https://registry.terraform.io/providers/databrickslabs/databricks/latest)
- AWS provider version [3.30.0](https://registry.terraform.io/providers/hashicorp/aws/latest).
- `main` branch: Provider versions not pinned to keep up with Terraform releases.
- `tags` releases: Tags are pinned with versions (use <a href="https://github.com/tomarv2/terraform-databricks-workspace-management/tags" alt="GitHub tag">
        <img src="https://img.shields.io/github/v/tag/tomarv2/terraform-databricks-workspace-management" /></a>).

---
![Databricks deployment](https://github.com/tomarv2/terraform-databricks-workspace-management/raw/main/docs/images/databricks-workspace-management.png)
---

## Usage

### Option 1:

```
terrafrom init
terraform plan -var='teamid=tryme' -var='prjid=project1'
terraform apply -var='teamid=tryme' -var='prjid=project1'
terraform destroy -var='teamid=tryme' -var='prjid=project1'
```
**Note:** With this option please take care of remote state storage

### Option 2:

#### Recommended method (store remote state in S3 using `prjid` and `teamid` to create directory structure):

- Create python 3.6+ virtual environment
```
python3 -m venv <venv name>
```

- Install package:
```
pip install tfremote
```

- Set below environment variables:
```
export TF_AWS_BUCKET=<remote state bucket name>
export TF_AWS_PROFILE=default
export TF_AWS_BUCKET_REGION=us-west-2
```

- Updated `examples` directory with required values.

- Run and verify the output before deploying:
```
tf -cloud aws plan -var='teamid=foo' -var='prjid=bar'
```

- Run below to deploy:
```
tf -cloud aws apply -var='teamid=foo' -var='prjid=bar'
```

- Run below to destroy:
```
tf -cloud aws destroy -var='teamid=foo' -var='prjid=bar'
```
**NOTE:**

- Read more on [tfremote](https://github.com/tomarv2/tfremote)
---

#### Databricks workspace management
```
module "databricks_workspace_management" {
  source = "git::git@github.com:tomarv2/terraform-databricks-workspace-management.git"

  workspace_url = "https://<workspace-url>.cloud.sample.com"
  dapi_token    = "dapi123456789012"
  notebook_path = "notebooks/sample.py"
  notebook_name = "demo"
  # -----------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
```

Please refer to examples directory [link](examples) for references.

## Coming up:

- [**Workspace Security - Job Permissions**](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/guides/workspace-management#part-2-workspace-security)
- [**Storage**](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/guides/workspace-management#part-3-storage)
- [**Advanced configuration**](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/guides/workspace-management#part-4-advanced-configuration)
- [**Init Script**](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/global_init_script)
