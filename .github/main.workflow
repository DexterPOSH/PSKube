workflow "pwsh_build" {
  on = "push"
  resolves = ["build"]
}

action "build" {
  uses = "./actions/pwshbuild"
  secrets = [
    "TOKEN",
  ]
}

action "