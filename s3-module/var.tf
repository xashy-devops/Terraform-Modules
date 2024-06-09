variable "bucketcount" {
  description = "numberofbuckets"
  type = number
}

# # variable "buckettags" {
#   description = "Tags to be applied to the bucket"
#   type = map(string)
# }

variable "versioning" {
  description = "Whether to enable versioning or not..to enable versioning put Enabled, to disable versioning put Disabled"
  type = string
}

variable "appname" {
  description = "Application-name"
  type = string
}

variable "env" {
  description = "Environment"
  type = string
}

variable "sensitive" {
  description = "is the bucket for sensitive data"
  type = bool
  default = true
}


variable "makebucketpublic" {
  description = "make bucket public or not "
  type = bool 
  default = false
}

variable "auditing" {
  description = "Enable Auditing for bucket, this would turn on object lock"
  type = bool
  default = true
}

variable "enableloging" {
  description = "enable server acess logging for bucket"
}