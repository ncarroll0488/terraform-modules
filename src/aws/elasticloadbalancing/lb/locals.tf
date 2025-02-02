locals {
  listener_forwarding = { for k, v in var.listener_forwarding : k => zipmap(v[*]["name"], v[*]["value"]) }
}
