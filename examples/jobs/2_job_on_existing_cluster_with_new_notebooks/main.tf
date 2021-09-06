provider "databricks" {
  host  = var.workspace_url
  token = var.dapi_token
}

terraform {
  required_providers {
    databricks = {
      source  = "databrickslabs/databricks"
      version = "~> 0.3.5"
    }
  }
}


module "databricks_workspace_management" {
  source = "../../../"

  workspace_url = var.workspace_url
  dapi_token    = var.dapi_token
  # ------------------------------------------------
  # Job
  # ------------------------------------------------
  deploy_jobs               = true
  cluster_id                = "0906-195356-wants463"
  num_workers               = 1
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
  # Notebook
  # ------------------------------------------------
  local_notebooks = [
    {
      job_name   = "local_demo_job1"
      language   = "PYTHON"
      local_path = "notebooks/sample1.py"
      path       = "/Shared/demo/sample1.py"
    },
    {
      job_name   = "local_demo_job2"
      local_path = "notebooks/sample2.py"
    }
  ]
  # ------------------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}