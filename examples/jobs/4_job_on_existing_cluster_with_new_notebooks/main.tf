provider "databricks" {
  host  = var.workspace_url
  token = var.dapi_token
}

terraform {
  required_providers {
    databricks = {
      source  = "databrickslabs/databricks"
      version = "~> 0.5.7"
    }
  }
}


module "databricks_workspace_management" {
  source = "git::git@github.com:databricks/terraform-databricks-workspace-management.git?ref=v0.2.11"
  # ------------------------------------------------
  # JOB
  # ------------------------------------------------
  deploy_jobs               = true
  cluster_id                = "0824-160733-mzd2ygdp"
  fixed_value               = 1
  retry_on_timeout          = false
  max_retries               = 3
  timeout                   = 30
  min_retry_interval_millis = 10
  max_concurrent_runs       = 1
  task_parameters = {
    "hello" = "world",
    "ping"  = "pong"
  }
  schedule = {
    cron_expression = "1 0 7 * * ?",
    timezone_id     = "America/Los_Angeles",
    pause_status    = "UNPAUSED"
  }
  email_notifications = {
    on_failure                = ["demo@demo.com"],
    no_alert_for_skipped_runs = true,
    on_start                  = ["demo@demo.com"],
    on_success                = ["demo@demo.com"]
  }
  # ------------------------------------------------
  # NOTEBOOK
  # ------------------------------------------------
  local_notebooks = [
    {
      job_name   = "local_demo_job1"
      language   = "PYTHON"
      local_path = "notebooks/sample1.py"
      path       = "/Shared/demo/sample1.py"
    }
  ]
  jobs_access_control = [
    {
      group_name       = "users"
      permission_level = "CAN_VIEW"
    }
  ]
  # ------------------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
