variable "token" {
  type        = string
  description = "Specifies the GitHub PAT token or `GITHUB_TOKEN`"
  sensitive   = true
}

variable "org_token" {
  type        = string
  description = "Specifies the GitHub PAT token or `GITHUB_TOKEN` of organization"
  sensitive   = true
}