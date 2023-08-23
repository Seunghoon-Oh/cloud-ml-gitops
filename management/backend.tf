terraform {
  backend "gcs" {
    bucket = "2301-25-tfstate"
    prefix = "mgmt"
  }
}
