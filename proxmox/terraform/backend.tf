terraform {
  backend "local" {
    # path = "terraform.tfstate" # Overridden by backend-config in CI/CD workflows
  }
}
