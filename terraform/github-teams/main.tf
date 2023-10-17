terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.3"
    }
  }
}

provider "github" {
  owner = var.org_token
  token = var.token
}

resource "github_repository" "devops-lab4-teams" {
  name          = "devops-lab4-teams"
  description   = ""
  visibility    = "public"
  has_issues    = false
  has_wiki      = true
  auto_init     = true
  has_downloads = true
  has_projects  = true
}

resource "github_branch_default" "main" {
  repository = github_repository.devops-lab4-teams.name
  branch     = "main"
}

resource "github_team" "dev" {
  name        = "dev"
  description = "dev"
  privacy     = "closed"
}

resource "github_team" "devops" {
  name        = "devops"
  description = "devops"
  privacy     = "closed"
}

resource "github_team_repository" "dev_devops-lab4-teams" {
  team_id    = github_team.dev.id
  repository = github_repository.devops-lab4-teams.name
  permission = "push"
}

resource "github_team_repository" "devops_devops-lab4-teams" {
  team_id    = github_team.devops.id
  repository = github_repository.devops-lab4-teams.name
  permission = "maintain"
}