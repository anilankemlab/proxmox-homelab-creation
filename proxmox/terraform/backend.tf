terraform {
  backend "local" {
    # path = "terraform.tfstate" # Overridden by -state flag in CI/CD workflows
  }
}
