terraform {
  cloud {
    organization = "deeeplom"

    workspaces {
      name = "stage"
    }
  }
}