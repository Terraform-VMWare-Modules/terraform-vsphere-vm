# ChanegLog

## Removed varsiables

```hcl
variable "network_cards" {
  description = ""
  type        = list(string)
  default     = null
}

variable "ipv4" {
  description = "host(VM) IP address in map format, support more than one IP. Should correspond to number of instances."
  type        = map
  default     = {}
}
```
