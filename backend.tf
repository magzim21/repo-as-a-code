terraform {
  cloud {
    organization = "magzim21"

    workspaces {
      name = "github"
    }
  }
}