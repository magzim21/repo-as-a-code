terraform {
  required_version = ">= 1.14.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.33.0, < 7.0.0"
    }
    github = {
      source  = "integrations/github"
      version = ">= 6.0, < 7.0.0"
    }

    datadog = {
      source = "DataDog/datadog"
    }

  }
}

provider "datadog" {
  api_url = "https://us5.datadoghq.com/" # or DD_HOST
  # set DD_API_KEY
  # set DD_APP_KEY
}

