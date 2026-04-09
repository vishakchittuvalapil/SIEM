variable "tenancy_ocid" {
  default = "ocid1.tenancy.oc1..aaaaaa"
}
variable "user_ocid" {
  default = "ocid1.user.oc1..aaaaaaaauula"
}
variable "fingerprint" {
  default = "a7:31:0a:70:ec:e2:"
}
variable "private_key_path" {
  default = "/Users/vchittuv/.oci/terraform.pem"
}
variable "region" {
  default = "us-ashburn-1"
}

variable "compartment_id" {
  default = "ocid1.compartment.oc1..aaaaaaaapj"
}


variable "stream_pool_name" {
  default = "vishak-private-stream-pool"
}

variable "stream_name" {
  default = "vishak-logging-stream"
}

variable "connector_name" {
  default = "vishak-logging-to-stream-connector"
}

variable "private_subnet_id" {
  default = "ocid1.subnet.oc1.iad.aaaaaaaah"
}

variable "private_endpoint_nsg_ids" {
  type    = list(string)
  default = []
}

variable "stream_partitions" {
  type    = number
  default = 1
}

variable "retention_in_hours" {
  type    = number
  default = 24
}
