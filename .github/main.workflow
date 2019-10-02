action "build" {
  uses = "./actions/pwshbuild"
  secrets = []
}

workflow "pwshbuild" {
  resolves = ["./actions/pwshbuild"]
  on = "push"
}

action "./actions/pwshbuild" {
  uses = "./actions/pwshbuild"
}
